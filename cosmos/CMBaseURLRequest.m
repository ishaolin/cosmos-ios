//
//  CMBaseURLRequest.m
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import "CMBaseURLRequest.h"
#import "CMURLRequestParams.h"

@implementation CMBaseURLRequest

- (instancetype)init{
    if(self = [super init]){
        self.signKey = [CMURLRequestParams signParamKey];
    }
    
    return self;
}

- (NSString *)baseURL{
    return @"";
}

- (NSDictionary<NSString *,id> *)commonParams{
    return [CMURLRequestParams commonParams];
}

@end
