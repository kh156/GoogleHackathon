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
        NSString *imageStr = [urls objectAtIndex:i];
        
        NSLog(@"url = %@", imageStr);
        ReKognitionSDK *sdk = [[ReKognitionSDK alloc] initWithAPIKey:apiKey APISecret:apiSecret];
        RKSceneUnderstandingResults *scene = [sdk RKSceneUnderstandingWithUrl:[NSURL URLWithString:imageStr]];
        RKFaceDetectResults *face = [sdk RKFaceDetectWithUrl:[NSURL URLWithString:imageStr] jobs:FaceDetectEmotion|FaceDetectSmile|FaceDetectRace|FaceDetectGender|FaceDetectAge];
        
        if ([face.faceDetectOrALikeItems count] > 0) {
            FaceDetectItem *person = face.faceDetectOrALikeItems[0];
            if (person.sex > 0.46) {
                [self setTagValue:dict tag:@"Men" index:i];
            } else {
                [self setTagValue:dict tag:@"Women" index:i];
            }
            if (person.smile > 0.1) {
                [self setTagValue:dict tag:@"Smile" index:i];
            }
            if (person.age < 10) {
                [self setTagValue:dict tag:@"Kids" index:i];
            } else if (person.age > 50) {
                [self setTagValue:dict tag:@"Old People" index:i];
            }
            [self setTagValue:dict tag:person.matched_races[0] index:i];
            [self setTagValue:dict tag:person.matched_emotions[0] index:i];
        }
        
        for (int j = 0; j < [scene.matched_scenes count]; j++) {
            float score = [scene.matched_scene_scores[j] floatValue];
            if (score > 0.1) {
                NSString *sceneTag = scene.matched_scenes[j];
                [self setTagValue:dict tag:sceneTag index:i];
            }
        }
    }
    NSLog(@"%@", dict);
    return dict;
}


- (void)setTagValue:(NSMutableDictionary *)dict tag:(NSString *)tag index:(NSInteger)index {
    NSMutableArray *array = dict[tag];
    if (!array) {
        array = [NSMutableArray arrayWithCapacity:10];
        [dict setObject:array forKey:tag];
    }
    [array addObject:[NSNumber numberWithInteger:index]];
}

@end
