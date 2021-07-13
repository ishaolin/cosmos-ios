//
//  CMLocalHTMLController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/5.
//

#import "CMLocalHTMLController.h"

@interface CMLocalHTMLController () {
    
}

@end

@implementation CMLocalHTMLController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    [self loadRequestWithURL:URL];
}

@end
