//
//  CMAppDelegate.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/3.
//

#import "CMAppDelegate.h"
#import <CXUIKit/CXUIKit.h>
#import "CMSharedPayHandler.h"
#import "CMHomeViewController.h"
#import "CMSchemeHandler.h"

@interface CMAppDelegate () {
    CMSharedPayHandler *_sharedPayHandler;
}

@end

@implementation CMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setControllerNavigationStyleConfig];
    [self createWindowIfRequired];
    [[CXSchemeRegistrar sharedRegistrar] registerModule];
    
    _sharedPayHandler = [[CMSharedPayHandler alloc] init];
    [_sharedPayHandler setup];
    return YES;
}

- (void)setControllerNavigationStyleConfig {
    CXNavigationConfig *defaultStyle = [[CXNavigationConfig alloc] init];
    defaultStyle.titleFont = CX_PingFangSC_MediumFont(17.0);
    defaultStyle.titleColor = CXHexIColor(0x353C43);
    defaultStyle.backgroundColor = [UIColor whiteColor];
    defaultStyle.subtitleFont = CX_PingFangSC_RegularFont(12.0);
    defaultStyle.itemTitleFont = CX_PingFangSC_RegularFont(14.0);
    [defaultStyle setItemTitleColor:CXHexIColor(0x353C43) forState:UIControlStateNormal];
    [defaultStyle setItemTitleColor:CXHexIColor(0x9099A1) forState:UIControlStateHighlighted];
    [defaultStyle setItemTitleColor:CXHexIColor(0xCDD4DA) forState:UIControlStateDisabled];
    
    CXNavigationConfig *lightStyle = [[CXNavigationConfig alloc] init];
    lightStyle.titleFont = CX_PingFangSC_MediumFont(17.0);
    lightStyle.titleColor = [UIColor whiteColor];
    lightStyle.backgroundColor = [UIColor clearColor];
    lightStyle.subtitleFont = CX_PingFangSC_RegularFont(12.0);
    lightStyle.itemTitleFont = CX_PingFangSC_RegularFont(14.0);
    [lightStyle setItemTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lightStyle setItemTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [lightStyle setItemTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    
    CXSetNavigationBarDefaultStyle(UIStatusBarStyleDefault);
    CXSetNavigationConfigForStyle(defaultStyle, UIStatusBarStyleDefault);
    CXSetNavigationConfigForStyle(lightStyle, UIStatusBarStyleLightContent);
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)session options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:session.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    // no equiv. notification. return NO if the application can't open for some reason
    [_sharedPayHandler handleOpenURL:url];
    [CMSchemeHandler handleOpenURL:url];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    // Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
    // You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
    // invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
    // restoreUserActivityState on all objects.
    [_sharedPayHandler handleOpenUniversalLink:userActivity];
    
    return YES;
}

- (void)createWindowIfRequired {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_13_0
    [self.class createWindow:self scene:nil];
#endif
}

+ (void)createWindow:(id)delegate scene:(id)scene{
    CMHomeViewController *viewController =  [[CMHomeViewController alloc] init];
    CXNavigationController *navigationController = [[CXNavigationController alloc] initWithRootViewController:viewController];
    
    [[UIApplication sharedApplication] cx_createWindow:delegate
                                                 scene:scene
                                    rootViewController:navigationController];
}

@end
