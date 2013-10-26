//
//  FaceRecord.m
//  StacheCam
//
//  Created by Tianqiang Liu on 1/6/13.
//
//

#import "transport/TTransportException.h"

#import "FaceRecord.h"
#import "OrbeusSTL.h"
#import "ImageTrain.h"

@implementation FaceRecord

-(id) init{
    guess_list = [[NSMutableArray alloc] init];
    prob_hash  = [[NSMutableDictionary alloc] init];
    guess_count_hash = [[NSMutableDictionary alloc] init];
    image_num = 0;
    name = @"recognizing";
    prob = [NSNumber numberWithFloat:0];
    age = [NSNumber numberWithFloat:0];
    beauty = [NSNumber numberWithFloat:0];
    sex = [NSNumber numberWithFloat:0];
    isset = FALSE;
    return [super init];
}

-(void) finalizeFaceRecord
{
 /*   if(image_num>10 && !isset){
        isset = TRUE;
    }
    else{
        return;
    }*/
}

- (void) name: (NSString *)guess_name
         prob: (NSNumber *)guess_prob
{
    if (isset) {
        return;
    }
    if( [prob_hash valueForKey:guess_name] != nil ){
        NSInteger counter = [[guess_count_hash objectForKey:guess_name] integerValue];
        float cur_prob = [[prob_hash objectForKey:guess_name] floatValue];
        [prob_hash setValue:[NSNumber numberWithFloat: (cur_prob * counter + [guess_prob floatValue])/(counter+1)] forKey:guess_name];
        [guess_count_hash setValue:[NSNumber numberWithInteger:counter+1 ] forKey:guess_name];
    }
    else{
        [guess_list addObject:guess_name];
        [prob_hash setValue:[NSNumber numberWithFloat:[guess_prob floatValue]] forKey:guess_name];
        [guess_count_hash setValue:[NSNumber numberWithInteger: 1] forKey:guess_name];
    }
    NSMutableArray * guess_prob_list = [[NSMutableArray alloc] init];
    for ( NSInteger i = 0; i < [guess_list count]; i++ ) {
        NSString * guess_name_1 = [guess_list objectAtIndex:i];
        [guess_prob_list insertObject:[prob_hash objectForKey:guess_name_1] atIndex:i];
    }
    if([guess_prob_list count]==0){
        name = @"untrained";
        prob = [NSNumber numberWithFloat:-1];
    }
    else{
        OrbeusSTL * orbeusSTL = [[OrbeusSTL alloc] init];
        name = [guess_list objectAtIndex:[orbeusSTL findIndexOfMaxElement: guess_prob_list]];
        prob = [prob_hash objectForKey:name];
        NSLog(@"%@:%@", name, prob);
    }
}

- (void) age: (NSNumber *)guess_age beauty: (NSNumber *)guess_beauty sex: (NSNumber *)guess_sex;
{
    if (isset) {
        return;
    }
    age = [NSNumber numberWithFloat:([guess_age floatValue] +[age floatValue] * image_num )/(image_num+1)];
    beauty = [NSNumber numberWithFloat:([guess_beauty floatValue]+[beauty floatValue] * image_num )/(image_num + 1)];
    sex = [NSNumber numberWithFloat:([guess_sex floatValue]+[sex floatValue] * image_num)/( image_num + 1)] ;
    image_num++;
}

- (bool) isFinalized
{
    return isset;
}

- (NSString *) getName
{
    return name;
}

-(NSNumber *) getProb
{
    return prob;
}

- (NSNumber *) getAge
{
    return age;
}

- (NSNumber *) getBeauty
{
    return beauty;
}

- (NSNumber *) getSex
{
    return sex;
}

- (NSInteger) getImageNum
{
    return image_num;
}

@end

@implementation FaceDatabase
@synthesize face_list;
-(id) init{
    threshold = 10;
    face_list = [[NSMutableDictionary alloc] init];
    image_num = 0;
    tag = @"";
    istrainning = FALSE;
    call_counter = 0;
    [self IP:@"50.97.247.115" port:7778];
    return [super init];
}

- (void) IP: (NSString *)ipAddress
       port: (int)port
{
    TSocketClient *transport = [[TSocketClient alloc] initWithHostname:ipAddress port:port];
    TNSFramedTransport *framedtransport = [[TNSFramedTransport alloc] initWithTransport:transport];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:framedtransport strictRead:YES strictWrite:YES];
    trainning_server = [[TrainingServerClient alloc] initWithProtocol:protocol];
}


- (void) addNewFaceToDatabase: (char *)buffer bufSize: (int32_t)buf_size
{
    if([tag isEqual: @""]){
        return;
    }
    dataset[image_num] = (char *)malloc(sizeof(char)*buf_size);
    memcpy(dataset[image_num], buffer, buf_size);
    image_lengths[image_num] = buf_size;
    image_num++;
}

- (void) setTrainTag: (NSString *)train_tag
{
    tag = train_tag;
}

- (void) train
{
    if([tag isEqual: @""] && image_num>10){
        return;
    }
    AddPhotoRequest * msg = [[AddPhotoRequest alloc] init];
    msg.api_id = @"1234";
    msg.name_space = @"klik";
    msg.user_id = @"test2";
    msg.rawimages = dataset;
    msg.rawimage_lengths = image_lengths;
    msg.rawimage_num = image_num;
    msg.face_detecion = 1;
    
    NSMutableArray * tags = [[NSMutableArray alloc] init];
    for( int i = 0; i < image_num; i++ ){
        [tags addObject:tag];
    }
    msg.tags = tags;
    
    @try {
        [trainning_server AddPhoto:msg];
    }
    @catch (NSException *exception) {
        NSLog(@"Train Error!");
        return;
    }
    for( int i = 0; i < image_num; i++ ){
        if (dataset[i]) {
            free(dataset[i]);
        }
    }
    image_num = 0;
    
    TrainRequest * train_msg = [[TrainRequest alloc] init];
    train_msg.api_id = @"1234";
    train_msg.name_space = @"klik";
    train_msg.user_id = @"test2";
    [trainning_server Train:train_msg];
    
    tag = @"";
}
@end
