//
//  NSString+Extension.m
//  BQProject
//
//  Created by ZhangJie on 2019/7/12.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

/**
*  判断字符串中是否存在emoji
* @param string 字符串
* @return YES(含有表情)
*/
+ (BOOL)stringContainsEmoji:(NSString *)string {
   
   __block BOOL returnValue = NO;
   
   [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
    ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
            
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
   
    return returnValue;
}

/**
*  判断字符串中是否存在emoji
* @param string 字符串
* @return YES(含有表情)
*/
+ (BOOL)hasEmoji:(NSString*)string
{
   NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
   NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
   BOOL isMatch = [pred evaluateWithObject:string];
   return isMatch;
}

- (NSString *)trimCharacters
{
    NSString *trimString = [self stringByReplacingOccurrencesOfString:@"[^0-9]"
                                                           withString:@""
                                                              options:NSRegularExpressionSearch
                                                                range:NSMakeRange(0, [self length])];
    return trimString;
}

- (BOOL)validateMobileNum
{
    NSString *mobileRegex = @"^((19[0-9])|(16[0-9])|(17[0-9])|(14[0-9])|(13[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    //NSString *mobileRegex = @"^1[3-9]\\d{9}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    return [mobileTest evaluateWithObject:self];
}

- (BOOL)validatePasswd
{
    //含有字母、数字两种组合，6-16位
    NSString * pwdRegex = @"^(?![^a-zA-Z]+$)(?!\\D+$).{6,16}$";//@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateMVCode {
    NSString * mvcodeRegex = @"^[0-9]{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mvcodeRegex];
    return [pred evaluateWithObject:self];
}

- (NSString *)moblieNumToAsterisk {
    if (self.length < 7) {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}

- (NSString *)cardNoToAsterisk {
    if (self.length < 17) {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(1,16) withString:@"****************"];
}

- (NSString *)replaceSpacesFromString {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (BOOL)emailValid {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

+ (NSString *)moneyStringWithdouble:(double)money {
    NSString *moneyString = [NSString stringWithFormat:@"%.2f", money];
    NSNumber *moneyNumber = [NSNumber numberWithDouble:[moneyString doubleValue]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.roundingMode = kCFNumberFormatterRoundCeiling;
    formatter.currencyCode = @"RMB";
    NSString *returnValue=[formatter stringFromNumber:moneyNumber];
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,."] invertedSet];
    NSString *subString = [returnValue substringFromIndex:1];
    NSString *filtered = [[subString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return filtered;
}

+ (NSString *)moblieFormat:(NSString *)moblie {
    NSString *tenDigitNumber = [moblie stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{4})(\\d{4})"
                                                               withString:@"$1 $2 $3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [moblie length])];
    return tenDigitNumber;
}

+ (NSString *)formatterBankCardNum:(NSString *)string {
    NSString *tempStr=string;
    NSInteger size =(tempStr.length / 4);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++) {
        [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*4, (tempStr.length % 4))]];
    tempStr = [tmpStrArr componentsJoinedByString:@" "];
    return tempStr;
}

+ (NSString *) md5:(NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD2_DIGEST_LENGTH;i++){
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)stringRemoveBlank{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)notNilOrEmpty {
    if (self && [self stringRemoveBlank].length > 0) {
        return YES;
    }
    return NO;
}
@end
