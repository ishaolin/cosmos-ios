//
//  CMURLRequestParams.h
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import <Foundation/Foundation.h>

@interface CMURLRequestParams : NSObject

+ (NSString *)signParamKey;

+ (NSString *)signPrivateKey;

+ (NSDictionary<NSString *,id> *)commonParams;

@end
