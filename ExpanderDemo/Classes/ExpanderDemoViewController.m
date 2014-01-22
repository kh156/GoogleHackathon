/*
 * ExpanderDemoViewController.h
 * Classes
 * 
 * Created by Jim Dovey on 16/8/2010.
 * 
 * Copyright (c) 2010 Jim Dovey
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 
 * Neither the name of the project's author nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import "ExpanderDemoViewController.h"
#import "AQGridView.h"
#import "ExpandFromGridViewCell.h"
#import "ExpandingGridViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "RekoPipe.h"


@implementation ExpanderDemoViewController
@synthesize imageCategories = _imageCategories;
@synthesize imageArray = _imageArray;

- (void)viewDidLoad {
//    [self fetchdata];
//    [self linkDropboxAndLoadPhotos];
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self linkDropboxAndLoadPhotos];
//    [self fetchdata];
    
    // ================== Customize view here ==================
}


- (void)linkDropboxAndLoadPhotos {
    if (![[DBSession sharedSession] isLinked]) {
		[[DBSession sharedSession] linkFromController:self];
    } else {
        [[DropboxImageLoader shareLoader] loadImageUrlsFromDropbox:self];
    }
}


- (void)allImageUrlsLoaded:(NSArray *)imageUrls succeed:(BOOL)succeed contentChanged:(BOOL)change {
    NSLog(@"all urls: %@", imageUrls);
    RekoPipe *reko = [[RekoPipe alloc] init];
    self.imageCategories = [reko processImages:imageUrls];
    self.imageArray = imageUrls;
}


- (void)fetchdata {
    NSMutableArray* googleSampleImages = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray* googleSampleImageThumbnails = [NSMutableArray arrayWithCapacity:10];
    
    NSString *str_flower=@"https://picasaweb.google.com/data/feed/api/all?q=flower%20pictures&max-results=10";
    NSString *str_beach=@"https://picasaweb.google.com/data/feed/api/all?q=beach%20pictures&max-results=10";
    NSString *str_food=@"https://picasaweb.google.com/data/feed/api/all?q=food%20pictures&max-results=10";
    NSString *str_mountain=@"https://picasaweb.google.com/data/feed/api/all?q=mountain%20pictures&max-results=10";
    NSString *str_smile = @"https://picasaweb.google.com/data/feed/api/all?q=smile%20pictures&max-results=10";
    NSString *str_men = @"https://picasaweb.google.com/data/feed/api/all?q=gentleman%20pictures&max-results=10";
    NSString *str_women = @"https://picasaweb.google.com/data/feed/api/all?q=lady%20pictures&max-results=10";
    NSString *str_people = @"https://picasaweb.google.com/data/feed/api/all?q=lady%20pictures&max-results=20";
    NSArray * str_array = [[NSArray alloc] initWithObjects:str_women,str_flower,str_beach,str_food,str_mountain,str_smile,str_men,str_women,str_people, nil];
    
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
            [googleSampleImages addObject:imageString];
            [googleSampleImageThumbnails addObject:thumbnailString];
        }
    }
    
    RekoPipe *reko = [[RekoPipe alloc] init];
    self.imageCategories = [reko processImages:googleSampleImages];
    self.imageArray = googleSampleImages;
}


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark AQGridView Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
    NSLog(@"count = %d", [[self.imageCategories allKeys] count]);
	return [[self.imageCategories allKeys] count];
}

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index
{
	static NSString * ExpanderCellIdentifier = @"ExpanderCellIdentifier";
	
	ExpandFromGridViewCell * cell = (ExpandFromGridViewCell *)[self.gridView dequeueReusableCellWithIdentifier: ExpanderCellIdentifier];
	if ( cell == nil )
	{
		cell = [[[ExpandFromGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 200.0, 200.0) reuseIdentifier: ExpanderCellIdentifier] autorelease];
		cell.selectionGlowColor = [UIColor whiteColor];
	}
    
    NSString * str = [[self.imageCategories allKeys] objectAtIndex:index];
    
    NSLog(@"str = %@", str);
	

    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    //dispatch_async(queue, ^{
        NSString *s = self.imageArray[[[[[self.imageCategories allValues] objectAtIndex:index] objectAtIndex:0] integerValue]];
        NSLog(@"url = %@", [s class]);
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:s]];
    //    dispatch_async(dispatch_get_main_queue(), ^{
            cell.image = [UIImage imageWithData:imageData];
    //    });
    //});
    
    cell.title = str;
	return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
	return ( CGSizeMake(250.0, 250.0) );
}

#pragma mark -
#pragma mark AQGridView Delegate

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
	ExpandFromGridViewCell * cell = (ExpandFromGridViewCell *)[self.gridView cellForItemAtIndex: index];
	CGRect expandFromRect = [cell rectForExpansionStart];
	
	ExpandingGridViewController * controller = [[ExpandingGridViewController alloc] init];
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    for (NSNumber * imageIndex in [[self.imageCategories allValues] objectAtIndex:index]){
        [indexSet addIndex:[imageIndex unsignedIntValue]];
    }
    
    controller.imageArray = [self.imageArray objectsAtIndexes:indexSet];
	controller.gridView.frame = self.gridView.frame;
	
	[controller viewWillAppear: NO];
	[self.view.superview addSubview: controller.gridView];
	[controller expandCellsFromRect: expandFromRect ofView: cell];
	[controller viewDidAppear: NO];
}

@end
