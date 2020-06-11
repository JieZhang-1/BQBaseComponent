//
//  UIView+Ext.m
//  RPBottomInputBox
//
//  Created by Tao on 2018/7/23.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

- (CGFloat)bq_X {
    return self.frame.origin.x;
}

- (void)setBq_X:(CGFloat)bq_X {
    CGRect frame = self.frame;
    frame.origin.x = bq_X;
    self.frame = frame;
    return;
}

- (CGFloat)bq_Y {
    return self.frame.origin.y;
}

- (void)setBq_Y:(CGFloat)bq_Y {
    CGRect frame = self.frame;
    frame.origin.y = bq_Y;
    self.frame = frame;
    return;
}

- (CGFloat)bq_rightX {
    return [self bq_X] + [self bq_width];
}

- (void)setBq_rightX:(CGFloat)bq_rightX {
    CGRect frame = self.frame;
    frame.origin.x = bq_rightX - [self bq_width];
    self.frame = frame;
    return;
}

- (CGFloat)bq_bottomY {
    return [self bq_Y] + [self bq_height];
}

- (void)setBq_bottomY:(CGFloat)bq_bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bq_bottomY - [self bq_height];
    self.frame = frame;
    return;
}

- (CGFloat)bq_centerX {
    return self.center.x;
}

- (void)setBq_centerX:(CGFloat)bq_centerX {
    self.center = CGPointMake(bq_centerX, self.center.y);
    return;
}

- (CGFloat)bq_centerY {
    return self.center.y;
}

- (void)setBq_centerY:(CGFloat)bq_centerY {
    self.center = CGPointMake(self.center.x, bq_centerY);
    return;
}

- (CGFloat)bq_width {
    return self.frame.size.width;
}

- (void)setBq_width:(CGFloat)bq_width {
    CGRect frame = self.frame;
    frame.size.width = bq_width;
    self.frame = frame;
    return;
}

- (CGFloat)bq_height {
    return self.frame.size.height;
}

- (void)setBq_height:(CGFloat)bq_height {
    CGRect frame = self.frame;
    frame.size.height = bq_height;
    self.frame = frame;
    return;
}

- (CGPoint)bq_origin {
    return self.frame.origin;
}

- (void)setBq_origin:(CGPoint)bq_origin {
    CGRect frame = self.frame;
    frame.origin = bq_origin;
    self.frame = frame;
    return;
}

- (CGSize)bq_size {
    return self.frame.size;
}

- (void)setBq_size:(CGSize)bq_size {
    CGRect frame = self.frame;
    frame.size = bq_size;
    self.frame = frame;
    return;
}

- (UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (void)cornerRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)size{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    });
}
@end

