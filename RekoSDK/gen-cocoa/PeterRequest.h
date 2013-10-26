/**
 * Autogenerated by Thrift Compiler (0.8.0)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */

#import <Foundation/Foundation.h>

#import "TProtocol.h"
#import "TApplicationException.h"
#import "TProtocolUtil.h"
#import "TProcessor.h"
#import "transport/TTransportException.h"


@interface FaceRecognizeRequest : NSObject <NSCoding> {
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSArray * __tags;
  NSString * __feature_type;
  NSString * __mode;
  NSString * __ext;

  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __tags_isset;
  BOOL __feature_type_isset;
  BOOL __mode_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, retain, getter=feature_type, setter=setFeature_type:) NSString * feature_type;
@property (nonatomic, retain, getter=mode, setter=setMode:) NSString * mode;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithApi_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id tags: (NSArray *) tags feature_type: (NSString *) feature_type mode: (NSString *) mode ext: (NSString *) ext;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (NSString *) api_id;
- (void) setApi_id: (NSString *) api_id;
- (BOOL) api_idIsSet;

- (NSString *) name_space;
- (void) setName_space: (NSString *) name_space;
- (BOOL) name_spaceIsSet;

- (NSString *) user_id;
- (void) setUser_id: (NSString *) user_id;
- (BOOL) user_idIsSet;

- (NSArray *) tags;
- (void) setTags: (NSArray *) tags;
- (BOOL) tagsIsSet;

- (NSString *) feature_type;
- (void) setFeature_type: (NSString *) feature_type;
- (BOOL) feature_typeIsSet;

- (NSString *) mode;
- (void) setMode: (NSString *) mode;
- (BOOL) modeIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface VisualRequest : NSObject <NSCoding> {
  NSString * __rawimage;
  NSArray * __jobs;
  int32_t __time_sent;
  NSString * __url;
  NSString * __format;
  int32_t __height;
  int32_t __width;
  NSString * __user_ID;
  NSString * __ext;
  FaceRecognizeRequest * __recognize_request;
  char * __rawimage_utf8Bytes;
  int32_t __rawimage_length;

  BOOL __rawimage_isset;
  BOOL __jobs_isset;
  BOOL __time_sent_isset;
  BOOL __url_isset;
  BOOL __format_isset;
  BOOL __height_isset;
  BOOL __width_isset;
  BOOL __user_ID_isset;
  BOOL __ext_isset;
  BOOL __recognize_request_isset;
  BOOL __rawimage_utf8Bytes_isset;
  BOOL __rawimage_length_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=rawimage, setter=setRawimage:) NSString * rawimage;
@property (nonatomic, retain, getter=jobs, setter=setJobs:) NSArray * jobs;
@property (nonatomic, getter=time_sent, setter=setTime_sent:) int32_t time_sent;
@property (nonatomic, retain, getter=url, setter=setUrl:) NSString * url;
@property (nonatomic, retain, getter=format, setter=setFormat:) NSString * format;
@property (nonatomic, getter=height, setter=setHeight:) int32_t height;
@property (nonatomic, getter=width, setter=setWidth:) int32_t width;
@property (nonatomic, retain, getter=user_ID, setter=setUser_ID:) NSString * user_ID;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
@property (nonatomic, retain, getter=recognize_request, setter=setRecognize_request:) FaceRecognizeRequest * recognize_request;
@property (nonatomic, getter=rawimage_utf8Bytes, setter=setRawimage_utf8Bytes:) char * rawimage_utf8Bytes;
@property (nonatomic, getter=rawimage_length, setter=setRawimage_length:) int32_t rawimage_length;
#endif

- (id) initWithRawimage: (NSString *) rawimage jobs: (NSArray *) jobs time_sent: (int32_t) time_sent url: (NSString *) url format: (NSString *) format height: (int32_t) height width: (int32_t) width user_ID: (NSString *) user_ID ext: (NSString *) ext recognize_request: (FaceRecognizeRequest *) recognize_request;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (NSString *) rawimage;
- (void) setRawimage: (NSString *) rawimage;
- (BOOL) rawimageIsSet;

- (NSArray *) jobs;
- (void) setJobs: (NSArray *) jobs;
- (BOOL) jobsIsSet;

- (int32_t) time_sent;
- (void) setTime_sent: (int32_t) time_sent;
- (BOOL) time_sentIsSet;

- (NSString *) url;
- (void) setUrl: (NSString *) url;
- (BOOL) urlIsSet;

- (NSString *) format;
- (void) setFormat: (NSString *) format;
- (BOOL) formatIsSet;

- (int32_t) height;
- (void) setHeight: (int32_t) height;
- (BOOL) heightIsSet;

- (int32_t) width;
- (void) setWidth: (int32_t) width;
- (BOOL) widthIsSet;

- (NSString *) user_ID;
- (void) setUser_ID: (NSString *) user_ID;
- (BOOL) user_IDIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

- (FaceRecognizeRequest *) recognize_request;
- (void) setRecognize_request: (FaceRecognizeRequest *) recognize_request;
- (BOOL) recognize_requestIsSet;

- (char *) rawimage_utf8Bytes;
- (void) setRawimage_utf8Bytes: (char *) rawimage_utf8Bytes;
- (BOOL) rawimage_utf8BytesIsSet;

- (int32_t) rawimage_length;
- (void) setRawimage_length: (int32_t) rawimage_length;
- (BOOL) rawimage_lengthIsSet;

