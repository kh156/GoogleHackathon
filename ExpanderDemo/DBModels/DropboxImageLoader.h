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
@end


@interface DropboxImageLoader : NSObject
@property (strong, nonatomic) id<DropboxImageLoaderDelegate> delegate;



+ (DropboxImageLoader*) shareLoader;
- (void)loadImageUrlsFromDropbox:(id<DropboxImageLoaderDelegate>)delegate;
@end
