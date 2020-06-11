//
//  BQImageUtils.h
//  BQProject
//
//  Created by Zhang Jie on 2019/7/31.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQImageUtils : NSObject
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage;
@end

NS_ASSUME_NONNULL_END
