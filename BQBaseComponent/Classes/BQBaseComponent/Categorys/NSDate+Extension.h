//
//  NSDate+Extension.h
//  BQPartnerProject
//
//  Created by Zhang Jie on 2020/4/27.
//  Copyright © 2020 BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)
@property (nonatomic) NSInteger br_year;
@property (nonatomic) NSInteger br_month;
@property (nonatomic) NSInteger br_day;

+ (NSString *)br_getDateString:(NSDate *)date format:(NSString *)formatter;
+ (NSDate *)br_getDate:(NSString *)dateStr format:(NSString *)formatter;
+ (NSInteger)br_getDaysInYear:(NSInteger)year month:(NSInteger)month;
+ (NSDate *)br_setYear:(NSInteger)year month:(NSInteger)month;
+ (NSDate *)br_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
- (int)br_compare:(NSDate *)date format:(NSString *)formatter;
@end

NS_ASSUME_NONNULL_END
