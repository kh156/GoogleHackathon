//
//  DropboxImageLoader.h
//  RekoSDK
//
//  Created by Kuang Han on 10/26/13.
//
//

#import <Foundation/Foundation.h>

@protocol DropboxImageLoaderDelegate <NSObject>
@optional
- (void)allImageUrlsLoaded:(NSArray *)imageUrls succeed:(BOOL)succeed contentChanged:(BOOL)change;
- (void)thumbnailsLoaded:(NSArray *)images;
- (void)allImageLoaded:(NSArray *)images succeed:(BOOL)succeed contentChanged:(BOOL)change;
- (void)newImageUrlLoaded:(NSURL *)imageUrl index:(NSInteger)index;
@end


@interface DropboxImageLoader : NSObject
@property (strong, nonatomic) id<DropboxImageLoaderDelegate> delegate;



+ (DropboxImageLoader*) shareLoader;
- (void)loadImageUrlsFromDropbox:(id<DropboxImageLoaderDelegate>)delegate;
- (void)loadImagesFromDropbox:(id<DropboxImageLoaderDelegate>)delegate;
- (void)loadThumbnails;
@end
