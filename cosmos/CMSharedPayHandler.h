//
//  CMSharedPayHandler.h
//  cosmos
//
//  Created by Michael Lynn on 2021/7/6.
//

#import "CMOpenSDKDelegate.h"

#define SCHEME_ALIPAY @"alipaycosmos"

@interface CMSharedPayHandler : NSObject

- (void)setup;

- (void)handleOpenURL:(NSURL *)url;

- (void)handleOpenUniversalLink:(NSUserActivity *)userActivity;

@end
