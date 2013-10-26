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
    int imagesLoaded;
}
@property (strong, readonly) DBRestClient *dropboxClient;
@property (strong, nonatomic) NSString *photosHash;
@property (strong, nonatomic) NSMutableArray *photoPaths;
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


- (void)loadImageUrlsFromDropbox:(id<DropboxImageLoaderDelegate>)delegate {
    self.delegate = delegate;
    NSString *dropboxPath = @"/_Orbeus_Family (1)/GoogleHackathon/";
    [self.dropboxClient loadMetadata:dropboxPath withHash:self.photosHash];
}


- (void)loadThumbnailForIndex:(NSInteger)index {
    [self.dropboxClient loadThumbnail:[self.photoPaths objectAtIndex:index] ofSize:@"m" intoPath:[self tempPhotoPath]];
}


#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)restClient loadedStreamableURL:(NSURL*)url forFile:(NSString*)path {
    [self.photoUrls addObject:url];
    [self.delegate newImageUrlLoaded:url index:imagesLoaded];
    imagesLoaded ++;
    if (imagesLoaded == [self.photoPaths count]) {
        [self.delegate allImageUrlsLoaded:self.photoUrls succeed:YES contentChanged:YES];
    }
}


- (void)restClient:(DBRestClient*)restClient loadStreamableURLFailedWithError:(NSError*)error {
//    NSLog(@"Url failed: %@", error);
    imagesLoaded ++;
    if (imagesLoaded == [self.photoPaths count]) {
        [self.delegate allImageUrlsLoaded:self.photoUrls succeed:YES contentChanged:YES];
    }
}


- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    self.photosHash = metadata.hash;
    
    NSArray* validExtensions = [NSArray arrayWithObjects:@"jpg", @"jpeg", nil];
    
    self.photoPaths = [NSMutableArray arrayWithCapacity:10];
    for (DBMetadata* child in metadata.contents) {
        NSString* extension = [[child.path pathExtension] lowercaseString];
        if (!child.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
            [self.photoPaths addObject:child.path];
        }
    }
    
    self.photoUrls = [NSMutableArray arrayWithCapacity:10];
    imagesLoaded = 0;
    
    for (NSString *path in self.photoPaths) {
        [self.dropboxClient loadStreamableURLForFile:path];
    }
}


- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
    NSLog(@"Files unchanged");
    [self.delegate allImageUrlsLoaded:self.photoUrls succeed:YES contentChanged:NO];
}


- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
    [self.delegate allImageUrlsLoaded:nil succeed:NO contentChanged:NO];
}


- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath {
    UIImage *thumbnail = [UIImage imageWithContentsOfFile:destPath];
    [self.delegate thumbnailLoaded:thumbnail];
}


- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadThumbnailFailedWithError: %@", [error localizedDescription]);
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
