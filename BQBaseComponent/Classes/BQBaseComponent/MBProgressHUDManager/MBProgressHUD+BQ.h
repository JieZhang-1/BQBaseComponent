//
//  MBProgressHUD+BQ.h
//  BQBaseProject
//
//  Created by Zhang Jie on 2020/6/10.
//  Copyright © 2020 BiQuan. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (BQ)

#pragma mark - 自动消失
+ (void)showHUD:(UIView *)superview text:(NSString *)text;

+ (void)showSuccessHUD:(UIView *)superview text:(NSString *)text;
+ (void)showSuccessHUD:(UIView *)superview text:(NSString *)text delay:(NSTimeInterval)delay;

+ (void)showFailedHUD:(UIView *)superview text:(NSString *)text;
+ (void)showFailedHUD:(UIView *)superview text:(NSString *)text delay:(NSTimeInterval)delay;

#pragma mark - 手动消失
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUD;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hiddenHUD:(UIView *)superview;

@end

NS_ASSUME_NONNULL_END
