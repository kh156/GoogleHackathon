//
//  ImageHadoop.m
//  Orbeus v0.2
//
//  Created by Guest1 on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#ifdef __cplusplus

#import "ImageHadoop.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>

using namespace std;
using namespace cv;

@implementation Object

@synthesize x = _x;
@synthesize y = _y;
@synthesize width = _width;
@synthesize height = _height;
@synthesize prob = _prob;
@synthesize el_x = _el_x;
@synthesize el_y = _el_y;
@synthesize er_x = _er_x;
@synthesize er_y = _er_y;
@synthesize n_x = _n_x;
@synthesize n_y = _n_y;
@synthesize ml_x = _ml_x;
@synthesize ml_y = _ml_y;
@synthesize mr_x = _mr_x;
@synthesize mr_y = _mr_y;
@synthesize age = _age;
@synthesize sm = _sm;
@synthesize g = _g;
@synthesize ec = _ec;
@synthesize m = _m;
@synthesize b = _b;
@synthesize sex = _sex;
@synthesize title = _title;
@synthesize ppl_prob = _ppl_prob;

@end

@implementation ImageHadoop
@synthesize objListSet;
@synthesize joblist;
@synthesize delegate = _delegate;


-(Mat)cvMatWithImage:(UIImage *)image
{
    CGImageRef cgImage = image.CGImage;
    BOOL releaseCGImage = NO;
    if (!cgImage) {
        CIContext *context = [CIContext contextWithOptions:nil];
        cgImage = [context createCGImage:image.CIImage fromRect:image.CIImage.extent];
        releaseCGImage = YES;
    }
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
    CGColorSpaceRetain(colorSpace);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to backing data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), cgImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    if (releaseCGImage) {
        CGImageRelease(cgImage);
    }
    return cvMat;
}


-(Mat) cropImageAdvanced: (Mat) originMat
                  region: (cv::Rect) rect
{
    Mat newMat(rect.width, rect.height, originMat.type());
    for( int i = 0; i < newMat.rows; i++ ){
        for( int j = 0; j < newMat.cols; j++ ){
            if(  rect.x + j >= 0 && rect.x + j < originMat.cols && rect.y + i >= 0 && rect.y + i < originMat.rows ){
                newMat.at<Vec4b>(i,j) = originMat.at<Vec4b>(rect.y + i,rect.x + j);
            }
            else{
                newMat.at<Vec4b>(i,j) = Vec4b(0,0,0,0);
            }
        }
    }
    return newMat;
}


-(Mat) getFaceMat: (ImageHadoopMetadata *)face originImage: (Mat) originMat
{
    CGFloat x = face.bounds.origin.x;
    CGFloat y = face.bounds.origin.y;
    CGFloat width = face.bounds.size.width;
    CGFloat height = face.bounds.size.height;
    Mat cropped = [self cropImageAdvanced:originMat region:cv::Rect(originMat.cols * x,
                                                                    originMat.rows * y,
                                                                    originMat.cols * width,
                                                                    originMat.rows * height)];
//    [self saveTestImage:[self imageWithCVMat:cropped]];
    
    Point2f center;
    center.x = cropped.cols / 2;
    center.y = cropped.rows / 2;
    
    Mat M = getRotationMatrix2D(center, face.rollAngle, 1.0);
    Mat rotated;
    warpAffine(cropped, rotated, M, cropped.size(), INTER_CUBIC);
    
    resize(rotated, rotated, cv::Size(150,150));
    
//    [self saveTestImage:[self imageWithCVMat:rotated]];
    return rotated;
}


- (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
    
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                        cvMat.rows,                                     // Height
                                        8,                                              // Bits per component
                                        8 * cvMat.elemSize(),                           // Bits per pixel
                                        cvMat.step[0],                                  // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent
    
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return image;
}


-(void)saveTestImage:(UIImage *)image {
    CGImageRef cgImage = image.CGImage;
    BOOL releaseCGImage = NO;
    if (!cgImage) {
        CIContext *context = [CIContext contextWithOptions:nil];
        cgImage = [context createCGImage:image.CIImage fromRect:image.CIImage.extent];
        releaseCGImage = YES;
    }
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImage
                              orientation:0
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              if (releaseCGImage) {
                                  CGImageRelease(cgImage);
                              }
                          }];
}


