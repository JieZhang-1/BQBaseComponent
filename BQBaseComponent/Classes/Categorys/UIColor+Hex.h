//
//  UIColor+Hex.h
//  BQProject
//
//  Created by ZhangJie on 2019/6/25.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)bq_colorWithHexString:(NSString *)hexString;
+ (UIColor *)bq_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
