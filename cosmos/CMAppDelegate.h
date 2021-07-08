//
//  CMAppDelegate.h
//  cosmos
//
//  Created by Michael Lynn on 2021/7/3.
//

#import <UIKit/UIKit.h>

@interface CMAppDelegate : UIResponder <UIApplicationDelegate>

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_13_0
@property (nonatomic, strong) UIWindow *window;
#endif

+ (void)createWindow:(nonnull id)delegate scene:(nullable id)scene;

@end
