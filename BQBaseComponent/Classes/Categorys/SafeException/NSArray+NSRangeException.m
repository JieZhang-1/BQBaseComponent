//
//  NSArray+NSRangeException.m
//  SP2PProject
//
//  Created by Belly on 2017/2/6.
//  Copyright © 2017年 nuoyuan. All rights reserved.
//

#import "NSArray+NSRangeException.h"
#import <objc/runtime.h>
#import "NSObject+NYSwizzling.h"

@implementation NSArray (NSRangeException)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArray0") ny_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_empty_objectIndex:)];
            [objc_getClass("__NSArrayI") ny_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_objectIndex:)];
            [objc_getClass("__NSArrayM") ny_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_mutable_objectIndex:)];
            [objc_getClass("__NSArrayM") ny_swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(safe_mutable_insertObject:atIndex:)];
            [objc_getClass("__NSArrayM") ny_swizzleMethod:@selector(integerValue) swizzledSelector:@selector(safe_integerValue)];
        }
    });
}

- (id)safe_empty_objectIndex:(NSInteger)index{
    return nil;
}

- (id)safe_objectIndex:(NSInteger)index{
    @autoreleasepool {
        if (index >= self.count || index < 0) {
            return nil;
        }
        return [self safe_objectIndex:index];
    }
}

- (id)safe_mutable_objectIndex:(NSInteger)index{
    @autoreleasepool {
        if (index >= self.count || index < 0) {
            return nil;
        }
        return [self safe_mutable_objectIndex:index];
    }
}

- (void)safe_mutable_insertObject:(id)object atIndex:(NSUInteger)index{
    @autoreleasepool {
        if (object) {
            [self safe_mutable_insertObject:object atIndex:index];
        }
    }
}

- (NSInteger)safe_integerValue {
    return 0;
}

@end
