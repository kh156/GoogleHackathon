//
//  OrbeusSTL.m
//  Orbeus v0.2
//
//  Created by Guest1 on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrbeusSTL.h"

@implementation OrbeusSTL

- (NSString *) getMostFrequentNSString: (NSArray *)obj_array
{
    if (![obj_array count]) {
        return @"";
    }
    NSMutableDictionary *hashmap = [[NSMutableDictionary alloc] init];
    
    id key;
    NSEnumerator *enumerator = [obj_array objectEnumerator];
    while (key = [enumerator nextObject]) {
        if ([hashmap objectForKey:key]==nil) {
            [hashmap setObject:[NSNumber numberWithInt:0] forKey:key];
        }
        else {
            [hashmap setObject:[NSNumber numberWithInt:[[hashmap objectForKey:key] integerValue]+1] forKey:key];
        }
    }
    
    NSString * maxstr = [obj_array objectAtIndex:0];
    int maxnum = 0;
    enumerator = [hashmap keyEnumerator];
    for (NSString *key in enumerator) {
        if ([[hashmap objectForKey:key] integerValue] > maxnum) {
            maxnum = [[hashmap objectForKey:key] integerValue];
            maxstr = key;
        }
    }
    return maxstr;
}

- (NSInteger) findIndexOfMaxElement: (NSArray *)arr
{
    NSNumber * max = [arr valueForKeyPath:@"@max.floatValue"];
    NSInteger Aindex = [arr indexOfObject:max];
    if (NSNotFound == Aindex) {
        return -1;
    }
    return Aindex;
}

@end
