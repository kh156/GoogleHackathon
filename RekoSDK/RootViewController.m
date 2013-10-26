//
//  RootViewController.m
//  RekoSDK
//
//  Created by Kuang Han on 10/26/13.
//
//

#import "RootViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "StacheCamAppDelegate.h"
#import "DropboxImageLoader.h"


@interface RootViewController()

@property (strong, nonatomic) NSArray* imageUrls;

@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self linkDropboxAndLoadPhotos];
}


- (void)linkDropboxAndLoadPhotos {
    if (![[DBSession sharedSession] isLinked]) {
		[[DBSession sharedSession] linkFromController:self];
    } else {
        [[DropboxImageLoader shareLoader] loadImageUrlsFromDropbox:self];
    }
}


- (void)allImageUrlsLoaded:(NSArray *)imageUrls succeed:(BOOL)succeed contentChanged:(BOOL)change {
    NSLog(@"all urls: %d", [imageUrls count]);
    self.imageUrls = imageUrls;
}

- (void)thumbnailLoaded:(UIImage *)thumbnail {
    NSLog(@"thumbnail: %@", thumbnail);
}

@end