@end

@interface VisualResponse : NSObject <NSCoding> {
  NSArray * __jobs;
  NSArray * __analysis_result;
  NSString * __rawimage;
  int32_t __time_sent;
  NSArray * __time_spent_each_job;
  NSString * __url;
  NSString * __format;
  int32_t __height;
  int32_t __width;
  NSString * __ext;
  int32_t __time_finished;
  int32_t __cpu_load;

  BOOL __jobs_isset;
  BOOL __analysis_result_isset;
  BOOL __rawimage_isset;
  BOOL __time_sent_isset;
  BOOL __time_spent_each_job_isset;
  BOOL __url_isset;
  BOOL __format_isset;
  BOOL __height_isset;
  BOOL __width_isset;
  BOOL __ext_isset;
  BOOL __time_finished_isset;
  BOOL __cpu_load_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=jobs, setter=setJobs:) NSArray * jobs;
@property (nonatomic, retain, getter=analysis_result, setter=setAnalysis_result:) NSArray * analysis_result;
@property (nonatomic, retain, getter=rawimage, setter=setRawimage:) NSString * rawimage;
@property (nonatomic, getter=time_sent, setter=setTime_sent:) int32_t time_sent;
@property (nonatomic, retain, getter=time_spent_each_job, setter=setTime_spent_each_job:) NSArray * time_spent_each_job;
@property (nonatomic, retain, getter=url, setter=setUrl:) NSString * url;
@property (nonatomic, retain, getter=format, setter=setFormat:) NSString * format;
@property (nonatomic, getter=height, setter=setHeight:) int32_t height;
@property (nonatomic, getter=width, setter=setWidth:) int32_t width;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
@property (nonatomic, getter=time_finished, setter=setTime_finished:) int32_t time_finished;
@property (nonatomic, getter=cpu_load, setter=setCpu_load:) int32_t cpu_load;
#endif

- (id) initWithJobs: (NSArray *) jobs analysis_result: (NSArray *) analysis_result rawimage: (NSString *) rawimage time_sent: (int32_t) time_sent time_spent_each_job: (NSArray *) time_spent_each_job url: (NSString *) url format: (NSString *) format height: (int32_t) height width: (int32_t) width ext: (NSString *) ext time_finished: (int32_t) time_finished cpu_load: (int32_t) cpu_load;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (NSArray *) jobs;
- (void) setJobs: (NSArray *) jobs;
- (BOOL) jobsIsSet;

- (NSArray *) analysis_result;
- (void) setAnalysis_result: (NSArray *) analysis_result;
- (BOOL) analysis_resultIsSet;

- (NSString *) rawimage;
- (void) setRawimage: (NSString *) rawimage;
- (BOOL) rawimageIsSet;

- (int32_t) time_sent;
- (void) setTime_sent: (int32_t) time_sent;
- (BOOL) time_sentIsSet;

- (NSArray *) time_spent_each_job;
- (void) setTime_spent_each_job: (NSArray *) time_spent_each_job;
- (BOOL) time_spent_each_jobIsSet;

- (NSString *) url;
- (void) setUrl: (NSString *) url;
- (BOOL) urlIsSet;

- (NSString *) format;
- (void) setFormat: (NSString *) format;
- (BOOL) formatIsSet;

- (int32_t) height;
- (void) setHeight: (int32_t) height;
- (BOOL) heightIsSet;

- (int32_t) width;
- (void) setWidth: (int32_t) width;
- (BOOL) widthIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

- (int32_t) time_finished;
- (void) setTime_finished: (int32_t) time_finished;
- (BOOL) time_finishedIsSet;

- (int32_t) cpu_load;
- (void) setCpu_load: (int32_t) cpu_load;
- (BOOL) cpu_loadIsSet;

@end

@protocol LBDispatcher <NSObject>
- (VisualResponse *) Analyse: (VisualRequest *) req;  // throws TException
@end

@interface LBDispatcherClient : NSObject <LBDispatcher> {
  id <TProtocol> inProtocol;
  id <TProtocol> outProtocol;
}
- (void) expdDealloc;
- (id) initWithProtocol: (id <TProtocol>) protocol;
- (id) initWithInProtocol: (id <TProtocol>) inProtocol outProtocol: (id <TProtocol>) outProtocol;
@end

@interface LBDispatcherProcessor : NSObject <TProcessor> {
  id <LBDispatcher> mService;
  NSDictionary * mMethodMap;
}
- (id) initWithLBDispatcher: (id <LBDispatcher>) service;
- (id<LBDispatcher>) service;
@end

@protocol VisualAnalsisService <NSObject>
- (VisualResponse *) Analyse: (VisualRequest *) req;  // throws TException
@end

@interface VisualAnalsisServiceClient : NSObject <VisualAnalsisService> {
id <TProtocol> inProtocol;
id <TProtocol> outProtocol;
}
- (id) initWithProtocol: (id <TProtocol>) protocol;
- (id) initWithInProtocol: (id <TProtocol>) inProtocol outProtocol: (id <TProtocol>) outProtocol;
@end

@interface VisualAnalsisServiceProcessor : NSObject <TProcessor> {
id <VisualAnalsisService> mService;
NSDictionary * mMethodMap;
}
- (id) initWithVisualAnalsisService: (id <VisualAnalsisService>) service;
- (id<VisualAnalsisService>) service;
@end

@interface PeterRequestConstants : NSObject {
}
@end