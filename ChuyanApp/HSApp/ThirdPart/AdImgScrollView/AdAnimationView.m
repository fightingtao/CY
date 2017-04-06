//
//  AdAnimationView.m
//  MaTang
//
//  Created by iosdev on 15/6/10.
//  Copyright (c) 2015年 cudatec. All rights reserved.
//

#import "AdAnimationView.h"

#import "UIImageView+WebCache.h"


@implementation AdAniMationModel
@end

@interface AdAnimationView ()

@property (nonatomic, strong) UIImageView   *aImageView;
@property (nonatomic, strong) UIPageControl *aPageControl;
@end

@implementation AdAnimationView
@synthesize delegate;
@synthesize modelArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_aImageView) {
            _aImageView = [[UIImageView alloc] init];
            _aImageView.frame = frame;
            _aImageView.contentMode = UIViewContentModeScaleAspectFill;
            _aImageView.clipsToBounds = TRUE;
            [self addSubview:_aImageView];
        }
        
        if (!_aPageControl) {
            _aPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
            _aPageControl.userInteractionEnabled = NO;
            [_aPageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
            [self addSubview:_aPageControl];
        }
        
        //点击图片事件
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapTransGestureRecognizer:)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGestureRecognize];
        
        
        self.userInteractionEnabled = YES;
        //添加手势
        UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftSwipeGesture];
        
        UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightSwipeGesture];

    }
    return self;
}

- (void)refreshShowWith:(NSArray *)showArray//可能需要变更
{
    if (!showArray) {
        return;
    }
    
    self.modelArray = showArray;
    AdAniMationModel *model = [showArray objectAtIndex:0];
    [_aImageView setImageWithURL:[NSURL URLWithString:model.pic_path] placeholderImage:AD_PLACEHOLDERIMAGE_LARGE];
    _aPageControl.currentPage = 0;
    _aPageControl.numberOfPages = [showArray count];
    
    [self performSelector:@selector(switchTransitonImageItems) withObject:nil afterDelay:CHANGE_IMAGE_TIMEINTERVAL];

}

#pragma mark 点击图片时间
- (void)singleTapTransGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    AdAniMationModel *itemModel = [self.modelArray objectAtIndex:_currentIndex];
    if ([self.delegate respondsToSelector:@selector(adHasSelect:)]) {
        [self.delegate adHasSelect:itemModel];
    }
}

#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture
{
    if (self.modelArray.count ==1) {
        
    }else
    {
        [self transitionAnimation:YES];

    }
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture
{
    if (self.modelArray.count ==1) {
        
    }else
    {
       [self transitionAnimation:NO];
        
    }
    
}

- (void)switchTransitonImageItems
{
    
    if (self.modelArray.count ==1) {
        
    }else
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchTransitonImageItems) object:nil];
        
        //这里可以加上左右滑动类型
        [self transitionAnimation:YES];
        
        [self performSelector:@selector(switchTransitonImageItems) withObject:nil afterDelay:CHANGE_IMAGE_TIMEINTERVAL];
        
    }
}

-(void)transitionAnimation:(BOOL)isNext{
    //1.创建转场动画对象
    if (!transition) {
        transition = [[CATransition alloc] init];
    }
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = kCATransitionPush;
    
    //设置子类型
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    }else{
        transition.subtype = kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration=0.5f;

    //3.设置转场后的新视图添加转场动画
    AdAniMationModel *model = [self getImageModel:isNext];
    //    [_imageView sd_setImageWithURL:imageModel.imgUrl placeholderImage:PLACE_HOLDER_IMAGE];
    [_aImageView setImageWithURL:[NSURL URLWithString:model.pic_path] placeholderImage:AD_PLACEHOLDERIMAGE_LARGE];
    [_aImageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

-(AdAniMationModel *)getImageModel:(BOOL)isNext
{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%[self.modelArray count];
    }else{
        _currentIndex=(_currentIndex-1+[self.modelArray count])%[self.modelArray count];
    }
    _aPageControl.currentPage = _currentIndex;
    
    
    AdAniMationModel *imageModel = [self.modelArray objectAtIndex:_currentIndex];
    return imageModel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
