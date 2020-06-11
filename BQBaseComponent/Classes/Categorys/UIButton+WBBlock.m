//
//  UIButton+WBBlock.m
//  SpriteMobAdSdk
//
//  Created by 王 亮 on 13-9-4.
//  Copyright (c) 2013年 王 亮. All rights reserved.
//

#import "UIButton+WBBlock.h"
#import <objc/runtime.h>

typedef void (^WBButtonClickEnventBlock)(void);
static char  kWBButtonClickEnventBlockKey;

@implementation UIButton (WBBlock)

- (void)wb_handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)(void))handle {
    objc_setAssociatedObject(self, &kWBButtonClickEnventBlockKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(wb_buttonClickEvent:) forControlEvents:controlEvent];
}

- (void)wb_buttonClickEvent:(id)sender {
    WBButtonClickEnventBlock block = (WBButtonClickEnventBlock)objc_getAssociatedObject(self, &kWBButtonClickEnventBlockKey);
    if (block) {
        block();
    }
}

@end
