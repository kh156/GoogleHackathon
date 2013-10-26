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


@interface AddPhotoRequest : NSObject <NSCoding> {
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSArray * __tags;
  char   ** __rawimages;
  int32_t * __rawimage_lengths;
  int32_t __rawimage_num;
  NSArray * __imagefeatures;
  double __margin;
  double __face_detecion;
  NSArray * __urls;
  NSArray * __file_name;
  NSString * __feature_type;
  NSString * __training_mode;
  NSString * __ext;

  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __tags_isset;
  BOOL __rawimages_isset;
  BOOL __rawimage_lengths_isset;
  BOOL __rawimage_num_isset;
  BOOL __imagefeatures_isset;
  BOOL __margin_isset;
  BOOL __face_detecion_isset;
  BOOL __urls_isset;
  BOOL __file_name_isset;
  BOOL __feature_type_isset;
  BOOL __training_mode_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, getter=rawimages, setter=setRawimages:) char ** rawimages;
@property (nonatomic, getter=rawimage_lengths, setter=setRawimage_lengths:) int32_t * rawimage_lengths;
@property (nonatomic, getter=rawimage_num, setter=setRawimage_num:) int32_t rawimage_num;
@property (nonatomic, retain, getter=imagefeatures, setter=setImagefeatures:) NSArray * imagefeatures;
@property (nonatomic, getter=margin, setter=setMargin:) double margin;
@property (nonatomic, getter=face_detecion, setter=setFace_detecion:) double face_detecion;
@property (nonatomic, retain, getter=urls, setter=setUrls:) NSArray * urls;
@property (nonatomic, retain, getter=file_name, setter=setFile_name:) NSArray * file_name;
@property (nonatomic, retain, getter=feature_type, setter=setFeature_type:) NSString * feature_type;
@property (nonatomic, retain, getter=training_mode, setter=setTraining_mode:) NSString * training_mode;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithApi_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id tags: (NSArray *) tags rawimages: (char **) rawimages rawimage_lengths: (int32_t *) rawimage_lengths rawimage_num: (int32_t) rawimage_num imagefeatures: (NSArray *) imagefeatures margin: (double) margin face_detecion: (double) face_detecion urls: (NSArray *) urls file_name: (NSArray *) file_name feature_type: (NSString *) feature_type training_mode: (NSString *) training_mode ext: (NSString *) ext;

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

- (char **) rawimages;
- (void) setRawimages: (char **) rawimages;
- (BOOL) rawimagesIsSet;

- (int32_t *) rawimage_lengths;
- (void) setRawimage_lengths: (int32_t *) rawimage_lengths;
- (BOOL) rawimage_lengthsIsSet;

- (int32_t) rawimage_num;
- (void) setRawimage_num: (int32_t) rawimage_num;
- (BOOL) rawimage_numIsSet;

- (NSArray *) imagefeatures;
- (void) setImagefeatures: (NSArray *) imagefeatures;
- (BOOL) imagefeaturesIsSet;

- (double) margin;
- (void) setMargin: (double) margin;
- (BOOL) marginIsSet;

- (double) face_detecion;
- (void) setFace_detecion: (double) face_detecion;
- (BOOL) face_detecionIsSet;

- (NSArray *) urls;
- (void) setUrls: (NSArray *) urls;
- (BOOL) urlsIsSet;

- (NSArray *) file_name;
- (void) setFile_name: (NSArray *) file_name;
- (BOOL) file_nameIsSet;

- (NSString *) feature_type;
- (void) setFeature_type: (NSString *) feature_type;
- (BOOL) feature_typeIsSet;

- (NSString *) training_mode;
- (void) setTraining_mode: (NSString *) training_mode;
- (BOOL) training_modeIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface TrainRequest : NSObject <NSCoding> {
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSArray * __tags;
  NSString * __feature_type;
  NSString * __training_mode;
  NSString * __ext;

  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __tags_isset;
  BOOL __feature_type_isset;
  BOOL __training_mode_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, retain, getter=feature_type, setter=setFeature_type:) NSString * feature_type;
