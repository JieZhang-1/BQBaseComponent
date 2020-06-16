//
//  UIImage+Extension.m
//  BQProject
//
//  Created by ZhangJie on 2019/6/25.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)imageName:(NSString *)imageName inBundle:(NSBundle *)bundle {
    NSString *bundleName = bundle.infoDictionary[@"CFBundleExecutable"];
    NSString *path = [bundle pathForResource:imageName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",bundleName]];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)imageName:(NSString *)imageName podsName:(NSString *)podsName {
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *name = [NSString stringWithFormat:@"%@@%zdx.png",imageName,scale];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@",podsName,name]];
    if (image) {
        return image;
    }
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [NSString stringWithFormat:@"%@/Frameworks/%@.framework",mainBundle.resourcePath,podsName];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    UIImage *img = [self imageName:name inBundle:bundle];
    return img;
}

@end
