//
//  CMURLRequestParams.h
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import <Foundation/Foundation.h>

@interface CMURLRequestParams : NSObject

+ (NSString *)signParamKey;

+ (NSString *)signPrivateKey;

+ (NSDictionary<NSString *,id> *)commonParams;

@end
