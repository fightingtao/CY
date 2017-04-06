//
//  ImgBrowser.m
//  ImageBrowser
//
//  Created by 1217 on 15/11/10.
//  Copyright © 2015年 路. All rights reserved.
//



#import "ImgBrowser.h"
#import "UIImageView+WebCache.h"

@interface ImgBrowser ()

{
    UIView *_black_view;
    UIScrollView *_scroll_view;
    UILabel *_title;
}
@end

@implementation ImgBrowser



- (id)init
{
    self = [super init];
    if (self) {
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        self.frame = window.bounds;
        
        _black_view = [[UIView alloc]initWithFrame:self.bounds];
        _black_view.backgroundColor = [UIColor blackColor];
        _black_view.alpha = BLACKVIEWALPHA;
        [self addSubview:_black_view];
        
        _scroll_view = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scroll_view.pagingEnabled = YES;
        _scroll_view.delegate = self;
        _scroll_view.showsHorizontalScrollIndicator = NO;
        _scroll_view.showsVerticalScrollIndicator = NO;
        [self addSubview:_scroll_view];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, 15)];
        _title.font = [UIFont systemFontOfSize:TITLELABELFONT];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
        [self addSubview:_title];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setCurrentIndex:(int)currentIndex
{
    _title.text = [NSString stringWithFormat:@"%d/%d",currentIndex+1,(int)self.imgaeArray.count];
    _currentIndex = currentIndex;
    _scroll_view.contentOffset = CGPointMake(currentIndex*_scroll_view.frame.size.width, 0);
}
- (void)setImgaeArray:(NSArray *)imgaeArray AndType:(int)type
{
    _imgaeArray = imgaeArray;
    _title.text = [NSString stringWithFormat:@"%d/%d",self.currentIndex+1,(int)imgaeArray.count];
    for (int i =0; i<imgaeArray.count; i++) {
        
        UIScrollView *inScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(i*_scroll_view.frame.size.width, 0, _scroll_view.frame.size.width, _scroll_view.frame.size.height)];
//        inScroll.showsHorizontalScrollIndicator = NO;
//        inScroll.showsVerticalScrollIndicator = NO;
        inScroll.bounces = NO;
        inScroll.delegate = self;
        inScroll.tag = i*100+1*100;
        inScroll.minimumZoomScale = 1.0;
        inScroll.maximumZoomScale = 2.0;
        [_scroll_view addSubview:inScroll];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scroll_view.frame.size.width, _scroll_view.frame.size.height)];
        if (type == 0) {
            [imgView setImageWithURL:[NSURL URLWithString:imgaeArray[i]] placeholderImage:Img(SHOWPLACEHOLDERIMG)];
        }else
        {
            imgView.image = imgaeArray[i];
        }

        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        imgView.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
        tap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [imgView addGestureRecognizer:doubleTap];
        
        [tap requireGestureRecognizerToFail:doubleTap];
        
        [inScroll addSubview:imgView];
    }
    _scroll_view.contentSize = CGSizeMake(imgaeArray.count*_scroll_view.frame.size.width, _scroll_view.frame.size.height);
}

- (void)show
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [self exChangeScale:self dur:ANIMATIONDURATION];
}


#pragma mark --ButtonClick -
- (void)imgTap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:HIDDENANIMATIONDURATION animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    UIImageView *imgview = (UIImageView *)[tap view];
    [self.delegate browsefinish:imgview.image];
}
- (void)imgDoubleTap:(UITapGestureRecognizer *)tap
{
    UIScrollView *inScroll = (UIScrollView *)tap.view.superview;
    if (inScroll.zoomScale != 1) {
        [inScroll setZoomScale:1.0 animated:YES];
    } else {
        [inScroll setZoomScale:2.0 animated:YES];
    }
}
- (void) scaleImage:(UIPinchGestureRecognizer*)gesture
{
    UIImageView *imgView = (UIImageView *)gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        imgView.transform = CGAffineTransformScale(imgView.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
        UIScrollView *scroll = (UIScrollView *)[gesture.view superview];
        scroll.contentSize = CGSizeMake(imgView.image.size.width, imgView.image.size.height);
    }
}
#pragma mark --ScrollViewDelegate -
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scroll_view) {
        int x = scrollView.contentOffset.x/scrollView.frame.size.width;
        _title.text = [NSString stringWithFormat:@"%d/%d",_currentIndex+1,(int)self.imgaeArray.count];
        if (x != _currentIndex) {
            for (UIScrollView *inScroll in _scroll_view.subviews) {
                [inScroll setZoomScale:1.0 animated:YES];
                _currentIndex = x;
            }
        }
        
    }
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    self.currentIndex = _scroll_view.contentOffset.x/_scroll_view.frame.size.width;
    UIScrollView *inScroll = (UIScrollView *)[_scroll_view viewWithTag:(_currentIndex+1)*100];
    UIImageView *imgView = [inScroll.subviews firstObject];
    return imgView;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != _scroll_view) {
        [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    }
}
#pragma mark --弹出效果 -
- (void)exChangeScale:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [changeOutView.layer addAnimation:animation forKey:nil];
}





@end
