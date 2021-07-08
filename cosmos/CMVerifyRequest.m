//
//  CMVerifyRequest.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/5.
//

#import "CMVerifyRequest.h"

@implementation CMVerifyRequest

- (NSString *)baseURL{
    return @"http://47.108.237.77";
}

- (NSString *)path{
    return @"/assist/user/verify";
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
