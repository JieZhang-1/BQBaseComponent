//
//  NHTClient.m
//  NHTCreditCard
//
//  Created by ZhangJie on 2019/3/20.
//  Copyright © 2019 ChangYu. All rights reserved.
//
 
#import "NHTClient.h"
#import "NHTRequestError.h"
#import "NSDictionary+Extension.h"
@implementation NHTClient
+ (instancetype)sharedInstance {
    static NHTClient *netClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netClient = [[self alloc] init];
    });
    return netClient;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupSessionManager];
    }
    return self;
}

- (void)setupSessionManager {
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"multipart/form-data", nil];
    // 设置HTTPS加密
    //manager.requestSerializer.cont
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    self.manager.securityPolicy = securityPolicy;
}

- (void)executePostRequest:(NHTBaseRequestApi *)request {
        NSLog(@"%@",self.manager.tasks);
        [self.manager POST:request.apiUrl parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"\n url:%@,\n API:%@,\n responObject : %@", [task.currentRequest.URL absoluteString],[request.params objectForKey:@"api"],[responseObject description]);
            NSDictionary *resp = [responseObject checkValueNull];
            NSString *errorMsg = [NHTRequestErrorMsg errorMsgWithResponseDict:resp];
            if (!errorMsg) {
                NSDictionary *outDic = (NSDictionary *)resp;
                [request callBackFinishedWithDictionary:outDic];
            }else {
                NSInteger errorCode = [[resp valueForKey:@"code"] integerValue];
                if ([errorMsg isKindOfClass:NSNull.class]) {
                    errorMsg = @" ";
                }
                [request callBackFailed:[NHTRequestError errorWithCode:errorCode messge:errorMsg]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSString *errorMsg = [NHTRequestErrorMsg errorMsgWithResponse:response error:error];
            NSLog(@"\n url:%@,\n API:%@, \n error : %@", [task.currentRequest.URL absoluteString],[request.params objectForKey:@"api"],error);
            if (error.code) {
                [request callBackFailed:[NHTRequestError errorWithCode:error.code messge:errorMsg]];
            }else{
                [request callBackFailed:[NHTRequestError errorWithCode:response.statusCode messge:errorMsg]];
            }
            if ([[request.params objectForKey:@"api"] isEqualToString:@"app.addErrLogs"]) {
                return;
            }
            if (response.statusCode == 500) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                if ([request.params objectForKey:@"token"]) {
                    [dict setObject:[request.params objectForKey:@"token"] forKey:@"token"];
                }
                [dict setObject:[NSString stringWithFormat:@"%@",response] forKey:@"resultData"];
                [dict setObject:[task.currentRequest.URL absoluteString] forKey:@"url"];
                //[dict setObject:[BQDataManager.manager getJsonStrWithDict:request.params] forKey:@"requestData"];
                //[self uploadRequestError:dict];
            }
        }];
}

- (void)executeGetRequest:(NHTBaseRequestApi *)request {
        [self.manager GET:request.apiUrl parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"url:%@, responObject : %@", [task.currentRequest.URL absoluteString],[responseObject description]);
            NSDictionary *resp = [responseObject checkValueNull];
            NSString *errorMsg = [NHTRequestErrorMsg errorMsgWithResponseDict:resp];
            if (!errorMsg) {
                NSDictionary *outDic = (NSDictionary *)resp;
                [request callBackFinishedWithDictionary:outDic];
            }else {
                NSInteger errorCode = [[resp valueForKey:@"code"] integerValue];
                [request callBackFailed:[NHTRequestError errorWithCode:errorCode messge:errorMsg]];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *errorMsg = [NHTRequestErrorMsg errorMsgWithResponse:(NSHTTPURLResponse *)task.response error:error];
            [request callBackFailed:[NHTRequestError errorWithCode:error.code messge:errorMsg]];
        }];
}


- (void)executeUploadRequest:(NHTBaseRequestApi *)request {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *data = [request.params objectForKey:@"image"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data; boundary=BOUNDARY" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"multipart/form-data", nil];
    //post请求
    [manager POST:request.apiUrl parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            /*
             此方法参数
             1. 要上传的[二进制数据]
             2. 我这里的imgFile是对应后台给你url里面的图片参数，别瞎带。
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responObject---\n%@",responseObject);
            NSDictionary *resp = [responseObject checkValueNull];
            NSString *errorMsg = [NHTRequestErrorMsg errorMsgWithResponseDict:resp];
            if (!errorMsg) {
                NSDictionary *outDic = (NSDictionary *)resp;
                [request callBackFinishedWithDictionary:outDic];
            }else {
                NSInteger errorCode = [[resp valueForKey:@"code"] integerValue];
                [request callBackFailed:[NHTRequestError errorWithCode:errorCode messge:errorMsg]];
                NSLog(@"\n url:%@,\n API:%@, \n error : %@", [task.currentRequest.URL absoluteString],[request.params objectForKey:@"api"],errorMsg);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *errorMsg = [NHTRequestErrorMsg errorMsgWithResponse:(NSHTTPURLResponse *)task.response error:error];
            [request callBackFailed:[NHTRequestError errorWithCode:error.code messge:errorMsg]];
            NSLog(@"\n url:%@,\n API:%@, \n error : %@", [task.currentRequest.URL absoluteString],[request.params objectForKey:@"api"],error);
        }];
}

+ (void)execute:(NHTBaseRequestApi *)request {
    switch (request.accessType) {
        case kRequestAccessPost:
        {
            [NHTClient.sharedInstance executePostRequest:request];
            break;
        }
        case kRequestAccessGet:
        {
            [NHTClient.sharedInstance executeGetRequest:request];
            break;
        }
        case kRequestAccessUpload:
            [NHTClient.sharedInstance executeUploadRequest:request];
        default:
            break;
    }
}

//- (void)uploadRequestError:(NSDictionary *)dict {
//    NHTRequest *request = [[NHTRequest alloc] initWithRequestUrl:@""];
//    request.accessType = kRequestAccessPost;
//    NSMutableDictionary *par = [NSMutableDictionary dictionary];
//    [par addEntriesFromDictionary:dict];
//    [par setValue:@"app.addErrLogs" forKey:@"api"];
//    [par setValue:@"app" forKey:@"flag"];
//    [par setValue:@"IOS" forKey:@"plat_form"];
//    [par setValue:BQDeviceInfo.getCurrentDeviceModel forKey:@"phoneMode"];
//    [par setValue:BQDeviceInfo.phoneVersion forKey:@"systemVersion"];
//    [par setValue:BQDeviceInfo.appCurrentVersion forKey:@"app_version"];
//    request.params = par;
//    request.successBlock = ^(id response) {
//
//    };
//    request.failBlock = ^(NHTRequestError *error) {
//
//    };
//    [NHTClient execute:request];
//}

//pragma mark -- 上传图片 --


@end
