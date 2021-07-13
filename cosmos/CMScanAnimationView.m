//
//  CMScanAnimationView.m
//  cosmos
//
//  Created by wshaolin on 2021/7/6.
//

#import "CMScanAnimationView.h"
#import <CXUIKit/CXUIKit.h>

@interface CMScanAnimationView () {
    UIImageView *_imageView;
    UIImageView *_lineView;
}

@end

@implementation CMScanAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage cx_imageNamed:@"cm_code_scan_box"];
        
        _lineView = [[UIImageView alloc] init];
        _lineView.image = [UIImage cx_imageNamed:@"cm_code_scan_line"];
        _lineView.hidden = YES;
        
        [_imageView addSubview:_lineView];
        [self addSubview:_imageView];
    }
    
    return self;
}

- (void)startAnimating{
    _lineView.hidden = NO;
    
    [self moveLineAnimating];
}

- (void)stopAnimating{
    _lineView.hidden = YES;
    
    [_lineView.layer removeAnimationForKey:@"move_animation_key"];
}

- (void)moveLineAnimating{
    NSString *animationKey = @"move_animation_key";
    CABasicAnimation *animation = [_lineView.layer animationForKey:animationKey];
    if(animation){
        return;
    }
    
    animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(CGRectGetMinY(_lineView.frame));
    animation.toValue = @(CGRectGetHeight(self.bounds) - CGRectGetMinY(_lineView.frame));
    animation.duration = 2.0;
    animation.repeatCount = MAXFLOAT;
    [_lineView.layer addAnimation:animation forKey:animationKey];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    CGFloat lineView_W = MIN(CGRectGetWidth(_imageView.frame) - 5.0, _lineView.image.size.width);
    CGFloat lineView_H = _lineView.image.size.height;
    CGFloat lineView_X = (CGRectGetWidth(_imageView.frame) - lineView_W) * 0.5;
    CGFloat lineView_Y = 1.0;
    _lineView.frame = (CGRect){lineView_X, lineView_Y, lineView_W, lineView_H};
}

@end
