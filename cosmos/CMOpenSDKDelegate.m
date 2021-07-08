//
//  CMOpenSDKDelegate.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import "CMOpenSDKDelegate.h"

@implementation CMOpenSDKDelegate

- (instancetype)initWithDelegate:(id<CMOpenSDKDelegate>)delegate{
    if(self = [super init]){
        self.delegate = delegate;
    }
    
    return self;
}

- (void)onReq:(id)req{
    if([self.delegate respondsToSelector:@selector(onReq:)]){
        [self.delegate onReq:req];
    }
}

- (void)onResp:(id)resp{
    if([self.delegate respondsToSelector:@selector(onResp:)]){
        [self.delegate onResp:resp];
    }
}

@end

#ifdef CM_INCLUDE_WECHAT_SDK
@implementation CMOpenWeChatDelegate

@end
#endif

#ifdef CM_INCLUDE_ALIPAY_SDK
@implementation CMOpenAlipayDelegate

@end
#endif

#ifdef CM_INCLUDE_QQ_SDK
@implementation CMOpenQQDelegate

- (void)isOnlineResponse:(NSDictionary *)response{
    
}

@end
#endif

#ifdef CM_INCLUDE_QQ_SDK
@implementation CMOpenWeiboDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    [self onReq:request];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    [self onResp:response];
}

@end
#endif
