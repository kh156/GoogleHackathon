//
//  RekoPipe.m
//  RekoSDK
//
//  Created by Kuang Han on 10/26/13.
//
//

#import "RekoPipe.h"
#import "ReKognitionSDK.h"

static NSString *apiKey = @"DP6gbHBVOApautzt";
static NSString *apiSecret = @"biHMoMnjQIUD3OQj";

@implementation RekoPipe


- (NSDictionary *)processImages:(NSArray *)urls {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
    for (int i = 0; i < [urls count]; i++) {
        NSString *URL = [urls objectAtIndex:i];
        NSArray *components = [URL componentsSeparatedByString:@" url='"];
        
        NSString *afterOpenBracket = [components objectAtIndex:1];
        
        components = [afterOpenBracket componentsSeparatedByString:@"'"];
        
        NSString *imageStr = [components objectAtIndex:0];
        
//        NSLog(@"url = %@", imageStr);
        ReKognitionSDK *sdk = [[ReKognitionSDK alloc] initWithAPIKey:apiKey APISecret:apiSecret];
        RKSceneUnderstandingResults *scene = [sdk RKSceneUnderstandingWithUrl:[NSURL URLWithString:imageStr]];
        RKFaceDetectResults *face = [sdk RKFaceDetectWithUrl:[NSURL URLWithString:imageStr] jobs:FaceDetectGender|FaceDetectEmotion|FaceDetectRace|FaceDetectAge|FaceDetectSmile];
//        
//        NSString *emotionTag = ((FaceDetectItem *)face.faceDetectOrALikeItems[0]).matched_emotions
//        NSArray *detection = [face objectForKey:@"face_detection"];
//        if (detection && [detection count] > 0) {
//            NSString *emotionTag = [[[[detection firstObject] objectForKey:@"emotion"] allKeys] firstObject];
//            NSMutableArray *emotionArray = [dict objectForKey:emotionTag];
//            if (!emotionArray) {
//                emotionArray = [NSMutableArray arrayWithCapacity:10];
//                [dict setObject:emotionArray forKey:emotionTag];
//            }
//            [emotionArray addObject:[NSNumber numberWithInt:i]];
//        }
//        NSArray *understanding = [scene objectForKey:@"scene_understanding"];
//        if (understanding && [understanding count] > 0) {
//            NSString *sceneTag = [[understanding firstObject] objectForKey:@"label"];
//            NSMutableArray *sceneArray = [dict objectForKey:sceneTag];
//            if (!sceneArray) {
//                sceneArray = [NSMutableArray arrayWithCapacity:10];
//                [dict setObject:sceneArray forKey:sceneTag];
//            }
//            [sceneArray addObject:[NSNumber numberWithInteger:i]];
//        }
    }
    return dict;
}

@end
