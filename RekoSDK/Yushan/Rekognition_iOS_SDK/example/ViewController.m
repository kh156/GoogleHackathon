//
//  ViewController.m
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/18/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import "ViewController.h"
#import "Base64.h"
#import "ReKognitionSDK.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController (){
    NSMutableArray * rekoResult;
    NSMutableArray * googleSampleImage;
}

@end

@implementation ViewController

- (IBAction)btnReKognizeImageClicked:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose the following..."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Face Detection",
                                  @"Scene Understanding",
                                  nil];
    
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.alpha = 0.80;
	actionSheet.tag = 2;
	[actionSheet showInView:self.view];
}

- (IBAction)btnSelectImageClicked:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallary", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.alpha = 0.80;
	actionSheet.tag = 1;
	[actionSheet showInView:self.view];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"ReKognition Example";
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    labelView.hidden = YES;
    activityIndicator.hidesWhenStopped = YES;
    rekoResult  = [[NSMutableArray alloc] init];
    googleSampleImage = [[NSMutableArray alloc] init];
    [self fetchdata];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            for(int i = 0; i<[googleSampleImage count]; i++){
                NSArray *components = [[googleSampleImage objectAtIndex:i] componentsSeparatedByString:@" url='"];
                NSString *afterOpenBracket = [components objectAtIndex:1];
                components = [afterOpenBracket componentsSeparatedByString:@"'"];
                NSString *numberString = [components objectAtIndex:0];
                [self syncFaceDetect: numberString];
            }
        }
            break;
        case 1:
        {
            
            for(int i = 0; i<[googleSampleImage count]; i++){
                NSArray *components = [[googleSampleImage objectAtIndex:i] componentsSeparatedByString:@" url='"];
                NSString *afterOpenBracket = [components objectAtIndex:1];
                components = [afterOpenBracket componentsSeparatedByString:@"'"];
                NSString *numberString = [components objectAtIndex:0];
                [self syncSceneUnderstanding: numberString];
            }
        }
            break;
    }
    
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    
    imageView.image  = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%d", imageView.image.imageOrientation);
    NSLog(@"%f %f", imageView.image.size.width, imageView.image.size.height);
    
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *) ParseJSONResult:(NSString *)resultString
{
    NSData * data = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:0
                     error:&error];
        
        if(error) { /* JSON was malformed, act appropriately here */ }
        
        // the originating poster wants to deal with dictionaries;
        // assuming you do too then something like this is the first
        // validation step:
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = object;
            return results;
            
            /* proceed with results as you like; the assignment to
             an explicit NSDictionary * is artificial step to get
             compile-time checking from here on down (and better autocompletion
             when editing). You could have just made object an NSDictionary *
             in the first place but stylistically you might prefer to keep
             the question of type open until it's confirmed */
        }
        else
        {
            /* there's no guarantee that the outermost object in a JSON
             packet will be a dictionary; if we get here then it wasn't,
             so 'object' shouldn't be treated as an NSDictionary; probably
             you need to report a suitable error condition */
            return nil;
        }
    }else{
        return nil;
    }
    
}

-(void) clearRecognitionResults{
    labelView.text = @"";
    labelView.hidden = YES;
    if(imageView.layer.sublayers)
        [imageView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, labelView.frame.size.width, labelView.frame.size.height + 78);
    
}

-(void) receiveResponse{
    NSDictionary* results = [self ParseJSONResult: asyncSDK.receivedData];
    NSLog(@"detectResultString = %@", results);
    NSMutableArray * array = [results objectForKey:@"face_detection"];
    for(int i = 0; i < [array count]; i++){
        if ([[[array objectAtIndex:i] objectForKey:@"confidence"] floatValue] > 0.1){
 
        }
    }
}

- (void) syncSceneUnderstanding: (NSString *) imageUrl{
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    dispatch_async(queue, ^{
        NSString* sceneResultString = [ReKognitionSDK postReKognitionJobsByUrl:@"scene" imageUrl:imageUrl];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDictionary* results = [self ParseJSONResult:sceneResultString];
            NSLog(@"%@", results);
            [rekoResult addObject:results];
            if([rekoResult count] == [googleSampleImage count]){
                NSLog(@"%@", rekoResult);
            }
        });
    });
}

- (void) syncFaceDetect: (NSString *) imageUrl{
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    dispatch_async(queue, ^{
        NSString* sceneResultString = [ReKognitionSDK postReKognitionJobsByUrl:@"face_detect" imageUrl:imageUrl];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDictionary* results = [self ParseJSONResult:sceneResultString];
            NSLog(@"%@", results);
            [rekoResult addObject:results];
            if([rekoResult count] == [googleSampleImage count]){
                NSLog(@"%@", rekoResult);
            }
        });
    });
}

-(void) fetchdata{
    NSString *str=@"https://picasaweb.google.com/data/feed/api/all?q=flower%20pictures&max-results=1000";
    NSURL *url=[NSURL URLWithString:str];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSString * responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // NSLog(@"Your Picasa string %@", responseStr);
    
    NSArray *components = [responseStr componentsSeparatedByString:@"<media:content"];
    for (NSString * str in components){
        NSString *afterOpenBracket = str;
        components = [afterOpenBracket componentsSeparatedByString:@"/>"];
        NSString *numberString = [components objectAtIndex:0];
        [googleSampleImage addObject:numberString];
    }
    [googleSampleImage removeObjectAtIndex:0];
    
    
}


@end


