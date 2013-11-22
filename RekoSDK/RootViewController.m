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
#import "RekoPipe.h"

@interface RootViewController()
@property (strong, nonatomic) NSMutableArray *googleSampleImages;
@property (strong, nonatomic) NSMutableArray *googleSampleImageThumbnails;
@property (strong, nonatomic) NSDictionary *indexDict;
@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self linkDropboxAndLoadPhotos];
    [self fetchdata];
}


-(void) fetchdata{
    self.googleSampleImages = [NSMutableArray arrayWithCapacity:10];
    self.googleSampleImageThumbnails = [NSMutableArray arrayWithCapacity:10];
    
    NSString *str_flower=@"https://picasaweb.google.com/data/feed/api/all?q=flower%20pictures&max-results=5";
    NSString *str_beach=@"https://picasaweb.google.com/data/feed/api/all?q=beach%20pictures&max-results=5";
    NSString *str_food=@"https://picasaweb.google.com/data/feed/api/all?q=food%20pictures&max-results=5";
    NSString *str_mountain=@"https://picasaweb.google.com/data/feed/api/all?q=mountain%20pictures&max-results=5";
    NSString *str_smile = @"https://picasaweb.google.com/data/feed/api/all?q=smile%20pictures&max-results=5";
    NSString *str_men = @"https://picasaweb.google.com/data/feed/api/all?q=gentleman%20pictures&max-results=5";
    NSString *str_women = @"https://picasaweb.google.com/data/feed/api/all?q=lady%20pictures&max-results=5";
    NSString *str_people = @"https://picasaweb.google.com/data/feed/api/all?q=lady%20pictures&max-results=20";
    NSArray * str_array = [[NSArray alloc] initWithObjects:str_men, str_women, str_people, nil];

    for (NSString * str in str_array) {
        
        NSURL *url=[NSURL URLWithString:str];
        
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        NSString * responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableArray *components = [[responseStr componentsSeparatedByString:@"<media:content"] mutableCopy];
        
        [components removeObjectAtIndex:0];
        
        NSArray * array = components;
        
        for (NSString * str in array) {
            NSArray *tempArray = [str componentsSeparatedByString:@"url='"];
            NSString *imageString = tempArray[1];
            NSString *thumbnailString = tempArray[3];
            imageString = [imageString componentsSeparatedByString:@"'"][0];
            thumbnailString = [thumbnailString componentsSeparatedByString:@"'"][0];
            NSLog(@"loading imageString = %@", imageString);
            [self.googleSampleImages addObject:imageString];
            [self.googleSampleImageThumbnails addObject:thumbnailString];
        }
    }
    
    RekoPipe *reko = [[RekoPipe alloc] init];
    self.indexDict = [reko processImages:self.googleSampleImages];
    NSLog(@"self.indexDict = %@", self.indexDict);
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
    RekoPipe *reko = [[RekoPipe alloc] init];
    self.indexDict = [reko processImages:imageUrls];
    NSLog(@"%@", self.indexDict);
    
    [[DropboxImageLoader shareLoader] loadThumbnails];
}


- (void)thumbnailsLoaded:(NSArray *)images {
    NSMutableDictionary *imageDict = [[NSMutableDictionary alloc] init];
    for (NSString *key in [self.indexDict allKeys]) {
        NSArray *array = [self.indexDict objectForKey:key];
        NSMutableArray *thumbnailArray = [NSMutableArray arrayWithCapacity:10];
        for (NSNumber *i in array) {
            [thumbnailArray addObject:[images objectAtIndex:i]];
        }
        [imageDict setObject:thumbnailArray forKey:key];
    }
}

@end
