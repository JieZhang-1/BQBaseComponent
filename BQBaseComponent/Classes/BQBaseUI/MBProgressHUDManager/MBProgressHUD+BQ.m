//
//  MBProgressHUD+BQ.m
//  BQBaseProject
//
//  Created by Zhang Jie on 2020/6/10.
//  Copyright © 2020 BiQuan. All rights reserved.
//

#import "MBProgressHUD+BQ.h"
#import "UIImage+Extension.h"
@implementation MBProgressHUD (BQ)


+ (void)showHUD:(UIView *)superview text:(NSString *)text {
    [self showHudview:superview text:text icon:nil delay:2.0];
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccessHUD:nil text:(NSString *)success];
}

+ (void)showSuccessHUD:(UIView *)superview text:(NSString *)text {
    [self showHudview:superview text:text icon:@"activitycross" delay:2.0];
}

+ (void)showSuccessHUD:(UIView *)superview text:(NSString *)text delay:(NSTimeInterval)delay {
    [self showHudview:superview text:text icon:@"activitycross" delay:delay];
}

+ (void)showError:(NSString *)error {
    [self showFailedHUD:nil text:error];
}

+ (void)showFailedHUD:(UIView *)superview text:(NSString *)text {
    [self showHudview:superview text:text icon:@"activityfail" delay:2.0];
}

+ (void)showFailedHUD:(UIView *)superview text:(NSString *)text delay:(NSTimeInterval)delay {
    [self showHudview:superview text:text icon:@"activityfail" delay:delay];
}

+ (void)showHudview:(UIView *)view text:(NSString *)text icon:(NSString *)icon delay:(NSTimeInterval)delay
{
    if (!view) view = [[UIApplication sharedApplication].windows lastObject];
    UIView *viewExist = nil;
    for (UIView *v in [view subviews]) {
        if ([v isKindOfClass:[MBProgressHUD class]]) {
            viewExist = v;
            break;
        }
    }
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%@@%zdx.png",icon,scale];
    UIImage *image = [UIImage imageName:imageName podsName:@"BQBaseComponent"];
    if (viewExist) {
        MBProgressHUD *HUD = (MBProgressHUD *)viewExist;
        HUD.customView = [[UIImageView alloc] initWithImage:image];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = text;
        [HUD hide:YES afterDelay:delay];
    }else {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.color = [UIColor colorWithWhite:0.1f alpha:0.7];
        HUD.minSize = CGSizeMake(159, 80);
        HUD.detailsLabelFont = HUD.labelFont;
        HUD.customView = [[UIImageView alloc] initWithImage:image];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = text;
        [HUD hide:YES afterDelay:delay];
    }
}


// *  显示提示 + 菊花
+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    UIView *viewExist = nil;
    for (UIView *v in [view subviews]) {
        if ([v isKindOfClass:[MBProgressHUD class]]) {
            viewExist = v;
            break;
        }
    }
    
    if (viewExist) {
        if (message && [message length]) {
            ((MBProgressHUD *)viewExist).labelText = message;
        }
    }else {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.color = [UIColor colorWithWhite:0.1f alpha:0.7];
        HUD.detailsLabelFont = HUD.labelFont;
        HUD.minSize = CGSizeMake(105, 105);
        if (message && [message length]) {
            HUD.labelText = message;
        }
        viewExist = HUD;
    }

    return (MBProgressHUD *)viewExist;
}

+ (void)hiddenHUD:(UIView *)superview {
    if (!superview) superview = [[UIApplication sharedApplication].windows lastObject];
    [MBProgressHUD hideHUDForView:superview animated:YES];
}

+ (void)hideHUD {
    [self hiddenHUD:nil];
}

@end
