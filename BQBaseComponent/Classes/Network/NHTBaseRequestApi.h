//
//  NHTRequestApi.h
//  AFNetworking
//
//  Created by ZhangJie on 2020/6/11.
//

#import <Foundation/Foundation.h>
#import "NHTRequestError.h"
NS_ASSUME_NONNULL_BEGIN
#define defaultAPIRequestTimeOutSeconds     15
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

@interface NHTBaseRequestApi:NSObject

@property (nonatomic, readonly) NSString *apiUrl;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, copy) NHTRequestSuccessedBlock successBlock;
@property (nonatomic, copy) NHTRequestFailedBlock failBlock;
@property (nonatomic, assign) BOOL shaSign;
@property (nonatomic) RequestTransferType transferType;
@property (nonatomic) RequestAccessType accessType;
@property (nonatomic, readonly) ApiResultFormat resultFormat;
@property (nonatomic, readonly) NSTimeInterval timeout;

- (instancetype)initWithRequestUrl:(NSString *)url;
- (void)callBackFinishedWithDictionary:(NSDictionary *)dic;
- (void)callBackFailed:(NHTRequestError *)error;
- (void)appendBaseParams;
@end

NS_ASSUME_NONNULL_END
