//
//  CMHomeViewController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/4.
//

#import "CMHomeViewController.h"
#import "CMLocalHTMLController.h"
#import "CMVerifyRequest.h"
#import <CXAssetsPicker/CXAssetsPicker.h>
#import "CMSchemeHandler.h"

@interface CMHomeViewController ()<UINavigationControllerDelegate, CXAssetsPickerControllerDelegate>{
    
}

@end

@implementation CMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.navigationBar.navigationItem.rightBarButtonItem = [[CXBarButtonItem alloc] initWithTitle:@"设置" target:self action:@selector(didClickSettingButtonItem:)];
    
    [self addButtonWithTitle:@"打开WebView" action:@selector(didClickOpenWebViewButton:)];
    [self addButtonWithTitle:@"测试网络请求" action:@selector(didClickVerifyRequestButton:)];
    [self addButtonWithTitle:@"选择图片" action:@selector(didClickAssetsPickerButton:)];
    [self addButtonWithTitle:@"玩转定时器" action:@selector(didClickTimerButton:)];
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
        frame.origin.y = CGRectGetMaxY(self.navigationBar.frame) + 50.0;
    }else{
        frame.origin.y += frame.size.height + 20.0;
    }
    button.frame = frame;
    
    [self.view addSubview:button];
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

- (void)didClickAssetsPickerButton:(UIButton *)button{
    CXAssetsPickerController *picker = [[CXAssetsPickerController alloc] initWithAssetsType:CXAssetsAll];
    // picker.toolbarItemBackgroundColor = CXHexIColor(0x20AFFE);
    picker.enableMinimumCount = 1;
    picker.enableMaximumCount = 9;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)didClickTimerButton:(UIButton *)button{
    [CMSchemeHandler handleSchemeForModule:CMSchemeBusinessModuleCosmos
                                      page:CMSchemeBusinessTimerPage];
}

- (void)assetsPickerController:(CXAssetsPickerController *)picker
        didFinishPickingAssets:(NSArray<PHAsset *> *)assets
                    assetsType:(CXAssetsType)assetsType{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    [CXAssetsImageManager requestImageDataForAssets:assets completion:^(NSArray<CXAssetsElementImage *> *images) {
    //
    //    }];
}

- (void)didClickSettingButtonItem:(CXBarButtonItem *)buttonItem{
    [CMSchemeHandler handleSchemeForModule:CMSchemeBusinessModuleCosmos
                                      page:CMSchemeBusinessSettingPage];
}

@end
