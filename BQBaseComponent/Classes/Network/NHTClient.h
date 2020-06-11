//
//  NHTClient.h
//  NHTCreditCard
//
//  Created by ZhangJie on 2019/3/20.
//  Copyright © 2019 ChangYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NHTBaseRequestApi.h"
NS_ASSUME_NONNULL_BEGIN

@interface NHTClient : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (void)execute:(NHTBaseRequestApi *)request;
@end


NS_ASSUME_NONNULL_END
