//
//  COrderDetailOrderTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderDetailOrderTableViewCell.h"

@implementation COrderDetailOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_orderTypeLabel) {
            _orderTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0.5, 20, 20)];
            _orderTypeLabel.backgroundColor = [UIColor clearColor];
            _orderTypeLabel.font = [UIFont systemFontOfSize:12];
            _orderTypeLabel.textColor = DaiSongColor;
            _orderTypeLabel.text = @"送";
            _orderTypeLabel.layer.borderColor = DaiSongColor.CGColor;
            _orderTypeLabel.layer.borderWidth = 0.5;
            _orderTypeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderTypeLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_orderTypeLabel];
        }
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 20, 50, 50)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.layer.cornerRadius = 25;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, 120, 30)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_nameLabel];
        }
        
        if (!_orderContentLabel) {
            _orderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,15, SCREEN_WIDTH-140, 20)];
            _orderContentLabel.backgroundColor = [UIColor clearColor];
            _orderContentLabel.font = LittleFont;
            _orderContentLabel.textColor = TextMainCOLOR;
            _orderContentLabel.text = @"呼：";
            _orderContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _orderContentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_orderContentLabel];
        }
        
        if (!_orderVoiceBtn) {
            _orderVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _orderVoiceBtn.frame = CGRectMake(150, 15, 20, 20);
            [_orderVoiceBtn addTarget:self action:@selector(voicePlayClick) forControlEvents:UIControlEventTouchUpInside];
            [_orderVoiceBtn setImage:[UIImage imageNamed:@"btn_voice"] forState:UIControlStateNormal];
            [self addSubview:_orderVoiceBtn];
        }
        if (!_getAddressLabel) {
            _getAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,45, SCREEN_WIDTH-140, 20)];
            _getAddressLabel.backgroundColor = [UIColor clearColor];
            _getAddressLabel.font = LittleFont;
            _getAddressLabel.textColor = TextMainCOLOR;
            _getAddressLabel.text = @"取：长江贸易大楼";
            _getAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _getAddressLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_getAddressLabel];
        }
        
        if (!_sendAddressLabel) {
            _sendAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,75, SCREEN_WIDTH-140, 20)];
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.font = LittleFont;
            _sendAddressLabel.textColor = TextMainCOLOR;
            _sendAddressLabel.text = @"送：长江贸易大楼";
            _sendAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_sendAddressLabel];
        }
        
        //end
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (CGFloat)cellHeightWithModel:(NSString*)mode
{
    return OrderCellHeigth;
}


- (void)setOrderContentWithModel:(NSString*)model
{
    
}

//语音播放
- (void)voicePlayClick
{
    
}





@end
