//
//  UIImage+Extension.h
//  BQProject
//
//  Created by ZhangJie on 2019/6/25.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageName:(NSString *)imageName inBundle:(NSBundle *)bundle;
+ (UIImage *)imageName:(NSString *)imageName podsName:(NSString *)podsName;
@end

NS_ASSUME_NONNULL_END
