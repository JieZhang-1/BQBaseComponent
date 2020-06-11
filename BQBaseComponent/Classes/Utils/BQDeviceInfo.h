//
//  BQDeviceInfo.h
//  BQProject
//
//  Created by Zhang Jie on 2019/9/11.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQDeviceInfo : NSObject
// 获取电池电量(一般用百分数表示,自行处理就好)
+ (CGFloat)getBatteryQuantity;
// 获取电池状态(UIDeviceBatteryState为枚举类型)
+ (UIDeviceBatteryState)getBatteryStauts;
// 获取总内存大小
+ (long long)getTotalMemorySize;
// 获取当前可用内存
+ (long long)getAvailableMemorySize;
//获取已使用内存
+ (double)getUsedMemory;
// 获取总磁盘容量
+ (long long)getTotalDiskSize;
// 获取可用磁盘容量
+ (long long)getAvailableDiskSize;
// 容量转换
+ (NSString *)fileSizeToString:(unsigned long long)fileSize;
// 获取机型型号
+ (NSString *)getCurrentDeviceModel;
// IP地址
+ (NSString *)deviceIPAdress;
//当前手机连接的WIFI名称(SSID)
+ (NSString *)getWifiName;
// 网络运营商
+ (NSString *)networkInfo;
+ (NSString *)getDeviceUUID;
+ (NSString *)getUserPhoneName;
+ (NSString *)getDeviceName;
+ (NSString *)phoneVersion;
+ (NSString *)localPhoneModel;
+ (NSString *)appCurrentVersion;
+ (NSString *)appCurrentVersionNum;
@end

NS_ASSUME_NONNULL_END