-(void) queryImage: (UIImage *) qimage faceinfo: (NSArray *) faces faceList: (FaceDatabase *)face_database isTrain: (bool) train_flag tag: (NSString *)train_tag sampleCount: (NSInteger) sample_cnt
{
    msg = [[VisualRequest alloc] init];
    Mat imgmat;
    
    imgmat = [self cvMatWithImage:qimage];
    cvtColor(imgmat, imgmat, CV_RGBA2BGRA);
    
    vector<int> param;
    param.push_back(CV_IMWRITE_JPEG_QUALITY);
    param.push_back(95);
    
    for (ImageHadoopMetadata * object in faces ) {
		NSNumber* faceID = [NSNumber numberWithInteger:object.faceID];
        if([face_database.face_list objectForKey:[faceID stringValue]]==nil){
            [face_database.face_list setObject:[[FaceRecord alloc] init] forKey:[faceID stringValue]];
        }
        
        Mat faceMat;
        if (object.bounds.size.width != 0) {
            faceMat = [self getFaceMat:object originImage:imgmat];
        } else {
            faceMat = imgmat;
        }
        vector<uchar> buff;
        imencode(".jpg", faceMat, buff, param);
        
        objListSet = [[NSMutableArray alloc] init];
        
        FaceRecognizeRequest * face_recognition_msg = [[FaceRecognizeRequest alloc] init];
        face_recognition_msg.api_id = @"1234";
        face_recognition_msg.name_space = @"klik";
        face_recognition_msg.user_id = @"test2";
        face_recognition_msg.feature_type = @"raw";
        [msg setRecognize_request:face_recognition_msg];
        msg.rawimage_utf8Bytes = (char *)&buff[0];
        msg.rawimage_length = (int32_t)buff.size();
        msg.jobs = [NSArray arrayWithArray:joblist];
        msg.height = qimage.size.height;
        msg.width = qimage.size.width;
        msg.ext = @"1111.jpg";
        resp = [server Analyse:msg];
        
        int32_t jobsnum = [joblist count];
        for (int i = 0; i < jobsnum; i++ ) {
            ObjectList * objList = [[ObjectList alloc] init];
            [objList parseFaceResult:[resp.analysis_result objectAtIndex:i]
                        faceDatabase: face_database
                              faceid: [faceID integerValue]
                             faceobj: object
                               image: (char *)&buff[0]
                             bufSize: (int32_t)buff.size()
                             isTrain: train_flag
                                 tag: train_tag
                         sampleCount: sample_cnt];
            [objListSet addObject:objList];
        }
        
        faceMat.release();
        [self.delegate retrievedQuery:objListSet faceid:faceID];
    }
    imgmat.release();
}


-(void) IP:(NSString *)ipAddress
      port:(int)port
{
    TSocketClient *transport = [[TSocketClient alloc] initWithHostname:ipAddress port:port];
    TNSFramedTransport *framedtransport = [[TNSFramedTransport alloc] initWithTransport:transport];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:framedtransport strictRead:YES strictWrite:YES];
    server = [[LBDispatcherClient alloc] initWithProtocol:protocol];
}

- (void) serverRelease
{
    [server expdDealloc];
}

- (id)init{
    orbeusSTL = [[OrbeusSTL alloc] init];
    return [super init];
}

@end

@implementation ObjectList

@synthesize pObjList = _pObjList;

- (float) face_coord: (float)x face_len: (float)w callback: (float)x_n{
    return (x - 0.5 * w) + (w * x_n)/100.0;
}

- (void) increaseObjectCount
{
    objcount++;
}



- (void) parseFaceResult: (NSString *)tokenstr
            faceDatabase: (FaceDatabase *)face_database
                  faceid: (NSInteger) faceID
                 faceobj: (ImageHadoopMetadata *) object
                   image: (char *)buffer
                 bufSize: (int32_t)buf_size
                 isTrain: (bool) train_flag
                     tag: (NSString *)train_tag
             sampleCount: (NSInteger) sample_cnt
{
    
    //    NSLog(@"tokenstr = %@", tokenstr);
    
    NSArray *lines = [tokenstr componentsSeparatedByString:@"\n"];
    objcount = [lines count]-1;
    if (!objcount) {
        return;
    }
    self.pObjList = [[NSMutableArray alloc] init];
    NSEnumerator *enumerator = [lines objectEnumerator];
    id obj;
    int i = 0;
    while (obj = [enumerator nextObject]) {
        NSMutableArray * entries = [[NSMutableArray alloc] init];
        [entries addObjectsFromArray:[obj componentsSeparatedByString:@";"]];
        
        Object *cur_obj = [[Object alloc] init];
        
        //FaceRecord * face_record = [face_database.face_list objectForKey:[[NSNumber numberWithInteger:faceID] stringValue]];
        
        NSMutableArray * pos_entries = [[NSMutableArray alloc] init];
        [pos_entries addObjectsFromArray:[[entries objectAtIndex:0] componentsSeparatedByString:@" "]];
        cur_obj.x = [self face_coord: object.bounds.origin.x face_len: object.bounds.size.width callback: [[pos_entries objectAtIndex:0] floatValue]];
        cur_obj.y = [self face_coord: object.bounds.origin.y face_len: object.bounds.size.height callback: [[pos_entries objectAtIndex:1] floatValue]];
        cur_obj.width  = [[pos_entries objectAtIndex:2] floatValue];
        cur_obj.height = [[pos_entries objectAtIndex:3] floatValue];
        cur_obj.prob = [[pos_entries objectAtIndex:4] floatValue];
        
        
//        NSLog(@"pos_entries = %@", pos_entries);
//        NSLog(@"entries = %@", entries);
        
        float b_callback, age_callback, sex_callback;
        
        for (NSString * str in entries){
            if ([str rangeOfString:@"b:"].location != NSNotFound) {
                b_callback = [[[str componentsSeparatedByString:@":"] objectAtIndex:1] floatValue];
            }
            if ([str rangeOfString:@"age:"].location != NSNotFound) {
                age_callback = [[[str componentsSeparatedByString:@":"] objectAtIndex:1] floatValue];
            }
            if ([str rangeOfString:@"sex:"].location != NSNotFound) {
                sex_callback = [[[str componentsSeparatedByString:@":"] objectAtIndex:1] floatValue];
            }
        }
        
        cur_obj.age = age_callback;
        cur_obj.b = b_callback;
        cur_obj.sex   = sex_callback;
        
        [self.pObjList addObject:cur_obj];
        i++;
        if (i == objcount) {
            break;
        }
    }
}

-(id) init{
    objcount = 0;
    self.pObjList = nil;
    return [super init];
}
@end


@implementation ImageHadoopMetadata


@end

#endif