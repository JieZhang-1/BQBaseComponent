//
//  UIView+Ext.h
//  dianshang
//
//  Created by sskh on 15/12/9.
//  Copyright © 2015年 ssdk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)

/**
 * @brief Shortcut for frame.origin.x.
 *        Sets frame.origin.x = originX
 */
@property (nonatomic) CGFloat bq_X;

/**
 * @brief Shortcut for frame.origin.y
 *        Sets frame.origin.y = originY
 */
@property (nonatomic) CGFloat bq_Y;

/**
 * @brief Shortcut for frame.origin.x + frame.size.width
 *       Sets frame.origin.x = rightX - frame.size.width
 */
@property (nonatomic) CGFloat bq_rightX;

/**
 * @brief Shortcut for frame.origin.y + frame.size.height
 *        Sets frame.origin.y = bottomY - frame.size.height
 */
@property (nonatomic) CGFloat bq_bottomY;

/**
 * @brief Shortcut for frame.size.width
 *        Sets frame.size.width = width
 */
@property (nonatomic) CGFloat bq_width;

/**
 * @brief Shortcut for frame.size.height
 *        Sets frame.size.height = height
 */
@property (nonatomic) CGFloat bq_height;

/**
 * @brief Shortcut for center.x
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat bq_centerX;

/**
 * @brief Shortcut for center.y
 *        Sets center.y = centerY
 */
@property (nonatomic) CGFloat bq_centerY;

/**
 * @brief Shortcut for frame.origin
 */
@property (nonatomic) CGPoint bq_origin;

/**
 * @brief Shortcut for frame.size
 */
@property (nonatomic) CGSize bq_size;


- (UIViewController *)getCurrentViewController;

- (void)cornerRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)size;

@end
