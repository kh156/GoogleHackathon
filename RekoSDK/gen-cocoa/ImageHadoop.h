//
//  ImageHadoop.h
//  Orbeus v0.2
//
//  Created by Tianqiang Liu on 1/5/12.
//  Copyright (c) 2012 Orbeus. All rights reserved.
//
#import <Availability.h>
#import <AVFoundation/AVFoundation.h>

#ifndef __IPHONE_4_0
#warning "This project uses features only available in iOS SDK 4.0 and later."
#endif

#ifdef __cplusplus
#import "../opencv2/opencv.hpp"
#import "../opencv2/imgproc/imgproc.hpp"
#import "../opencv2/highgui/highgui.hpp"
#import "../opencv2/core/core.hpp"
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

#import "OrbeusSTL.h"
#import "transport/TSocketClient.h"
#import "transport/TNSFramedTransport.h"
#import "protocol/TBinaryProtocol.h"
#import "PeterRequest.h"
#import "ImageTrain.h"
#import "FaceRecord.h"

@class LBDispatcherClient;
@class VisualRequest;

enum {
    tFace_detection   = 0,
    tBody_detection   = 1,
    tLogo_detection   = 2,
    tOCR   = 3
};


@interface ImageHadoopMetadata: NSObject

@property (nonatomic) NSInteger faceID;
@property (nonatomic) CGRect bounds;
@property (nonatomic) CGFloat rollAngle;

@end


@interface Object : NSObject
@property (nonatomic) float x;             //X Coordinate
@property (nonatomic) float y;             //Y Coordinate
@property (nonatomic) float width;         //Width
@property (nonatomic) float height;        //Height
@property (nonatomic) float prob;          //Likelihood
@property (nonatomic) float el_x;          //Left eye
@property (nonatomic) float el_y;          //Left eye
@property (nonatomic) float er_x;          //Right eye
@property (nonatomic) float er_y;          //Right eye
@property (nonatomic) float n_x;           //Nose
@property (nonatomic) float n_y;           //Nose
@property (nonatomic) float ml_x;          //Mouse Left
@property (nonatomic) float ml_y;          //Mouse Left
@property (nonatomic) float mr_x;          //Mouse Right
@property (nonatomic) float mr_y;          //Mouse Right
@property (nonatomic) float age;           //Age
@property (nonatomic) float sm;            //Emotion
@property (nonatomic) float g;             //Glass
@property (nonatomic) float ec;            //Eyes close
@property (nonatomic) float m;             //mouth open
@property (nonatomic) float b;             //Beauty
@property (nonatomic) float sex;           //Gender
@property (nonatomic) NSString * title;    //Name
@property (nonatomic) float ppl_prob;      //People Likelihood
@end

@interface ObjectList : NSObject{
    int objcount;
    int type;
}

@property (strong, nonatomic) NSMutableDictionary * sceneDict;
@property (strong, nonatomic) NSMutableArray * pObjList;
- (void) parseFaceResult: (NSString *)tokenstr
            faceDatabase: (FaceDatabase *)face_database
                  faceid: (NSInteger) faceID
                 faceobj: (ImageHadoopMetadata *) object
                   image: (char *)buffer
                 bufSize: (int32_t)buf_size
                 isTrain: (bool) train_flag
                     tag: (NSString *)train_tag
             sampleCount: (NSInteger) sample_cnt;
- (void) parseSceneResult:(NSString *)tokenstr;
- (void) increaseObjectCount;
@end


@protocol ImageHadoopDelegate <NSObject>
-(void)retrievedQuery:(NSArray *)resultList faceid:(NSNumber*) faceID;
@end


@interface ImageHadoop:NSObject {
    LBDispatcherClient * server;
    VisualRequest * msg;
    VisualResponse * resp;
    
    NSArray * joblist;
    NSMutableArray * mostFrequentObjs;
    OrbeusSTL * orbeusSTL;
}

-(void) IP:(NSString *)ipAddress
        port:(int)port;
- (void) serverRelease;
-(NSString *) queryScene: (UIImage *)qimage;
-(void) queryImage: (UIImage *) qimage faceinfo: (NSArray *) faces  faceList: (FaceDatabase *)face_database isTrain: (bool) train_flag tag: (NSString *)train_tag sampleCount: (NSInteger) sample_cnt;
#ifdef __cplusplus
-(cv::Mat)cvMatWithImage:(UIImage *)image;
-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
#endif
-(UIImage *) getFaceImage: (AVMetadataFaceObject *)face originImage: (UIImage *) originImage
           picOrientation: (AVCaptureVideoOrientation) avcaptureOrientation;
@property (nonatomic, strong) NSArray *joblist;
@property (strong, nonatomic) NSMutableArray * objListSet;
@property (weak, nonatomic) NSObject<ImageHadoopDelegate>* delegate;
@end
