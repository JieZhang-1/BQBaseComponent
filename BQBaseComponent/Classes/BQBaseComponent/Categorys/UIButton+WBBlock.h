//
//  UIButton+WBBlock.h
//  SpriteMobAdSdk
//
//  Created by 王 亮 on 13-9-4.
//  Copyright (c) 2013年 王 亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WBBlock)

- (void)wb_handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)(void))handle;

@end
