//
//  CustomerButtomView.m
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CustomerButtomView.h"

@implementation CustomerButtomView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0.1, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [self addSubview:line];
    
    if (!_textImgView) {
        _textImgView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 7, 30, 30)];
        _textImgView.contentMode = UIViewContentModeScaleToFill;
        _textImgView.image = [UIImage imageNamed:@"icon-keyborad-button"];
        [self addSubview:_textImgView];
    }
    
    if (!_textDemandBtn) {
        _textDemandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _textDemandBtn.frame = CGRectMake(0,0, 90, 44);
        [_textDemandBtn addTarget:self action:@selector(textDemandClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_textDemandBtn];
    }
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(90, 12, 1, 20)];
    line2.backgroundColor = TextMainCOLOR;
    [self addSubview:line2];
    
    if (!_voiceImgView) {
        _voiceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 7, 30, 30)];
        _voiceImgView.contentMode = UIViewContentModeScaleToFill;
        _voiceImgView.image = [UIImage imageNamed:@"icon-voice_button"];
        [self addSubview:_voiceImgView];
    }
    
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(90,0, SCREEN_WIDTH-90, 44)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = LittleFont;
        _tipLabel.textColor = TextMainCOLOR;
        _tipLabel.text = @"长按发布需求";
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    if (!_voiceDemandBtn) {
        _voiceDemandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceDemandBtn.frame = CGRectMake(90,0, SCREEN_WIDTH-90, 44);
        // 开始
        [_voiceDemandBtn addTarget:self action:@selector(startRecordRequest) forControlEvents:UIControlEventTouchDown];
        // 取消
        [_voiceDemandBtn addTarget:self action:@selector(cancelRecordRequest) forControlEvents:UIControlEventTouchDragExit];
        // 结束
        [_voiceDemandBtn addTarget:self action:@selector(endRecordRequest) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_voiceDemandBtn];
    }
    
    return self;
    
}

- (void)textDemandClick
{
    [self.delegate publishTextDemand];
}

- (void)startRecordRequest
{
    [self.delegate startVoiceDemand];
}

- (void)cancelRecordRequest
{
    [self.delegate cancelVoiceDemand];
}

- (void)endRecordRequest
{
    [self.delegate endVoiceDemand];
}

@end
