//
//  CMOpenSDKDelegate.h
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import <Foundation/Foundation.h>

/* 微信 SDK */
#if __has_include(<WechatOpenSDK/WXApi.h>)
#import <WechatOpenSDK/WXApi.h>
#define CM_INCLUDE_WECHAT_SDK
#endif

/* 支付宝 SDK */
#if __has_include("APOpenAPI.h")
#import "APOpenAPI.h"
#define CM_INCLUDE_ALIPAY_SDK
#endif

/* QQ SDK */
#if __has_include(<TencentOpenAPI/TencentOpenApiUmbrellaHeader.h>)
#import <TencentOpenAPI/TencentOpenApiUmbrellaHeader.h>
#define CM_INCLUDE_QQ_SDK
#endif

/* 新浪微博 SDK */
#if __has_include("WeiboSDK.h")
#import "WeiboSDK.h"
#define CM_INCLUDE_WEIBO_SDK
#endif

@protocol CMOpenSDKDelegate <NSObject>

@optional

- (void)onReq:(id)req;
- (void)onResp:(id)resp;

@end

@interface CMOpenSDKDelegate : NSObject<CMOpenSDKDelegate>

@property (nonatomic, weak) id<CMOpenSDKDelegate> delegate;

- (instancetype)initWithDelegate:(id<CMOpenSDKDelegate>)delegate;

@end

#ifdef CM_INCLUDE_WECHAT_SDK
@interface CMOpenWeChatDelegate : CMOpenSDKDelegate<WXApiDelegate>

@end
#endif

#ifdef CM_INCLUDE_ALIPAY_SDK
@interface CMOpenAlipayDelegate : CMOpenSDKDelegate<APOpenAPIDelegate>

@end
#endif

#ifdef CM_INCLUDE_QQ_SDK
@interface CMOpenQQDelegate : CMOpenSDKDelegate<QQApiInterfaceDelegate>

@end
#endif

#ifdef CM_INCLUDE_WEIBO_SDK
@interface CMOpenWeiboDelegate : CMOpenSDKDelegate<WeiboSDKDelegate>

@end
#endif
