//
//  BQMacro.h
//  BQBaseProject
//
//  Created by Zhang Jie on 2020/6/4.
//  Copyright © 2020 BiQuan. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef BQMacro_h
#define BQMacro_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kMainScreenWidth        ([UIScreen mainScreen].bounds.size.width)
#define kMainScreenHeight       ([UIScreen mainScreen].bounds.size.height)
#define kScaleNum(number)       ((number) *kMainScreenWidth / 375)
#define kIPhoneXStatusBarOffsetHeight      (kIPhone_X ? 24 : 0)
#define kStatusBarHeight      (kIPhone_X ? 44 : 20)
#define kNavgationBarHeight   (kStatusBarHeight + 44)
#define kTableBarHeight       (kIPhone_X ? 83 : 49)
#define kIPhoneXOffsetHeight  (kIPhone_X ? 34 : 0)
#define kCenterViewControllerHeight   (kMainScreenHeight - kNavgationBarHeight - kTableBarHeight)

#define kIphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)
#define kIphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)
#define kIphone6x_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)
#define kIphone6xPlus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)
#define kIphoneX_5_8 ([UIScreen mainScreen].bounds.size.height==812.0f)
#define kIphoneXSM_6_5 ([UIScreen mainScreen].bounds.size.height==896.0f)
#define kIPhone_X   isIPhoneXSeries()    // 判读是否是刘海屏。
#define kIPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#if DEBUG
#define BQLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define BQLog(FORMAT, ...) nil
#endif

#define RGB(A,B,C)              [UIColor colorWithRed:((float)A)/255.0 green:((float)B)/255.0 blue:((float)C)/255.0 alpha:1.0]
#define RGBA(A,B,C,D)           [UIColor colorWithRed:((float)A)/255.0 green:((float)B)/255.0 blue:((float)C)/255.0 alpha:(float)D]
#define IMG(imageName)  [UIImage imageNamed:imageName]
#define KEYWINDOW [UIApplication sharedApplication].delegate.window

// 单列宏定义
// .h文件
#define SingletonH(name) + (instancetype)shared##name;
// .m文件
#define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

#endif /* BQMacro_h */
