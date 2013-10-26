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
- (void)newImageUrlLoaded:(NSURL *)imageUrl index:(NSInteger)index;
- (void)thumbnailLoaded:(UIImage *)thumbnail;
@end


@interface DropboxImageLoader : NSObject
@property (strong, nonatomic) id<DropboxImageLoaderDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *photoUrls;


+ (DropboxImageLoader*) shareLoader;
- (void)loadImageUrlsFromDropbox:(id<DropboxImageLoaderDelegate>)delegate;
- (void)loadThumbnailForIndex:(NSInteger)index;
@end
