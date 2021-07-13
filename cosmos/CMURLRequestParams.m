//
//  CMURLRequestParams.m
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import "CMURLRequestParams.h"

@implementation CMURLRequestParams

+ (NSString *)signParamKey{
    return @"sig";
}

+ (NSString *)signPrivateKey{
    return @"cosmos";
}

+ (NSDictionary<NSString *,id> *)commonParams{
    return nil;
}

@end
