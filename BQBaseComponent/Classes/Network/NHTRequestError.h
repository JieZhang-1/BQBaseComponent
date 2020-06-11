//
//  NHTRequestError.h
//  NHTCreditCard
//
//  Created by ZhangJie on 2019/3/21.
//  Copyright © 2019 ChangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kHTTPRequstError  NSLocalizedString(@"参数错误，请稍后再试", nil)
@interface NHTRequestError : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong, nullable) NSString *messge;

+ (nonnull instancetype)errorWithCode:(NSInteger)code messge:(NSString * __nullable)errormsg;
- (nonnull instancetype)initWithCode:(NSInteger)code messge:(NSString * __nullable)errormsg;

@end

@interface NHTRequestErrorMsg : NSObject

/**
 *  http 请求返回response，通过response返回错误信息，返回nil表示成功。
 *  @param responseDict http请求reponse信息。
 *  @return http请求错误信息，如果为nil，请求成功。
 */
+ (NSString *)errorMsgWithResponseDict:(NSDictionary *)responseDict;

/**
 *  http 请求返回response，通过response返回错误信息，为nil表示没有进行网络请求。
 *  @param response http请求reponse信息。
 *  @param error    系统错误error
 *  @return http请求错误信息，如果为nil，请求成功。
 */
+ (NSString *)errorMsgWithResponse:(NSHTTPURLResponse *)response error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
