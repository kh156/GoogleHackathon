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

- (void)finishedLoading:(NSArray *)images succeed:(BOOL)succeed contentChanged:(BOOL)change {
    NSLog(@"here");
    NSLog(@"%@", images);
}

@end
