//
//  CMSchemeModuleRegistrar.m
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import "CMSchemeModuleRegistrar.h"
#import "CMWebViewController.h"
#import "CMSettingViewController.h"
#import "CMTimerViewController.h"

@implementation CMSchemeModuleRegistrar

+ (void)load{
    [[CXSchemeRegistrar sharedRegistrar] addModuleRegistrar:self];
}

+ (void)registerSchemeSupporterClass{
    [CMWebViewController registerSchemeSupporter];
    [CMSettingViewController registerSchemeSupporter];
    [CMTimerViewController registerSchemeSupporter];
}

@end
