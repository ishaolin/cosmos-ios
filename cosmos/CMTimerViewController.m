//
//  CMTimerViewController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/13.
//

#import "CMTimerViewController.h"
#import "CMSchemeHandler.h"
#import "CMTimeFormatter.h"

@interface CMTimerViewController () {
    CXTimer *_timer;
    UILabel *_label;
    CMTimeFormatter *_formatter;
    long _seconds;
}

@end

@implementation CMTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"玩转定时器";
    
    _formatter = [CMTimeFormatter hoursFormatter];
    [_formatter setFormatSeconds:_seconds];
    
    _label = [[UILabel alloc] init];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = CX_PingFangSC_LightFont(42.0);
    _label.text = [_formatter toString];
    
    CGFloat label_W = 260.0;
    CGFloat label_H = 40.0;
    CGFloat label_X = (CGRectGetWidth(self.view.bounds) - label_W) * 0.5;
    CGFloat label_Y = CGRectGetMaxY(self.navigationBar.frame) + 50.0;
    _label.frame = (CGRect){label_X, label_Y, label_W, label_H};
    [self.view addSubview:_label];
    
    [self addButtonWithTitle:@"开始计时" action:@selector(didClickStartTimerButton:)];
    [self addButtonWithTitle:@"暂停计时" action:@selector(didClickPauseTimerButton:)];
}

- (void)addButtonWithTitle:(NSString *)title action:(SEL)action{
    __block CGRect frame = CGRectZero;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIButton class]]){
            if(obj.frame.origin.y > frame.origin.y){
                frame = obj.frame;
            }
        }
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1.0]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    if(CGRectEqualToRect(frame, CGRectZero)){
        frame.size.width = 150.0;
        frame.size.height = 44.0;
        frame.origin.x = (CGRectGetWidth(self.view.bounds) - frame.size.width) * 0.5;
        frame.origin.y = CGRectGetMaxY(_label.frame) + 20.0;
    }else{
        frame.origin.y += frame.size.height + 20.0;
    }
    button.frame = frame;
    
    [self.view addSubview:button];
}

- (void)didClickStartTimerButton:(UIButton *)button{
    if(_timer){
        [_timer resume];
    }else{
        _timer = [CXTimer taskTimerWithConfig:^(CXTimerConfig *config) {
            config.target = self;
            config.action = @selector(timerAction:);
            config.interval = 1.0;
            config.repeats = YES;
        }];
        
        [_timer fire];
    }
}

- (void)didClickPauseTimerButton:(UIButton *)button{
    [_timer pause];
}

- (void)timerAction:(CXTimer *)timer{
    [_formatter setFormatSeconds:_seconds++];
    _label.text = [_formatter toString];
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
