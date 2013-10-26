//
//  RKPostJobs.m
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/20/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import "ReKognitionAsyncSDK.h"
#import <CoreFoundation/CoreFoundation.h>

#import "NSDictionary+HTTPBody.h"
#import "Base64.h"
#import "UIImageResize+Rotate.h"



@implementation ReKognitionAsyncSDK{
    CFMutableDictionaryRef connectionToInfoMapping;
}

@synthesize delegate = _delegate,
            receivedData = _receivedData;

static NSString *API_Key = @"l0FMFsRneeyIKmDC";
static NSString *API_Secret = @"eDxwgCxPwIak9t3K";

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
    }
    return self;
}

- (void) postAsynchrnousReKognitionJobs:(NSDictionary *) jobsDictionary{
    
    // NSDictionary to HttpBody
    NSData *data = [jobsDictionary dataUsingEncoding:NSASCIIStringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [request setTimeoutInterval:20];

    NSString *url = @"http://rekognition.com/func/api/";
    [request setURL:[NSURL URLWithString:url]];

    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
//     connectionToInfoMapping = CFDictionaryCreateMutable(
//                              kCFAllocatorDefault,
//                              0,
//                              &kCFTypeDictionaryKeyCallBacks,
//                              &kCFTypeDictionaryValueCallBacks);
//    CFDictionaryAddValue(connectionToInfoMapping,
//                         (__bridge const void *)(theConnection),
//                         (__bridge const void *)([NSMutableDictionary
//                          dictionaryWithObject:[NSMutableData data]
//                          forKey:@"receivedData"]));
    
    [theConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    [theConnection start];
    
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Server Connection"
                                                        message:@"Fail to establish connection"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Server Connection"
                                                    message:[@"Fail with error" stringByAppendingFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSMutableDictionary *connectionInfo =
//    CFDictionaryGetValue(connectionToInfoMapping, connection);
//    [[connectionInfo objectForKey:@"receivedData"] appendData:data];
    
    self.receivedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", self.receivedData);
    [self.delegate receiveResponse];
}

// ReKognition Face Detect Function
- (void) RKFaceDetect: (UIImage*) image
                      scale: (CGFloat) scale
{
    if (scale < 1){
        image  = [UIImage imageWithImage:image scaledToSize: CGSizeMake(image.size.width * scale, image.size.height * scale)];
    }
    
    //fix the orintation of the image, commment out the following line if not needed
    image = [image fixOrientation];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [Base64 initialize];
    NSString *encodedString = [Base64 encode:imageData];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    // Specify ReKognition parameters, please use your own API_Key and API_Secret
    NSDictionary * jobsDictionary = [[NSDictionary alloc] initWithObjects:@[API_Key,
                                     API_Secret,
                                     @"face_part_aggressive_age_glass_gender",
                                     encodedString
                                     ]
                                     forKeys:@[@"api_key",
                                     @"api_secret",
                                     @"jobs",
                                     @"base64"
                                     ]];
    return [self postAsynchrnousReKognitionJobs:jobsDictionary];
}

// ReKognition Face Add Function
- (void) RKFaceAdd: (UIImage*) image
                   scale: (CGFloat) scale
               nameSpace: (NSString *) name_space
                  userID: (NSString *) user_id
                     tag:(NSString *) tag;
{
    
    if (scale < 1){
        image  = [UIImage imageWithImage:image scaledToSize: CGSizeMake(image.size.width * scale, image.size.height * scale)];
    }
    
    //fix the orintation of the image, commment out the following line if not needed
    image = [image fixOrientation];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [Base64 initialize];
    NSString *encodedString = [Base64 encode:imageData];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString *tagString = [@"face_add_" stringByAppendingFormat:@"[%@]", tag];
    
    NSDictionary * jobsDictionary = [[NSDictionary alloc] initWithObjects:@[API_Key,
                                     API_Secret,
                                     tagString,
                                     name_space,
                                     user_id,
                                     encodedString
                                     ] forKeys:@[@"api_key",
                                     @"api_secret",
                                     @"job_list",
                                     @"name_space",
                                     @"user_id",
                                     @"base64"
                                     ]];
    
    return [self postAsynchrnousReKognitionJobs:jobsDictionary];
    
}

@end
