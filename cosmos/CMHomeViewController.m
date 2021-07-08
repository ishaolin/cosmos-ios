//
//  CMHomeViewController.m
//  cosmos
//
//  Created by Michael Lynn on 2021/7/4.
//

#import "CMHomeViewController.h"
#import "CMLocalHTMLController.h"
#import "CMVerifyRequest.h"

@interface CMHomeViewController () {
    
}

@end

@implementation CMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [openButton setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1.0]];
    [openButton setTitle:@"打开WebView" forState:UIControlStateNormal];
    [openButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [openButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [openButton addTarget:self action:@selector(didClickOpenWebViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat openButton_W = 150.0;
    CGFloat openButton_H = 44.0;
    CGFloat openButton_X = (CGRectGetWidth(self.view.bounds) - openButton_W) * 0.5;
    CGFloat openButton_Y = CGRectGetMaxY(self.navigationBar.frame) + 50.0;
    openButton.frame = (CGRect){openButton_X, openButton_Y, openButton_W, openButton_H};
    
    [self.view addSubview:openButton];
    
    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyButton setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1.0]];
    [verifyButton setTitle:@"测试网络请求" forState:UIControlStateNormal];
    [verifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [verifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [verifyButton addTarget:self action:@selector(didClickVerifyRequestButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat verifyButton_W = openButton_W;
    CGFloat verifyButton_H = openButton_H;
    CGFloat verifyButton_X = openButton_X;
    CGFloat verifyButton_Y = CGRectGetMaxY(openButton.frame) + 20.0;
    verifyButton.frame = (CGRect){verifyButton_X, verifyButton_Y, verifyButton_W, verifyButton_H};
    
    [self.view addSubview:verifyButton];
}

- (void)didClickOpenWebViewButton:(UIButton *)button{
    CMLocalHTMLController *webViewController = [[CMLocalHTMLController alloc] init];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)didClickVerifyRequestButton:(UIButton *)button{
    CMVerifyRequest *request = [[CMVerifyRequest alloc] init];
    [request addParam:@"18612580920" forKey:@"mobile"];
    [request addParam:[CXUCryptor MD5:@"123456"] forKey:@"auth_code"];
    [CXHUD showHUD];
    [request loadRequestWithSuccess:^(NSURLSessionDataTask * _Nonnull dataTask, id  _Nullable data) {
        CMVerifyModel *model = (CMVerifyModel *)data;
        if(model.isValid){
            [CXHUD showMsg:@"接口请求成功"];
        }else{
            [CXHUD showMsg:model.msg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nullable error) {
        [CXHUD showMsg:error.HUDMsg];
    }];
}

@end
