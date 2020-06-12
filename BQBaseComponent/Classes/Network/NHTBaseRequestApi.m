//
//  NHTRequestApi.m
//  AFNetworking
//
//  Created by ZhangJie on 2020/6/11.
//

#import "NHTBaseRequestApi.h"

@interface NHTBaseRequestApi()
{
    NSString *_urlStr;
}
@end

@implementation NHTBaseRequestApi
@synthesize params = _params;

- (instancetype)init {
    if (self = [super init]) {
        //self.params = [NSMutableDictionary dictionary];
        //[self appendBaseParams];
        _accessType = kRequestAccessGet;
    }
    return self;
}

- (instancetype)initWithRequestUrl:(NSString *)url {
    if (self = [self init]) {
        _urlStr = url;
    }
    return self;
}

- (RequestAccessType)accessType {
    return _accessType;
}

- (NSTimeInterval)timeout {
    return defaultAPIRequestTimeOutSeconds;
}

- (NSString *)baseUrl {
    return @"";//kHTTPS_REQUEST_BASE;
}

- (NSString *)apiUrl {
    return _urlStr;
}

- (NSMutableDictionary *)params {
    return _params;
}

- (void)setParams:(NSMutableDictionary *)params {
    //[params setValue:sign forKey:@"sign"];
    // 签名处理
    _params = params;
}

- (void)callBackFinishedWithDictionary:(NSDictionary *)dic {
    if (self.successBlock) {
        self.successBlock(dic);
    }
}

- (void)callBackFailed:(NHTRequestError *)error {
    if (self.failBlock) {
        self.failBlock(error);
    }
}

- (NSDictionary *)baseParams {
    NSInteger ts = (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000);
    NSMutableDictionary *baseParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"1", @"version",
                                       (self.shaSign?@"sha":@"rsa"), @"signType",
                                       @"cs", @"proType",
                                       [NSString stringWithFormat:@"%ld", (long)ts], @"timestamp",
                                       @"0",@"platform",
                                       @"2",@"clientType",
                                       nil];
    return baseParams;
}

@end
