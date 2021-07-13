//
//  CMTimerViewController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/13.
//

#import "CMTimerViewController.h"
#import "CMSchemeHandler.h"

@interface CMTimerViewController () {
    CXTimer *_timer;
}

@end

@implementation CMTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"玩转定时器";
    
    _timer = [CXTimer taskTimerWithConfig:^(CXTimerConfig *config) {
        config.target = self;
        config.action = @selector(timerAction:);
        config.interval = 3.0;
        config.repeats = YES;
    }];
}

- (void)timerAction:(CXTimer *)timer{
    LOG_INFO(@"timerAction:");
}

- (void)dealloc{
    if(_timer.isValid){
        [_timer invalidate];
    }
    
    _timer = nil;
}

+ (void)registerSchemeSupporter{
    [[CXSchemeRegistrar sharedRegistrar] registerClass:self
                                          businessPage:CMSchemeBusinessTimerPage
                                                module:CMSchemeBusinessModuleCosmos];
}

@end
