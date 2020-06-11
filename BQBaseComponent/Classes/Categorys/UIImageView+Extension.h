//
//  UIImageView+Extension.h
//  BQProject
//
//  Created by ZhangJie on 2019/6/28.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)
- (void)bq_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

@end

NS_ASSUME_NONNULL_END
