//
//  NHTRequestError.m
//  NHTCreditCard
//
//  Created by ZhangJie on 2019/3/21.
//  Copyright © 2019 ChangYu. All rights reserved.
//

#import "NHTRequestError.h"

@implementation NHTRequestError

+ (instancetype)errorWithCode:(NSInteger)code messge:(NSString *)errormsg
{
    return [[self alloc] initWithCode:code messge:errormsg];
}

- (instancetype)initWithCode:(NSInteger)code messge:(NSString *)errormsg
{
    self = [super init];
    if (self) {
        self.code = code;
        self.messge = errormsg;
    }
    return self;
}

@end

@implementation NHTRequestErrorMsg
+ (NSString *)errorMsgWithResponseDict:(NSDictionary *)responseDict
{
    NSInteger errorCode = [responseDict[@"code"] integerValue];
    NSString *errorMsg = responseDict[@"msg"];
    switch (errorCode) {
        case 30008: // 登录过期
            //[MBProgressHUD showError:@"登录已过期，请重新登录" toView:UIApplication.sharedApplication.keyWindow];
            //[BQDataManager.manager clearToken];
            return NSLocalizedString(@"登录已过期，请重新登录", nil);
            break;
//        case 40001:
//            [BQDataManager.manager clearToken];
//            return NSLocalizedString(@"token已过期", nil);
        case 30003: // 时间戳
            return NSLocalizedString(@"请求失败，请检查您的网络！", nil);
            break;
        default:
            break;
    }
    if (errorCode != 10000) {
        if (errorMsg) {
            return errorMsg;
        }
//        else {
//            return @"系统服务出错";
//        }
    }
//    else {
        return nil;
//    }
    //return NSLocalizedString(@"系统服务出错，请稍后再试", nil);
}

// NSURLError.h
+ (NSString *)errorMsgWithResponse:(NSHTTPURLResponse *)response error:(NSError *)error
{
    if (response == nil) {
        switch (error.code) {
            case NSURLErrorTimedOut:
            {
                return NSLocalizedString(@"请求失败，请检查您的网络", nil);
            }
                break;
            case NSURLErrorNotConnectedToInternet:
            {
                return NSLocalizedString(@"请求失败，请检查您的网络", nil);
            }
                break;
                
            default:
                break;
        }
        return NSLocalizedString(@"请求失败，请检查您的网络", nil);
    }
    return NSLocalizedString(@"请求失败，请检查您的网络", nil);
}
@end
