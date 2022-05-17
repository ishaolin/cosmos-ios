//
//  CMAppDelegate.h
//  cosmos
//
//  Created by wshaolin on 2021/7/3.
//

#import <UIKit/UIKit.h>

@interface CMAppDelegate : UIResponder <UIApplicationDelegate>

@property (nullable, nonatomic, strong) UIWindow *window;

+ (void)createWindow:(nonnull id)delegate scene:(nullable id)scene;

@end