@property (nonatomic, retain, getter=training_mode, setter=setTraining_mode:) NSString * training_mode;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithApi_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id tags: (NSArray *) tags feature_type: (NSString *) feature_type training_mode: (NSString *) training_mode ext: (NSString *) ext;

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

- (NSString *) training_mode;
- (void) setTraining_mode: (NSString *) training_mode;
- (BOOL) training_modeIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface RecognizeRequest : NSObject <NSCoding> {
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSArray * __imagefeatures;
  char     ** __rawimages;
  int32_t  * __rawimage_lengths;
  NSArray * __tags;
  NSString * __feature_type;
  NSString * __training_mode;
  NSString * __ext;

  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __imagefeatures_isset;
  BOOL __rawimages_isset;
  BOOL __rawimage_lengths_isset;
  BOOL __tags_isset;
  BOOL __feature_type_isset;
  BOOL __training_mode_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=imagefeatures, setter=setImagefeatures:) NSArray * imagefeatures;
@property (nonatomic, getter=rawimages, setter=setRawimages:) char ** rawimages;
@property (nonatomic, getter=rawimage_lengths, setter=setRawimage_lengths:) int32_t * rawimage_lengths;
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, retain, getter=feature_type, setter=setFeature_type:) NSString * feature_type;
@property (nonatomic, retain, getter=training_mode, setter=setTraining_mode:) NSString * training_mode;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithApi_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id imagefeatures: (NSArray *) imagefeatures rawimages: (char **) rawimages rawimage_lengths: (int32_t *) rawimage_lengths tags: (NSArray *) tags feature_type: (NSString *) feature_type training_mode: (NSString *) training_mode ext: (NSString *) ext;

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

- (NSArray *) imagefeatures;
- (void) setImagefeatures: (NSArray *) imagefeatures;
- (BOOL) imagefeaturesIsSet;

- (char **) rawimages;
- (void) setRawimages: (char **) rawimages;
- (BOOL) rawimagesIsSet;

- (int32_t *) rawimage_lengths;
- (void) setRawimage_lengths: (int32_t *) rawimage_lengths;
- (BOOL) rawimage_lengthsIsSet;

- (NSArray *) tags;
- (void) setTags: (NSArray *) tags;
- (BOOL) tagsIsSet;

- (NSString *) feature_type;
- (void) setFeature_type: (NSString *) feature_type;
- (BOOL) feature_typeIsSet;

