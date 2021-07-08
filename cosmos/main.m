//
//  main.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/3.
//

#import <UIKit/UIKit.h>
#import "CMAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([CMAppDelegate class]);
    }
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
