//
//  LHRatingView.m
//  TestStoryboard
//
//  Created by bosheng on 15/11/4.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "LHRatingView.h"

#define maxScore 5.0f
#define starNumber 5.0f

@interface LHRatingView()
{
    CGFloat eachWidth;
}

@property (nonatomic,assign)CGFloat widDistance;//星星之间的左右间隔
@property (nonatomic,assign)CGFloat heiDistance;//星星之间的上下间隔

@property (nonatomic,strong)UIView * grayStarView;//灰色星星
@property (nonatomic,strong)UIView * foreStarView;//表示分数星星

@property (nonatomic,assign)CGFloat lowestScore;//最低分数

@end

@implementation LHRatingView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ratingType = FLOAT_TYPE;
        self.widDistance = 0.0f;
        self.heiDistance = 0.0f;
        self.lowestScore = 0.0f;
        
        
        self.grayStarView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.grayStarView];
        self.foreStarView = [[UIView alloc]initWithFrame:self.bounds];
        self.foreStarView.clipsToBounds = YES;
        [self addSubview:self.foreStarView];
        
        eachWidth = (CGRectGetWidth(self.frame)-(starNumber-1)*self.widDistance)/starNumber;
        CGFloat height = CGRectGetHeight(self.frame)-2*self.heiDistance;
        for (int i = 0; i < starNumber; i++) {
            UIImage * grayImg = [UIImage imageNamed:@"star_empty"];
            UIImageView * grayImgView = [[UIImageView alloc]initWithFrame:CGRectMake((eachWidth+self.widDistance)*i, self.heiDistance, eachWidth, height)];
            grayImgView.image = grayImg;
            [self.grayStarView addSubview:grayImgView];
            
            UIImage * foreImg = [UIImage imageNamed:@"star_all"];
            UIImageView * foreImgView = [[UIImageView alloc]initWithFrame:CGRectMake((eachWidth+self.widDistance)*i, self.heiDistance, eachWidth, height)];
            foreImgView.image = foreImg;
            [self.foreStarView addSubview:foreImgView];
        }
        
        self.score = self.lowestScore;
    }
    
    return self;
}

#pragma mark - 设置当前分数
- (void)setScore:(CGFloat)score
{
    if (_enbleEdit) {
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent:)];
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureEvent:)];
        
        [self addGestureRecognizer:tapGesture];
        [self addGestureRecognizer:panGesture];
    }
    _score = score;
    
//    if (_ratingType == INTEGER_TYPE) {
//        _score = (int)score;
//    }
//    
    CGPoint p = CGPointMake((eachWidth+self.widDistance)*_score, self.heiDistance);
    [self changeStarForeViewWithPoint:p];
}

#pragma mark - 设置当前类型
- (void)setRatingType:(RatingType)ratingType
{
    _ratingType = ratingType;
    
//    [self setScore:_score];
}

#pragma mark - 点击
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap_
{
    CGPoint point = [tap_ locationInView:self];
    
//    if(_ratingType == INTEGER_TYPE){
//        NSInteger count = (NSInteger)(point.x/(eachWidth+self.widDistance))+1;
//        point.x = count*(eachWidth+self.widDistance);
//    }
//NSLog( @"Tip 点击 **********");
    [self changeStarForeViewWithPoint:point];
}


#pragma mark - 滑动
- (void)panGestureEvent:(UIPanGestureRecognizer *)pan_
{
    
    CGPoint point = [pan_ locationInView:self];

    if (point.x < 0) {
        return;
    }
//    if(_ratingType == INTEGER_TYPE){
//        NSInteger count = (NSInteger)(point.x/(eachWidth+self.widDistance))+1;
//        point.x = count*(eachWidth+self.widDistance);
//    }
//
    NSLog(@"PAN  滑动 ＊＊＊＊＊＊      ");
    [self changeStarForeViewWithPoint:point];
}

#pragma mark - 设置显示的星星
- (void)changeStarForeViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0) {
        return;
    }
    
    if (p.x < self.lowestScore)
    {
        p.x = self.lowestScore;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    float width = self.frame.size.width;
    float width2 = p.x;
    double temp = (double)width2/width;
//    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    double sc = (double)p.x/self.frame.size.width;
//    p.x = sc * self.frame.size.width;
    if (sc<0.1) {
        p.x = 0.0f*CGRectGetWidth(self.frame);
        sc=0.0;
    }else if (sc>0.1&&sc<0.2)
    {
        p.x = 0.1f*CGRectGetWidth(self.frame);
        sc=0.1;
    }else if (sc>=0.2&&sc<0.3)
    {
        p.x = 0.2f*CGRectGetWidth(self.frame);
        sc=0.2;
    }
    
    else if (sc>0.3&&sc<0.4)
    {
        p.x = 0.3f*CGRectGetWidth(self.frame);
        sc=0.3;
    }else if (sc>=0.4&&sc<0.5)
    {
        p.x = 0.4f*CGRectGetWidth(self.frame);
        sc=0.4;
    }else if (sc>=0.5&&sc<0.6)
    {
        p.x = 0.5f*CGRectGetWidth(self.frame);
        sc=0.5;
    }else if (sc>=0.6&&sc<0.7)
    {
        p.x = 0.6f*CGRectGetWidth(self.frame);
        sc=0.6;
    }else if (sc>=0.7&&sc<0.8)
    {
        p.x = 0.7f*CGRectGetWidth(self.frame);
        sc=0.7;
    }else if (sc>=0.8&&sc<0.9)
    {
        p.x = 0.8f*CGRectGetWidth(self.frame);
        sc=0.8;
    }else if (sc>=0.9&&sc<1.0)
    {
        p.x = 0.9f*CGRectGetWidth(self.frame);
        sc=0.9;
    }else if (sc>=1.0)
    {
        p.x = 1.0f*CGRectGetWidth(self.frame);
        sc=1.0;
    }
    
    
    CGRect fRect = self.foreStarView.frame;
    fRect.size.width = p.x;
    self.foreStarView.frame = fRect;
    
    _score = sc*maxScore;
    
//    if(_ratingType == INTEGER_TYPE){
//        NSLog(@"a");
//        _score = (int)_score;
//    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(ratingView:score:)])
    {
        [self.delegate ratingView:self score:self.score];
    }
}


@end
