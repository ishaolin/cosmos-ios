//
//  CMSharedPayHandler.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import "CMSharedPayHandler.h"
#import <CXShareSDK/CXShareSDK.h>
#import <CXPaySDK/CXPaySDK.h>

@interface CMSharedPayHandler ()<CMOpenSDKDelegate>{
    
}

@property (nonatomic, strong) CMOpenSDKDelegate *weChatDelegate;
@property (nonatomic, strong) CMOpenSDKDelegate *alipayDelegate;
@property (nonatomic, strong) CMOpenSDKDelegate *QQDelegate;
@property (nonatomic, strong) CMOpenSDKDelegate *weiboDelegate;

@end

@implementation CMSharedPayHandler

- (CMOpenSDKDelegate *)weChatDelegate{
#ifdef CM_INCLUDE_WECHAT_SDK
    if(!_weChatDelegate){
        _weChatDelegate = [[CMOpenWeChatDelegate alloc] initWithDelegate:self];
    }
#endif
    return _weChatDelegate;
}

- (CMOpenSDKDelegate *)alipayDelegate{
#ifdef CM_INCLUDE_WECHAT_SDK
    if(!_alipayDelegate){
        _alipayDelegate = [[CMOpenAlipayDelegate alloc] initWithDelegate:self];
    }
#endif
    return _alipayDelegate;
}

- (CMOpenSDKDelegate *)QQDelegate{
#ifdef CM_INCLUDE_WECHAT_SDK
    if(!_QQDelegate){
        _QQDelegate = [[CMOpenQQDelegate alloc] initWithDelegate:self];
    }
#endif
    return _QQDelegate;
}

- (CMOpenSDKDelegate *)weiboDelegate{
#ifdef CM_INCLUDE_WECHAT_SDK
    if(!_weiboDelegate){
        _weiboDelegate = [[CMOpenWeiboDelegate alloc] initWithDelegate:self];
    }
#endif
    return _weiboDelegate;
}

- (void)setup{
    NSString *weChatUniversalLink = @"https://com.study.cosmos/demo/wechat/";
    [CXPayService defaultService].weChatUniversalLink = weChatUniversalLink;
    
    CXSharePlatformKey *weChat = [CXSharePlatformKey keyWithPlatform:CXSharePlatformWeChat
                                                               appId:@""
                                                       universalLink:weChatUniversalLink];
    
    CXSharePlatformKey *alipay = [CXSharePlatformKey keyWithPlatform:CXSharePlatformAlipay
                                                               appId:@"2021002156654509"
                                                       universalLink:nil];
    CXSharePlatformKey *QQ = [CXSharePlatformKey keyWithPlatform:CXSharePlatformQQ
                                                           appId:@"1106936161"
                                                   universalLink:@"https://com.study.cosmos/demo/qq/"];
    
    CXSharePlatformKey *weibo = [CXSharePlatformKey keyWithPlatform:CXSharePlatformWeibo
                                                              appId:@""
                                                      universalLink:@"https://com.study.cosmos/demo/weibo/"];
    
    [[CXShareSDKManager sharedManager] registerPlatformKeys:@[weChat, alipay, QQ, weibo]];
}

- (void)handleOpenURL:(NSURL *)url{
    // 支付宝支付 | 银联支付
    if([url.scheme isEqualToString:SCHEME_ALIPAY]){
        if([url.host isEqualToString:@"safepay"]){ // 支付宝
            [[CXPayService defaultService] handleAlipayOpenURL:url];
        }else{ // 银联
            [[CXPayService defaultService] handleUnionPayOpenURL:url];
        }
        
        return;
    }
    
    // 支付宝登录授权
    if([url.scheme isEqualToString:@""]){
        return;
    }
    
    // 支付宝分享
    if([url.scheme isEqualToString:@"alipayshare"]){
        // alipayshare是固定的
        [self handleAlipayOpenURL:url universalLink:nil];
        return;
    }
    
    // 微信分享 | 微信登录 | 微信支付
    if([url.scheme isEqualToString:@"WECHAT_SHARE_APP_KEY"] ||
       [url.scheme isEqualToString:@"WECHAT_LOGIN_APP_KEY"] ||
       [url.scheme isEqualToString:@"WECHAT_PAY_APP_KEY_1"] ||
       [url.scheme isEqualToString:@"WECHAT_PAY_APP_KEY_2"] ||
       [url.scheme isEqualToString:@"WECHAT_PAY_APP_KEY_3"]){
        [self handleWechatOpenURL:url universalLink:nil];
        return;
    }
    
    // QQ分享
    if([url.scheme isEqualToString:@"WECHAT_SHARE_APP_KEY"]){
        [self handleQQOpenURL:url universalLink:nil];
        return;
    }
    
    // 微博分享
    if([url.scheme isEqualToString:@"WECHAT_SHARE_APP_KEY"]){
        [self handleWeiboOpenURL:url universalLink:nil];
        return;
    }
}

- (void)handleOpenUniversalLink:(NSUserActivity *)userActivity{
    [self handleWechatOpenURL:nil universalLink:userActivity];
    [self handleAlipayOpenURL:nil universalLink:userActivity];
    [self handleQQOpenURL:nil universalLink:userActivity];
    [self handleWechatOpenURL:nil universalLink:userActivity];
}

- (void)handleAlipayOpenURL:(NSURL *)url universalLink:(NSUserActivity *)userActivity{
#ifdef CM_INCLUDE_ALIPAY_SDK
    id<APOpenAPIDelegate> delegate = (id<APOpenAPIDelegate>)self.alipayDelegate;
    if(userActivity){
        // 预留
    }else{
        [APOpenAPI handleOpenURL:url delegate:delegate];
    }
#endif
}

- (void)handleWechatOpenURL:(NSURL *)url universalLink:(NSUserActivity *)userActivity{
#ifdef CM_INCLUDE_WECHAT_SDK
    id<WXApiDelegate> delegate = (id<WXApiDelegate>)self.weChatDelegate;
    if(userActivity){
        [WXApi handleOpenUniversalLink:userActivity delegate:delegate];
    }else{
        [WXApi handleOpenURL:url delegate:delegate];
    }
#endif
}

- (void)handleQQOpenURL:(NSURL *)url universalLink:(NSUserActivity *)userActivity{
#ifdef CM_INCLUDE_QQ_SDK
    id<QQApiInterfaceDelegate> delegate = (id<QQApiInterfaceDelegate>)self.QQDelegate;
    if(userActivity){
        [QQApiInterface handleOpenUniversallink:userActivity.webpageURL delegate:delegate];
    }else{
        [QQApiInterface handleOpenURL:url delegate:delegate];
    }
#endif
}

- (void)handleWeiboOpenURL:(NSURL *)url universalLink:(NSUserActivity *)userActivity{
#ifdef CM_INCLUDE_WEIBO_SDK
    id<WeiboSDKDelegate> delegate = (id<WeiboSDKDelegate>)self.weiboDelegate;
    if(userActivity){
        [WeiboSDK handleOpenUniversalLink:userActivity delegate:delegate];
    }else{
        [WeiboSDK handleOpenURL:url delegate:delegate];
    }
#endif
}

- (void)onResp:(id)resp{
    // 微信支付
#ifdef CM_INCLUDE_WECHAT_SDK
    if([resp isKindOfClass:[PayResp class]]){
        [[CXPayService defaultService] handleWeChatPayCallback:(PayResp *)resp];
        return;
    }
#endif
    
    [[CXShareSDKManager sharedManager] onResp:resp];
}

@end
