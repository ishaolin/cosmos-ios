//
//  CMImagePlayerViewController.m
//  cosmos
//
//  Created by Michael Lynn on 2023/3/18.
//

#import "CMImagePlayerViewController.h"

@interface CMImagePlayerViewController ()<CXImagePlayerDataSource, CXImagePlayerDelegate> {
    CXImagePlayer *_imagePlayer;
    NSArray<NSString *> *_imageList;
}

@end

@implementation CMImagePlayerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        _imageList = @[
            @"https://img0.baidu.com/it/u=887570163,3972811143&fm=253&fmt=auto&app=138&f=JPEG",
            @"https://img0.baidu.com/it/u=3792456632,1112940394&fm=253&fmt=auto&app=138&f=JPEG",
            @"https://img1.baidu.com/it/u=1088787692,1934871725&fm=253&fmt=auto&app=138&f=JPEG",
            @"https://img2.baidu.com/it/u=355673106,1614830790&fm=253&fmt=auto&app=138&f=JPEG",
            @"https://img2.baidu.com/it/u=867579726,2670217964&fm=253&fmt=auto&app=120&f=JPEG",
            @"https://lmg.jj20.com/up/allimg/tp08/45041324391718-lp.jpg"
        ];
        
        _imagePlayer = [[CXImagePlayer alloc] initWithPageControlPosition:CXImagePlayerPageControlPositionCenter];
        _imagePlayer.timeInterval = 3.0;
        _imagePlayer.dataSource = self;
        _imagePlayer.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义图片轮播器";
    
    CGFloat imagePlayer_X = 12.0;
    CGFloat imagePlayer_Y = CGRectGetMaxY(self.navigationBar.frame) + 12.0;
    CGFloat imagePlayer_W = CGRectGetWidth(self.view.bounds) - imagePlayer_X * 2;
    CGFloat imagePlayer_H = 160.0;
    _imagePlayer.frame = (CGRect){imagePlayer_X, imagePlayer_Y, imagePlayer_W, imagePlayer_H};
    [_imagePlayer cx_roundedCornerRadii:6.0];
    [self.view addSubview:_imagePlayer];
}

- (NSUInteger)numberOfImagesInImagePlayer:(CXImagePlayer *)imagePlayer{
    return _imageList.count;
}

- (void)imagePlayer:(CXImagePlayer *)imagePlayer loadImageView:(UIImageView *)imageView atIndex:(NSUInteger)index{
    [imageView cx_setImageWithURL:_imageList[index]];
}

- (void)imagePlayer:(CXImagePlayer *)imagePlayer loadPlaceholderImageView:(UIImageView *)imageView{
    
}

- (void)imagePlayer:(CXImagePlayer *)imagePlayer willDisplayImageAtIndex:(NSUInteger)index{
    
}

- (void)imagePlayer:(CXImagePlayer *)imagePlayer didSelectImageAtIndex:(NSUInteger)index{
    
}

+ (void)registerSchemeSupporter{
    [[CXSchemeRegistrar sharedRegistrar] registerClass:self
                                          businessPage:CMSchemeBusinessImagePlayerPage
                                                module:CMSchemeBusinessModuleCosmos];
}

@end
