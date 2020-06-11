//
//  NSNull+NYException.m
//  SP2PProject
//
//  Created by Belly on 2017/2/7.
//  Copyright © 2017年 nuoyuan. All rights reserved.
//

#import "NSNull+NYException.h"
#import <objc/runtime.h>
#import "NSObject+NYSwizzling.h"

@implementation NSNull (NYException)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSNull") ny_swizzleMethod:@selector(length) swizzledSelector:@selector(safe_length)];
        }
    });
}

- (NSInteger)safe_length {
    return 0;
}

@end
