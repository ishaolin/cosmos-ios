//
//  CMSchemeHandler.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/5.
//

#import "CMSchemeHandler.h"

#define COSMOS_SCHEME @"cosmos://"

@implementation CMSchemeHandler

+ (UINavigationController *)navigationController {
    return (UINavigationController *)[[UIApplication sharedApplication] cx_activeWindow].rootViewController;
}

+ (BOOL)isCosmosScheme:(id)url{
    NSString *URLString = nil;
    if([url isKindOfClass:[NSString class]]){
        URLString = (NSString *)url;
    }else if([url isKindOfClass:[NSURL class]]){
        URLString = ((NSURL *)url).absoluteString;
    }
    
    if(!URLString){
        return NO;
    }
    
    return [URLString hasPrefix:COSMOS_SCHEME];
}

+ (NSString *)makeCosmosScheme:(CXSchemeBusinessModule)module
                          page:(CXSchemeBusinessPage)page{
    return [self makeCosmosScheme:module page:page params:nil];
}

+ (NSString *)makeCosmosScheme:(CXSchemeBusinessModule)module
                          page:(CXSchemeBusinessPage)page
                        params:(NSDictionary<NSString *, id> *)params{
    NSString *url = [COSMOS_SCHEME stringByAppendingFormat:@"%@/%@", module, page];
    if(CXDictionaryIsEmpty(params)){
        return url;
    }
    
    return [url cx_URLStringByAppendingParams:params];
}

+ (void)handleSchemeForModule:(CXSchemeBusinessModule)module
                         page:(CXSchemeBusinessPage)page{
    [self handleSchemeForModule:module page:page params:nil];
}

+ (void)handleSchemeForModule:(CXSchemeBusinessModule)module
                         page:(CXSchemeBusinessPage)page
                       params:(NSDictionary<NSString *, id> *)params{
    NSString *url = [self makeCosmosScheme:module page:page];
    [self handleOpenURLString:url params:params];
}

@end

CXSchemeBusinessModule const CMSchemeBusinessModuleCosmos = @"cosmos";

CXSchemeBusinessPage const CMSchemeBusinessSettingPage = @"setting_page";
