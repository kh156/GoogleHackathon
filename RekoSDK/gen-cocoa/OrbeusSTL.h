//
//  OrbeusSTL.h
//  Orbeus v0.2
//
//  Created by Tianqiang Liu on 5/5/12.
//  Copyright (c) 2012 Orbeus All rights reserved.
//
//  Orbeus STL lib


#import <Foundation/Foundation.h>

@interface OrbeusSTL : NSObject
- (NSString *) getMostFrequentNSString: (NSArray *)obj_array;    // Find the most frequently appeared string in an array
- (NSInteger) findIndexOfMaxElement: (NSArray *)arr;
@end
