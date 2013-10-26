//
//  DropboxImageLoader.h
//  RekoSDK
//
//  Created by Kuang Han on 10/26/13.
//
//

#import <Foundation/Foundation.h>

@protocol DropboxImageLoaderDelegate <NSObject>
- (void)finishedLoading:(NSArray *)images succeed:(BOOL)succeed contentChanged:(BOOL)change;
@end


@interface DropboxImageLoader : NSObject
@property (strong, nonatomic) id<DropboxImageLoaderDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *photos;


+ (DropboxImageLoader*) shareLoader;
- (void)loadImagesFromDropbox:(id<DropboxImageLoaderDelegate>)delegate;

@end
