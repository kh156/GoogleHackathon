//
//  RKPostJobs.h
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/20/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol receiveResponseDelegate <NSObject>
- (void) receiveResponse;
@end


@interface ReKognitionAsyncSDK : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) id <receiveResponseDelegate> delegate;
@property (strong, nonatomic) NSString * receivedData;

// ReKognition Post Jobs Function (to customize your own recognition functions)
- (void) postAsynchrnousReKognitionJobs:(NSDictionary *) jobsDictionary;

// ReKognition Face Detect Function (the image you want to recognize and the scaling factor for the image)
- (void) RKFaceDetect: (UIImage*) image
                      scale: (CGFloat) scale;

// ReKognition Face Add Function (for more details of name_space and user_id please go to reKognition.com and check out the API docs)
- (void) RKFaceAdd: (UIImage*) image
                   scale: (CGFloat) scale
               nameSpace: (NSString *) name_space
                  userID: (NSString *) user_id
                     tag: (NSString *) tag;


@end
