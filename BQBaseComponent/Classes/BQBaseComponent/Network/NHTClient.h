//
//  NHTClient.h
//  NHTCreditCard
//
//  Created by ZhangJie on 2019/3/20.
//  Copyright © 2019 ChangYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NHTRequestError.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum RequestAccessType {
    kRequestAccessGet,                      // Get方式
    kRequestAccessPost,                     // Post方式
    kRequestAccessUpload,                   // 上传
    kRequestAccessMultiUpload              // 多张图片上传
}RequestAccessType;

typedef enum RequestResultFormat {
    kRequestResultJson,                     // Json格式
    kRequestResultXml,                      // Xml格式
}ApiResultFormat;

typedef enum RequestTransferType {
    RequestTransferHttp,
    RequestTransferTcp,
    RequestTransferUdp,
}RequestTransferType;

typedef  void(^NHTRequestSuccessedBlock)(id response);
typedef  void(^NHTRequestFailedBlock)(NHTRequestError *error);

@protocol NHTRequestProtocol <NSObject>

@required
@property (nonatomic, readonly) NSString *apiUrl;
@property (nonatomic, strong) NSMutableDictionary *params;
- (instancetype)initWithRequestUrl:(NSString *)url;
- (void)callBackFinishedWithDictionary:(NSDictionary *)dic;
- (void)callBackFailed:(NHTRequestError *)error;
@optional
@property (nonatomic, assign) BOOL shaSign;
@property (nonatomic) RequestTransferType transferType;
@property (nonatomic) RequestAccessType accessType;
@property (nonatomic, readonly) ApiResultFormat resultFormat;
@property (nonatomic, readonly) NSTimeInterval timeout;

@end


@interface NHTClient : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (void)execute:(id <NHTRequestProtocol>)request;
@end


NS_ASSUME_NONNULL_END
