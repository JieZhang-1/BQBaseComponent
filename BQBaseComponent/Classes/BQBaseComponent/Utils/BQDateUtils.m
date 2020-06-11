//
//  BQDateUtils.m
//  BQProject
//
//  Created by ZhangJie on 2019/6/30.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import "BQDateUtils.h"

@interface BQDateUtils()
@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;
@property (nonatomic, strong, readwrite) NSCalendar *calendar;

@end
@implementation BQDateUtils

- (id)init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_calendar setLocale:[NSLocale currentLocale]];
        [_calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [_dateFormatter setCalendar:_calendar];
    }
    return self;
}

+ (NSString *)currentdateInterval {
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}

+ (NSString *)getCurrentDateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [NSDate date];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    return nowDateString;
}

+ (NSString *)getCurrentDateYMDStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowDate = [NSDate date];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    return nowDateString;
}

+ (NSDate *)getCurrentDate {
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    return nowDate;
}

+ (NSString *)getCurrentYear {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy"];
    return [timeTool.dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)getCurrentMonth {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"MM"];
    return [timeTool.dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)MStringFromNowDate{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"M"];
    return [timeTool.dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)getMDStringFromYMDString:(NSString *)y_m_dString {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:NSLocalizedString(@"MM.dd", @"")];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSString *)getYMDStringFromYMDString:(NSString *)y_m_dString {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:NSLocalizedString(@"yyyy.MM.dd", @"")];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSString *)getCNYMDStringFromYMDString:(NSString *)y_m_dString {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", @"")];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSDate *)dateFromY_M_D_String:(NSString *)y_m_dString {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [timeTool.dateFormatter dateFromString:y_m_dString];
}

+ (NSDate *)dateFromY_M_D_String2:(NSString *)y_m_dString {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[timeTool.dateFormatter dateFromString:y_m_dString]];
    NSDate *date = [[timeTool.dateFormatter dateFromString:y_m_dString]  dateByAddingTimeInterval: interval];
    return date;
}

+ (NSString *)getM_DStringFromDateString:(NSString *)y_m_dString{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:@"MM-dd"];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSString *)getM_DStringFromDateString2:(NSString *)y_m_dString{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:@"MM-dd"];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSString *)getM_DStringFromDateString3:(NSString *)y_m_dString{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:@"MM.dd"];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSString *)getY_M_DStringFromDateString:(NSString *)y_m_dString{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [timeTool.dateFormatter dateFromString:y_m_dString];
    [timeTool.dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [timeTool.dateFormatter stringFromDate:inputDate];
}

+ (NSString *)getDStringFromDateString:(NSDate *)date {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"dd"];
    return [timeTool.dateFormatter stringFromDate:date];
}

+ (NSString *)getMDStringFromDate:(NSDate *)date {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    [timeTool.dateFormatter setDateFormat:@"MM-dd"];
    NSString *dateStr = [timeTool.dateFormatter stringFromDate:date];
    return dateStr;
}

+ (BOOL )isLaterOrEquelToday:(NSDate *)anotherDate {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDateComponents *comps = [timeTool.calendar components:NSCalendarUnitHour | kCFCalendarUnitDay
                                                   fromDate:[NSDate date]
                                                     toDate:anotherDate
                                                    options:0];
    
    return [comps day] >= 0;
}

+ (BOOL )isBeforeOrEquelToday:(NSDate *)anotherDate {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDateComponents *comps = [timeTool.calendar components:NSCalendarUnitHour | kCFCalendarUnitDay
                                                   fromDate:[NSDate date]
                                                     toDate:anotherDate
                                                    options:0];
    
    return [comps day] < 0 || (([comps day] == 0) && ([comps hour] < 0));
}

+ (BOOL )isDateInToday:(NSDate *)anotherDate {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    return [timeTool.calendar isDateInToday:anotherDate];
}

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSCalendar *currentCalendar = timeTool.calendar;
    NSDateComponents *comp = [currentCalendar components:NSCalendarUnitDay
                                                fromDate:fromDate
                                                  toDate:toDate
                                                 options:NSCalendarWrapComponents];
    return comp.day;
}

+ (BOOL )isLaterToday:(NSDate *)anotherDate {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDateComponents *comps = [timeTool.calendar components:NSCalendarUnitHour | kCFCalendarUnitDay
                                                   fromDate:[NSDate date]
                                                     toDate:anotherDate
                                                    options:0];
    
    return [comps day] > 0 || [comps hour] > 0;
}


+ (NSString *)time_timestampToString:(NSInteger)timestamp{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp dateByAddingTimeInterval:interval];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* string=[timeTool.dateFormatter stringFromDate:localeDate];
    return string;
}

+ (NSString *)time_timestampToString2:(NSInteger)timestamp{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp dateByAddingTimeInterval:interval];
    [timeTool.dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString* string=[timeTool.dateFormatter stringFromDate:localeDate];
    return string;
}

+ (NSString *)time_timestampToString3:(NSInteger)timestamp{
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp dateByAddingTimeInterval:interval];
    [timeTool.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[timeTool.dateFormatter stringFromDate:localeDate];
    return string;
}

+ (NSString *)dateFromM_D_String:(NSInteger)timestamp {
    BQDateUtils *timeTool = [[BQDateUtils alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp dateByAddingTimeInterval:interval];
    [timeTool.dateFormatter setDateFormat:@"MM-dd"];
    NSString* string = [timeTool.dateFormatter stringFromDate:localeDate];
    return string;
}

+ (NSTimeInterval )deltaFrom:(NSDate *)date{
    NSDate *nowDate = [NSDate date]; // 当前日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSTimeInterval delta = [nowDate timeIntervalSinceDate:date];
    return delta;
}
@end
