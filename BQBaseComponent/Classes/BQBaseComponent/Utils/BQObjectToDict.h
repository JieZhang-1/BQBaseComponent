//
//  BQObjectToDict.h
//  BQPartnerProject
//
//  Created by Zhang Jie on 2020/4/22.
//  Copyright © 2020 BiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BQObjectToDict : NSObject

+ (NSDictionary*)getObjectData:(id)obj;

+ (NSString *)getJsonWithDict:(NSDictionary *)dict;

+ (int)getRandomNumber:(int)from to:(int)to;
@end

NS_ASSUME_NONNULL_END
