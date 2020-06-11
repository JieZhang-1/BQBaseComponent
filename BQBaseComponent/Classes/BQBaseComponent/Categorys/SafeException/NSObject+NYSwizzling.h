//
//  NSObject+NYSwizzling.h
//  SP2PProject
//
//  Created by Belly on 2017/2/7.
//  Copyright © 2017年 nuoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NYSwizzling)

+ (void)ny_swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
