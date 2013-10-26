//
//  DropboxImageLoader.m
//  RekoSDK
//
//  Created by Kuang Han on 10/26/13.
//
//

#import "DropboxImageLoader.h"
#import <DropboxSDK/DropboxSDK.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface DropboxImageLoader() <DBRestClientDelegate> {
    int counter;
    int imagesToLoad;
}
@property (strong, readonly) DBRestClient *dropboxClient;
@property (strong, nonatomic) NSString *photosHash;
@end


@implementation DropboxImageLoader
@synthesize dropboxClient = _dropboxClient;
static DropboxImageLoader *_sharedLoader = nil;


+ (DropboxImageLoader*) shareLoader {
    if (!_sharedLoader) {
        _sharedLoader = [[DropboxImageLoader alloc] init];
    }
    return _sharedLoader;
}


- (void)loadImagesFromDropbox:(id<DropboxImageLoaderDelegate>)delegate {
    self.delegate = delegate;
    NSString *dropboxPath = @"/_Orbeus_Family (1)/Google Hackathon/";
    [self.dropboxClient loadMetadata:dropboxPath withHash:self.photosHash];
}


#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    self.photosHash = metadata.hash;
    
    NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
    NSMutableArray* newPhotoPaths = [NSMutableArray new];
    NSLog(@"metadata: %@", metadata.contents);
    
    for (DBMetadata* child in metadata.contents) {
        NSString* extension = [[child.path pathExtension] lowercaseString];
        if (!child.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
            [newPhotoPaths addObject:child.path];
        }
    }
    self.photos = [NSMutableArray arrayWithCapacity:10];
    imagesToLoad = [newPhotoPaths count];

    for (NSString *path in newPhotoPaths) {
        [self.dropboxClient loadThumbnail:path ofSize:@"l" intoPath:[self tempPhotoPath]];
    }
}


- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
    NSLog(@"Files unchanged");
    if (self.delegate) {
        [self.delegate allImagesLoaded:self.photos succeed:YES contentChanged:NO];
    }
}


- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
    if (self.delegate) {
        [self.delegate allImagesLoaded:nil succeed:NO contentChanged:NO];
    }
}


- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath {
    UIImage *thumbnail = [UIImage imageWithContentsOfFile:destPath];
    NSLog(@"thumbnail: %@", thumbnail);
    [self.photos addObject:thumbnail];
    if (self.delegate) {
        [self.delegate newImageLoaded:thumbnail];
    }
    imagesToLoad --;
    if (imagesToLoad == 0 && self.delegate) {
        [self.delegate allImagesLoaded:self.photos succeed:YES contentChanged:YES];
    }
}


- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadThumbnailFailedWithError: %@", [error localizedDescription]);
    imagesToLoad --;
    if (imagesToLoad == 0 && self.delegate) {
        [self.delegate allImagesLoaded:self.photos succeed:YES contentChanged:YES];
    }
}


#pragma mark private methods

- (DBRestClient *)dropboxClient {
    if (!_dropboxClient) {
        _dropboxClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _dropboxClient.delegate = self;
    }
    return _dropboxClient;
}


- (NSString*)tempPhotoPath {
    counter ++;
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"photo%d.jpg", counter-1]];
}


- (void)saveImageToAlbum:(UIImage *)image {
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

@end
