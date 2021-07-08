//
//  CMSchemeHandler.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/5.
//

#import "CMSchemeHandler.h"

@implementation CMSchemeHandler

+ (UINavigationController *)navigationController {
    return (UINavigationController *)[[UIApplication sharedApplication] cx_activeWindow].rootViewController;
}

@end
