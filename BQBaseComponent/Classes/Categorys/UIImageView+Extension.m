//
//  UIImageView+Extension.m
//  BQProject
//
//  Created by ZhangJie on 2019/6/28.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
- (void)bq_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIGraphicsBeginImageContextWithOptions(size, YES, scale);
        if (nil == UIGraphicsGetCurrentContext()) {
            return;
        }
        UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
        [cornerPath addClip];
        [image drawInRect:self.bounds];
        id processedImageRef = (__bridge id _Nullable)(UIGraphicsGetImageFromCurrentImageContext().CGImage);
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = processedImageRef;
        });
    });
}

@end