- (NSString *) training_mode;
- (void) setTraining_mode: (NSString *) training_mode;
- (BOOL) training_modeIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface RecognizeResponse : NSObject <NSCoding> {
  NSArray * __tags;
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSString * __ext;

  BOOL __tags_isset;
  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithTags: (NSArray *) tags api_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id ext: (NSString *) ext;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (NSArray *) tags;
- (void) setTags: (NSArray *) tags;
- (BOOL) tagsIsSet;

- (NSString *) api_id;
- (void) setApi_id: (NSString *) api_id;
- (BOOL) api_idIsSet;

- (NSString *) name_space;
- (void) setName_space: (NSString *) name_space;
- (BOOL) name_spaceIsSet;

- (NSString *) user_id;
- (void) setUser_id: (NSString *) user_id;
- (BOOL) user_idIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface DatasetShowRequest : NSObject <NSCoding> {
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSArray * __tags;
  NSString * __options;
  NSString * __ext;

  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __tags_isset;
  BOOL __options_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, retain, getter=options, setter=setOptions:) NSString * options;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithApi_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id tags: (NSArray *) tags options: (NSString *) options ext: (NSString *) ext;

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

- (NSString *) options;
- (void) setOptions: (NSString *) options;
- (BOOL) optionsIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface DatasetShowResponse : NSObject <NSCoding> {
  NSArray * __raw_image_urls;
  NSArray * __tags;
  NSArray * __image_names;
  NSString * __ext;

  BOOL __raw_image_urls_isset;
  BOOL __tags_isset;
  BOOL __image_names_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=raw_image_urls, setter=setRaw_image_urls:) NSArray * raw_image_urls;
@property (nonatomic, retain, getter=tags, setter=setTags:) NSArray * tags;
@property (nonatomic, retain, getter=image_names, setter=setImage_names:) NSArray * image_names;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithRaw_image_urls: (NSArray *) raw_image_urls tags: (NSArray *) tags image_names: (NSArray *) image_names ext: (NSString *) ext;

- (void) read: (id <TProtocol>) inProtocol;
- (void) write: (id <TProtocol>) outProtocol;

- (NSArray *) raw_image_urls;
- (void) setRaw_image_urls: (NSArray *) raw_image_urls;
- (BOOL) raw_image_urlsIsSet;

- (NSArray *) tags;
- (void) setTags: (NSArray *) tags;
- (BOOL) tagsIsSet;

- (NSArray *) image_names;
- (void) setImage_names: (NSArray *) image_names;
- (BOOL) image_namesIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@interface DeletePhotoRequest : NSObject <NSCoding> {
  NSString * __api_id;
  NSString * __name_space;
  NSString * __user_id;
  NSString * __tag;
  NSArray * __image_names;
  NSString * __ext;

  BOOL __api_id_isset;
  BOOL __name_space_isset;
  BOOL __user_id_isset;
  BOOL __tag_isset;
  BOOL __image_names_isset;
  BOOL __ext_isset;
}

#if TARGET_OS_IPHONE || (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_5)
@property (nonatomic, retain, getter=api_id, setter=setApi_id:) NSString * api_id;
@property (nonatomic, retain, getter=name_space, setter=setName_space:) NSString * name_space;
@property (nonatomic, retain, getter=user_id, setter=setUser_id:) NSString * user_id;
@property (nonatomic, retain, getter=tag, setter=setTag:) NSString * tag;
@property (nonatomic, retain, getter=image_names, setter=setImage_names:) NSArray * image_names;
@property (nonatomic, retain, getter=ext, setter=setExt:) NSString * ext;
#endif

- (id) initWithApi_id: (NSString *) api_id name_space: (NSString *) name_space user_id: (NSString *) user_id tag: (NSString *) tag image_names: (NSArray *) image_names ext: (NSString *) ext;

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

- (NSString *) tag;
- (void) setTag: (NSString *) tag;
- (BOOL) tagIsSet;

- (NSArray *) image_names;
- (void) setImage_names: (NSArray *) image_names;
- (BOOL) image_namesIsSet;

- (NSString *) ext;
- (void) setExt: (NSString *) ext;
- (BOOL) extIsSet;

@end

@protocol TrainingServer <NSObject>
- (void) AddPhoto: (AddPhotoRequest *) req;  // throws TException
- (void) Train: (TrainRequest *) req;  // throws TException
- (void) DeletePhoto: (DeletePhotoRequest *) req;  // throws TException
- (RecognizeResponse *) Recognize: (RecognizeRequest *) req;  // throws TException
- (DatasetShowResponse *) DatasetShow: (DatasetShowRequest *) req;  // throws TException
@end

@interface TrainingServerClient : NSObject <TrainingServer> {
  id <TProtocol> inProtocol;
  id <TProtocol> outProtocol;
}
- (id) initWithProtocol: (id <TProtocol>) protocol;
- (id) initWithInProtocol: (id <TProtocol>) inProtocol outProtocol: (id <TProtocol>) outProtocol;
@end

@interface TrainingServerProcessor : NSObject <TProcessor> {
  id <TrainingServer> mService;
  NSDictionary * mMethodMap;
}
- (id) initWithTrainingServer: (id <TrainingServer>) service;
- (id<TrainingServer>) service;
@end

@interface ImageTrainConstants : NSObject {
}
@end
