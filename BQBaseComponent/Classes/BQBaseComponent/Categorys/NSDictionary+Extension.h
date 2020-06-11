//
//  NSDictionary+Extension.h
//  BQProject
//
//  Created by ZhangJie on 2019/6/28.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

- (NSString *)stringValueForKey:(NSString *)key;
- (NSNumber *)numberDoubleValueForKey:(NSString *)key;
- (NSNumber *)numberIntValueForKey:(NSString *)key;
- (NSDictionary *)checkValueNull;

@end

NS_ASSUME_NONNULL_END
