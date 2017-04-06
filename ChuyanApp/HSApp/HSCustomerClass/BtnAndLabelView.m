//
//  BtnAndLabelView.m
//  Parking
//
//  Created by iosdev on 15/5/31.
//  Copyright (c) 2015年 cudatec. All rights reserved.
//

#import "BtnAndLabelView.h"

@interface BtnAndLabelView ()

@property (nonatomic, strong) UITapGestureRecognizer *clickRecognizer;
@end

@implementation BtnAndLabelView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    //height > width
    if (!_btnImage) {
        _btnImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-45)/2, 12, 45, 45)];
        _btnImage.layer.masksToBounds = YES;
        _btnImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_btnImage];
    }
    
    if (!_btnTitleLabel) {
        _btnTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _btnImage.frame.size.height+5, self.frame.size.width, self.frame.size.height-_btnImage.frame.size.height)];
        [_btnTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [_btnTitleLabel setFont:[UIFont systemFontOfSize:14.0]];
        _btnTitleLabel.textColor = TextColor;
        [self addSubview:_btnTitleLabel];
    }
    
    if (!_clickRecognizer) {
        _clickRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewClicked)];
        [self addGestureRecognizer:_clickRecognizer];
    }
    return self;
}

- (void)setImgWith:(UIImage *)img WithTitle:(NSString *)title
{
    [_btnImage setImage:img];
    [_btnTitleLabel setText:title];
}

- (void)selfViewClicked
{
    if ([self.delegate respondsToSelector:@selector(btnAndLabelClicked:)]) {
        [self.delegate btnAndLabelClicked:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
