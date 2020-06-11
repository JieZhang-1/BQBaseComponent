//
//  UIButton+Accept.m
//  NHTCreditCard
//
//  Created by ZhangJie on 2019/3/20.
//  Copyright © 2019 ChangYu. All rights reserved.
//


#import "UIControl+Accept.h"
#import <objc/runtime.h>

static const char *kCYAcceptEventIntervalKey = "cy_acceptEventInterval";
static const char *kCYAcceptEventTimeKey = "cy_acceptEventTimeKey";

@interface UIControl ()

@property (nonatomic, assign) NSTimeInterval cy_acceptEventTime;

@end

@implementation UIControl (Accept)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(cy_sendAction:to:forEvent:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (NSTimeInterval )cy_acceptEventInterval
{
    return [objc_getAssociatedObject(self, kCYAcceptEventIntervalKey) doubleValue];
}

- (void)setCy_acceptEventInterval:(NSTimeInterval)cy_acceptEventInterval
{
    objc_setAssociatedObject(self, kCYAcceptEventIntervalKey, @(cy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)cy_acceptEventTime
{
    return [objc_getAssociatedObject(self, kCYAcceptEventTimeKey) doubleValue];
}

- (void)setCy_acceptEventTime:(NSTimeInterval)cy_acceptEventTime
{
    objc_setAssociatedObject(self, kCYAcceptEventTimeKey, @(cy_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (NSDate.date.timeIntervalSince1970 - self.cy_acceptEventTime < self.cy_acceptEventInterval) {
        return;
    }
    if (self.cy_acceptEventInterval > 0) {
        self.cy_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    [self cy_sendAction:action to:target forEvent:event];
}

@end
