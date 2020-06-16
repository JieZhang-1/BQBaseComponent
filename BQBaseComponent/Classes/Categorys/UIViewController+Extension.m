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
#import <objc/runtime.h>
@interface UIViewController()


@end

@implementation UIViewController (Extension)
+ (void)load {
    // 方法交换，为的是当系统调用viewDidLoad时候，调用的是我们的my_viewDidLoad方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(myPresentViewController:animated:completion:);
        
        //swizzling_exchangeMethod(class, originalSelector, swizzledSelector);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
                }
        });
    
}

- (void)myPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    //设置满屏，不需要小卡片
    if(@available(iOS 13.0, *)) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
}


- (UIButton *)backWhiteButtonForNav {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageName:@"home_back_icon" podsName:@"BQBaseComponent"];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 40, 44);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    return btn;
}

- (UIButton*) backButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageName:@"black_back_icon" podsName:@"BQBaseComponent"];
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
