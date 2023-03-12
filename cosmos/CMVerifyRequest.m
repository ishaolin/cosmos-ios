//
//  CMVerifyRequest.m
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import "CMVerifyRequest.h"

@implementation CMVerifyRequest

- (NSString *)baseURL{
    return @"http://application.yxjt.vip/auth";
}

- (NSString *)path{
    return @"/api/user/v1/phone_login";
}

- (CXHTTPMethod)method{
    return CXHTTPMethod_POST;
}

- (id)modelWithData:(id)data{
    return [CMVerifyModel cx_modelWithData:data];
}

@end

@implementation CMVerifyModel

@end

@implementation CMVerifyDataModel

@end
