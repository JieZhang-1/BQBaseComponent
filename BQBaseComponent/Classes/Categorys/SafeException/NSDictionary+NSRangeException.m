//
//  NSDictionary+NSRangeException.m
//  SP2PProject
//
//  Created by Belly on 2017/2/7.
//  Copyright © 2017年 nuoyuan. All rights reserved.
//

#import "NSDictionary+NSRangeException.h"
#import <objc/runtime.h>
#import "NSObject+NYSwizzling.h"

@implementation NSDictionary (NSRangeException)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryI") ny_swizzleMethod:@selector(objectForKey:) swizzledSelector:@selector(safe_objectForKey:)];
            [objc_getClass("__NSDictionaryI") ny_swizzleMethod:@selector(length) swizzledSelector:@selector(safe_length)];
        }
    });
}

- (id)safe_objectForKey:(NSString *)key {
    @autoreleasepool {
        if ([self isKindOfClass:[NSDictionary class]]) {
            return [self safe_objectForKey:key];
        }
        return nil;
    }
}

- (NSUInteger)safe_length {
    return 0;
}

@end
