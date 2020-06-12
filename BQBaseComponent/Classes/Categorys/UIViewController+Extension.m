//
//  UIViewController+Extension.m
//  BQProject
//
//  Created by ZhangJie on 2019/7/10.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UIButton+WBBlock.h"
#import "BQCommMacro.h"
#import "RTRootNavigationController.h"
#import "UIImage+Extension.h"
@interface UIViewController()


@end

@implementation UIViewController (Extension)

- (UIButton *)backWhiteButtonForNav {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%@@%zdx.png",@"home_back_icon",scale];
    UIImage *image = [UIImage imageName:imageName podsName:@"BQBaseComponent"];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 40, 44);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    return btn;
}

- (UIButton*) backButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%@@%zdx.png",@"black_back_icon",scale];
    UIImage *image = [UIImage imageName:imageName podsName:@"BQBaseComponent"];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 40, 44);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    return btn;
}

- (void)addBlackBackButton
{
    [self addBackButtonWithBlock:nil];
}

- (void)addBackButtonWithBlock:(void (^)(void))block
{
    UIButton *backButton = [self backButton];
    WS(weakSelf);
    [backButton wb_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (block) {
            block();
        }else {
            if (weakSelf.navigationController) {
                if (weakSelf.navigationController.navigationController && [weakSelf.navigationController.navigationController isKindOfClass:[RTRootNavigationController class]]) {
                    [weakSelf.navigationController.navigationController popViewControllerAnimated:YES];
                }else if (weakSelf.navigationController.cy_rootViewControlelr == weakSelf) {
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)addWhiteBackButton
{
    [self addBackWhiteButtonWithBlock:nil];
}

- (void)addBackWhiteButtonWithBlock:(void (^)(void))block
{
    UIButton *backButton = [self backWhiteButtonForNav];
    WS(weakSelf);
    [backButton wb_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (block) {
            block();
        }else {
            if (weakSelf.navigationController) {
                if (weakSelf.navigationController.navigationController && [weakSelf.navigationController.navigationController isKindOfClass:[RTRootNavigationController class]]) {
                    [weakSelf.navigationController.navigationController popViewControllerAnimated:YES];
                }else if (weakSelf.navigationController.cy_rootViewControlelr == weakSelf) {
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}


- (UINavigationController *)navigationControllerFromView:(UIView *)view {
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}

- (void)setupForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

@end


@implementation UINavigationController (CYRootViewController)
@dynamic cy_rootViewControlelr;

- (UIViewController *)cy_rootViewControlelr
{
    if ([self.viewControllers count]) {
        if ([self.navigationController isKindOfClass:[RTRootNavigationController class]]) {
            return [[(RTRootNavigationController *)self.navigationController rt_viewControllers] firstObject];
        }
        return [self.viewControllers firstObject];
    }
    return nil;
}

@end
