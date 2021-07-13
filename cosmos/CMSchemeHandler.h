//
//  CMSchemeHandler.h
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import <CXUIKit/CXUIKit.h>

@interface CMSchemeHandler : CXSchemeHandler

+ (BOOL)isCosmosScheme:(id)url;

+ (NSString *)makeCosmosScheme:(CXSchemeBusinessModule)module
                          page:(CXSchemeBusinessPage)page;

+ (NSString *)makeCosmosScheme:(CXSchemeBusinessModule)module
                          page:(CXSchemeBusinessPage)page
                        params:(NSDictionary<NSString *, id> *)params;

+ (void)handleSchemeForModule:(CXSchemeBusinessModule)module
                         page:(CXSchemeBusinessPage)page;

+ (void)handleSchemeForModule:(CXSchemeBusinessModule)module
                         page:(CXSchemeBusinessPage)page
                       params:(NSDictionary<NSString *, id> *)params;

@end

CX_UIKIT_EXTERN CXSchemeBusinessModule const CMSchemeBusinessModuleCosmos;

CX_UIKIT_EXTERN CXSchemeBusinessPage const CMSchemeBusinessSettingPage;
CX_UIKIT_EXTERN CXSchemeBusinessPage const CMSchemeBusinessTimerPage;
