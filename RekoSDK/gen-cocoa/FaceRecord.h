//
//  FaceRecord.h
//  StacheCam
//
//  Created by Tianqiang Liu on 1/6/13.
//
//

#import <Foundation/Foundation.h>
#import "transport/TSocketClient.h"
#import "transport/TNSFramedTransport.h"
#import "protocol/TBinaryProtocol.h"

@class TrainingServerClient;

@interface FaceRecord : NSObject{
    NSMutableArray * guess_list;
    NSMutableDictionary * prob_hash;
    NSMutableDictionary * guess_count_hash;
    NSInteger  image_num;
    NSString * name;
    NSNumber * prob;
    NSNumber * age;
    NSNumber * sex;
    NSNumber * beauty;
    bool isset;
}
- (void) finalizeFaceRecord;
- (void) name: (NSString *)guess_name
         prob: (NSNumber *)guess_prob;
- (void) age: (NSNumber *)guess_age beauty: (NSNumber *)guess_beauty sex: (NSNumber *)guess_sex;
- (bool) isFinalized;
- (NSString *) getName;
- (NSNumber *) getProb;
- (NSNumber *) getAge;
- (NSNumber *) getBeauty;
- (NSNumber *) getSex;
- (NSInteger) getImageNum;
@end

@interface FaceDatabase : NSObject{
    char * dataset[100];
    int32_t image_lengths[100];
    NSInteger  image_num;
    NSString * tag;
    NSInteger threshold;
    TrainingServerClient * trainning_server;
    NSInteger call_counter;
    bool istrainning;
}
- (void) IP: (NSString *)ipAddress
       port: (int)port;
- (void) addNewFaceToDatabase: (char *)buffer bufSize: (int32_t)buf_size;
- (void) setTrainTag: (NSString *)tag;
- (void) train;

@property (strong, nonatomic) NSMutableDictionary * face_list;
@end

