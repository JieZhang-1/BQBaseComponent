//
//  NSDictionary+Extension.m
//  BQProject
//
//  Created by ZhangJie on 2019/6/28.
//  Copyright © 2019 hb.wuhan.com.BiQuan. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)stringValueForKey:(NSString *)key {
    if (!key) return nil;
    
    if (!(self && [self isKindOfClass:[NSDictionary class]] && [self count])) {
        return nil;
    }
    
    NSString *value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return value;
    } else if (value && [value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    }
    return nil;
}

- (NSNumber *)numberDoubleValueForKey:(NSString *)key {
    if (!key) return nil;
    
    if (!(self && [self isKindOfClass:[NSDictionary class]] && [self count])) {
        return nil;
    }
    
    NSNumber *value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if (value && [value isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithDouble:[(NSString *)value doubleValue]];
    }
    
    return nil;
}

- (NSNumber *)numberIntValueForKey:(NSString *)key
{
    if (!key) return nil;
    
    if (!(self && [self isKindOfClass:[NSDictionary class]] && [self count])) {
        return nil;
    }
    
    NSNumber *value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if (value && [value isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithInteger:[(NSString *)value integerValue]];
    }
    
    return nil;
}

- (NSDictionary *)checkValueNull
{
    __block NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:self];
    [mutableDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        @try {
            if (obj == [NSNull null] || obj == nil) {
                obj=@"";
            }else if ([obj isKindOfClass:[NSNumber class]]) {
                obj = [NSString stringWithFormat:@"%@",obj];
            }
            [mutableDict setValue:obj forKey:key];
        } @catch (NSException *exception) {
            NSLog(@"exception:%@",exception);
        } @finally {
            
        }
    }];
    return mutableDict;
}

@end
