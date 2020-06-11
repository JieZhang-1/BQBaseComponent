//
//  NSDate+Extension.m
//  BQPartnerProject
//
//  Created by Zhang Jie on 2020/4/27.
//  Copyright © 2020 BiQuan. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSInteger)br_year {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSInteger year = [comps year];
    return year;
}

- (void)setBr_year:(NSInteger)br_year {
    
}

- (void)setBr_month:(NSInteger)br_month {
    
}

- (void)setBr_day:(NSInteger)br_day {
    
}

- (NSInteger)br_month {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:NSCalendarUnitMonth fromDate:self];
    NSInteger month = [comps month];
    return month;
}

- (NSInteger)br_day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:NSCalendarUnitDay fromDate:self];
    NSInteger day = [comps day];
    return day;
}


+ (NSString *)br_getDateString:(NSDate *)date format:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)br_getDate:(NSString *)dateStr format:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateStr];
}

+ (NSDate *)br_setYear:(NSInteger)year month:(NSInteger)month {
    return [self br_setYear:year month:month day:1];
}

+ (NSDate *)br_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    return [dateFormatter dateFromString:dateStr];
}

+ (NSInteger)br_getDaysInYear:(NSInteger)year month:(NSInteger)month {
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12)){
        return 31 ;
    }
           
    if((month == 4) || (month == 6) || (month == 9) || (month == 11)){
        return 30;
    }
           
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3)){
        return 28;
    }
       
    if(year % 400 == 0){
        return 29;
    }
           
    if(year % 100 == 0){
         return 28;
    }
       
    return 29;
}

//- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
- (int)br_compare:(NSDate *)date format:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *oneDayStr = [dateFormatter stringFromDate:self];
    NSString *anotherDayStr = [dateFormatter stringFromDate:date];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];

    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
             
}
@end
