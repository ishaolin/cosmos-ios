//
//  CMWebViewController.h
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import <CXUIKit/CXUIKit.h>

@interface CMWebViewController : CXWebViewController<CXSchemeSupporter>

- (NSDictionary<NSString *, id> *)commonParams;

@end
