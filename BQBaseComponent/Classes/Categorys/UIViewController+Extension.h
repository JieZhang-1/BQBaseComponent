//
//  UIViewController+Extension.h
//  BQProject
//
//  Created by ZhangJie on 2019/7/10.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)
- (void)addBlackBackButton;
- (void)addBackButtonWithBlock:(void (^)(void))block;
- (void)addWhiteBackButton;
- (UIButton *)backWhiteButtonForNav;
- (UIButton*) backButton;
- (UINavigationController *)navigationControllerFromView:(UIView *)view;
- (void)setupForDismissKeyboard;

@end

@interface UINavigationController (CYRootViewController)

@property (nonatomic, weak, readonly)UIViewController *cy_rootViewControlelr;

@end

NS_ASSUME_NONNULL_END
