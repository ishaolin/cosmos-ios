//
//  CMScanViewController.m
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import "CMScanViewController.h"
#import "CMScanAnimationView.h"

static inline CGRect CMGetScanRect(CGRect rect){
    CGFloat scan_W = MIN(rect.size.width - 55.0, 265.0);
    CGFloat scan_H = scan_W;
    CGFloat scan_X = (rect.size.width - scan_W) * 0.5;
    CGFloat scan_Y = CGRectGetMinY(rect) + 100.0;
    if(CX_SCREEN_INCH_IS_4_0){
        scan_Y -= 30.0;
    }
    
    return CGRectMake(scan_X, scan_Y, scan_W, scan_H);
}

static inline CGPoint CMRectGetCenterPoint(CGRect rect){
    return (CGPoint){CGRectGetMidX(rect), CGRectGetMidY(rect)};
}

@interface CMScanViewController ()<CXScanCodeViewDelegate>{
    UILabel *_titleLabel;
    UILabel *_descLabel;
    
    CXScanCodeView *_scanCodeView;
    CMScanAnimationView *_animationView;
    CAShapeLayer *_scanFillLayer;
    
    BOOL _shouldUseQRCode;
}

@end

@implementation CMScanViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startCameraRunning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _shouldUseQRCode = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _shouldUseQRCode = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    self.navigationBar.navigationItem.backBarButtonItem.hidden = NO;
    self.navigationBar.hiddenBottomHorizontalLine = YES;
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupScanCodeView];
    [self setupScanFillLayer];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = CX_PingFangSC_MediumFont(21.0);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = CXHexIColor(0xFFFFFF);
    _titleLabel.text = @"扫描二维码";
    _titleLabel.hidden = YES;
    [self.view addSubview:_titleLabel];
    CGFloat titleLabel_X = CX_MARGIN(30.0);
    CGFloat titleLabel_W = self.view.bounds.size.width - titleLabel_X * 2;
    CGFloat titleLabel_H = 30.0;
    CGFloat titleLabel_Y = CGRectGetMaxY(self.navigationBar.frame);
    if(CX_SCREEN_INCH_IS_4_0){
        titleLabel_Y += 20.0;
    }else{
        titleLabel_Y += 40.0;
    }
    _titleLabel.frame = (CGRect){titleLabel_X, titleLabel_Y, titleLabel_W, titleLabel_H};
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.font = CX_PingFangSC_RegularFont(13.0);
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.textColor = CXHexIColor(0xFFFFFF);
    _descLabel.text = @"将二维码放入框内，即可自动扫描";
    [self.view addSubview:_descLabel];
    CGFloat descLabel_X = titleLabel_X;
    CGFloat descLabel_W = titleLabel_W;
    CGFloat descLabel_H = 18.0;
    CGFloat descLabel_Y = CGRectGetMaxY(_animationView.frame) + 20.0;
    _descLabel.frame = (CGRect){descLabel_X, descLabel_Y, descLabel_W, descLabel_H};
}

- (void)setupScanCodeView{
    _scanCodeView = [[CXScanCodeView alloc] init];
    _scanCodeView.delegate = self;
    
    _scanCodeView.frame = self.view.bounds;
    [self.view addSubview:_scanCodeView];
    
    CGRect rect = self.view.bounds;
    rect.origin.y = CGRectGetMaxY(self.navigationBar.frame);
    _animationView = [[CMScanAnimationView alloc] init];
    _animationView.frame = CMGetScanRect(rect);
    _scanCodeView.rectOfInterest = _animationView.frame;
    [_scanCodeView addSubview:_animationView];
    [_scanCodeView setUpdateIndicatorViewCenter:_animationView.center];
}

- (void)setupScanFillLayer{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _animationView.frame);
    CGPathAddRect(path, NULL, _scanCodeView.bounds);
    
    _scanFillLayer = [CAShapeLayer layer];
    _scanFillLayer.fillRule = kCAFillRuleEvenOdd;
    _scanFillLayer.fillColor = [UIColor blackColor].CGColor;
    _scanFillLayer.opacity = 0.6;
    _scanFillLayer.path = path;
    
    CGPathRelease(path);
    
    [_scanFillLayer setNeedsDisplay];
}

- (void)startCameraRunning{
    _scanCodeView.outputEnabled = YES;
    [_scanCodeView startRunning];
    [_animationView startAnimating];
}

- (void)stopCameraRunning{
    _scanCodeView.outputEnabled = NO;
    [_scanCodeView stopRunning];
    [_animationView stopAnimating];
}

- (void)cameraDisplayViewDidStartCamera:(CXCameraDisplayView *)cameraView{
    [_scanFillLayer removeFromSuperlayer];
    [_scanCodeView.layer addSublayer:_scanFillLayer];
    [_scanCodeView bringSubviewToFront:_animationView];
    [_animationView startAnimating];
}

- (void)scanCodeView:(CXScanCodeView *)scanCodeView didFinishedWithQRCodeText:(NSString *)codeText{
    if(!_shouldUseQRCode){
        return;
    }
    
    [self stopCameraRunning];
    
    if([self.delegate respondsToSelector:@selector(scanViewController:didFinishedWithQRCodeText:error:)]){
        NSString *error = @"不支持的二维码";
        if([self.delegate scanViewController:self didFinishedWithQRCodeText:codeText error:&error]){
            return;
        }
        
        [self showQRCodeError:error];
    }
}

- (void)showQRCodeError:(NSString *)error{
    if(CXStringIsEmpty(error)){
        return;
    }
    
    _scanCodeView.outputEnabled = NO;
    [_animationView stopAnimating];
    CXHUD *HUD = [CXHUD showMsg:error completion:^{
        self->_scanCodeView.outputEnabled = YES;
        [self->_animationView startAnimating];
    }];
    
    CGPoint point = CMRectGetCenterPoint(_animationView.bounds);
    point = [self.view convertPoint:point fromView:_animationView];
    [HUD setHUDCenterPoint:point];
}

- (void)didBecomeActiveNotification:(NSNotification *)notification{
    [super didBecomeActiveNotification:notification];
    
    if(self.isDisplaying){
        [_animationView startAnimating];
    }
}

- (void)didClickBackBarButtonItem:(CXBarButtonItem *)backBarButtonItem{
    [super didClickBackBarButtonItem:backBarButtonItem];
    
    if([self.delegate respondsToSelector:@selector(scanViewControllerDidCancel:)]){
        [self.delegate scanViewControllerDidCancel:self];
    }
}

@end
