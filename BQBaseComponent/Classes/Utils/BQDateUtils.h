//
//  BQDateUtils.h
//  BQProject
//
//  Created by ZhangJie on 2019/6/30.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQDateUtils : NSObject
+ (NSString *) currentdateInterval;
+ (NSString *) getCurrentDateStr;
+ (NSDate *)getCurrentDate;
+ (NSString *)getCurrentDateYMDStr;
// 获取当前时间年份
+ (NSString *)getCurrentYear;
// 获取当前时间月份
+ (NSString *)getCurrentMonth;
+ (NSString *)MStringFromNowDate;
+ (NSString *)getMDStringFromYMDString:(NSString *)y_m_dString;
+ (NSString *)getYMDStringFromYMDString:(NSString *)y_m_dString;
+ (NSString *)getCNYMDStringFromYMDString:(NSString *)y_m_dString;
+ (NSString *)getM_DStringFromDateString:(NSString *)y_m_dString;
+ (NSString *)getM_DStringFromDateString2:(NSString *)y_m_dString;
+ (NSString *)getM_DStringFromDateString3:(NSString *)y_m_dString;
+ (NSString *)getY_M_DStringFromDateString:(NSString *)y_m_dString;
+ (NSString *)getDStringFromDateString:(NSDate *)date;
+ (NSString *)getMDStringFromDate:(NSDate *)date;

+ (NSDate *)dateFromY_M_D_String:(NSString *)y_m_dString;
+ (NSDate *)dateFromY_M_D_String2:(NSString *)y_m_dString;
+ (NSString *)time_timestampToString:(NSInteger)timestamp;
+ (NSString *)time_timestampToString2:(NSInteger)timestamp;
+ (NSString *)time_timestampToString3:(NSInteger)timestamp;
+ (NSString *)dateFromM_D_String:(NSInteger)timestamp;
+ (BOOL )isDateInToday:(NSDate *)anotherDate;
+ (BOOL )isBeforeOrEquelToday:(NSDate *)anotherDate;
+ (BOOL )isLaterOrEquelToday:(NSDate *)anotherDate;
+ (BOOL )isLaterToday:(NSDate *)anotherDate;
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
 // 传入时间与当前时间的差值
+ (NSTimeInterval)deltaFrom:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
