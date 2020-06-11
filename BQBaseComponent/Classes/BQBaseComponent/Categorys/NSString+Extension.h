//
//  NSString+Extension.h
//  BQProject
//
//  Created by ZhangJie on 2019/7/12.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)
+ (BOOL)hasEmoji:(NSString*)string;
+ (BOOL)stringContainsEmoji:(NSString *)string;
- (NSString *)trimCharacters;
- (BOOL)validateMobileNum;
- (BOOL)validateMVCode;
- (BOOL)validatePasswd;
- (NSString *)moblieNumToAsterisk;
- (NSString *)replaceSpacesFromString;
- (BOOL)emailValid;
+ (NSString *)moneyStringWithdouble:(double)money; // 格式化钱
+ (NSString *)moblieFormat:(NSString *)moblie;
+ (NSString *)formatterBankCardNum:(NSString *)string;
+ (NSString *)md5:(NSString *)input;
- (NSString *)cardNoToAsterisk;
- (NSString *)stringRemoveBlank;
- (BOOL)notNilOrEmpty;
@end

NS_ASSUME_NONNULL_END
