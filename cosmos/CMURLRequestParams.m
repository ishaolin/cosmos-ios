//
//  CMURLRequestParams.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import "CMURLRequestParams.h"

@implementation CMURLRequestParams

+ (NSString *)signParamKey{
    return @"sig";
}

+ (NSString *)signPrivateKey{
    return @"cosmos_app";
}

+ (NSDictionary<NSString *,id> *)commonParams{
    return nil;
}

@end
