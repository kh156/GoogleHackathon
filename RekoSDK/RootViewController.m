//
//  RootViewController.m
//  RekoSDK
//
//  Created by Kuang Han on 10/26/13.
//
//

#import "RootViewController.h"
#import <DropboxSDK.h>
#import "StacheCamAppDelegate.h"
#import "DropboxImageLoader.h"

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
        [[DropboxImageLoader shareLoader] loadImagesFromDropbox:self];
    }
}

- (void)allImagesLoaded:(NSArray *)images succeed:(BOOL)succeed contentChanged:(BOOL)change {
    NSLog(@"here");
    NSLog(@"%@", images);
}

@end
