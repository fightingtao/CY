//
//  COrderDetailBrokerTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderDetailBrokerTableViewCell.h"

@implementation COrderDetailBrokerTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.layer.cornerRadius = 20;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,20, 120, 20)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameLabel];
        }
        
        if (!_statusLabel) {
            _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120,20, 120, 20)];
            _statusLabel.backgroundColor = [UIColor clearColor];
            _statusLabel.font = LittleFont;
            _statusLabel.textColor = TextMainCOLOR;
            _statusLabel.text = @"当前状态:已购买";
            _statusLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _statusLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_statusLabel];
        }
        
        if (!_phoneImgView) {
            _phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,20,15,20)];
            _phoneImgView.image = [UIImage imageNamed:@"btn_phone"];
            _phoneImgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone)];
            [_phoneImgView addGestureRecognizer:singleTap];
            [self addSubview:_phoneImgView];
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

- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model AndType:(int)type
{
    _tempModel = model;
    if (!model) {
        
    }else
    {
        if (type == 0) {
            [_headImgView setImageURLStr:model.uHeader placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
            _nameLabel.text = model.uName;
        }else
        {
            [_headImgView setImageURLStr:model.bHeader placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
            _nameLabel.text = model.bName;
        }

        if (model.statusId == 0) {
            _statusLabel.text = @"当前状态:已取消";
            
        }else if (model.statusId == 1)
        {
            _statusLabel.text = @"当前状态:待接单";

        }else if (model.statusId == 2)
        {
            _statusLabel.text = @"当前状态:已抢单";

        }else if (model.statusId == 3)
        {
            _statusLabel.text = @"当前状态:已接单";

        }else if (model.statusId == 4)
        {
            _statusLabel.text = @"当前状态:已购买";

        }else if (model.statusId == 5)
        {
            _statusLabel.text = @"当前状态:已取货";

        }else if (model.statusId == 6)
        {
            _statusLabel.text = @"当前状态:已办完";
 
        }else if (model.statusId == 7)
        {
            _statusLabel.text = @"当前状态:待付款";

        }else if (model.statusId == 8)
        {
            _statusLabel.text = @"当前状态:待评价";
        }else
        {
            // isEvaluated 0表示未评价，>0表示已评价
            if (model.isEvaluated == 0) {
                _statusLabel.text = @"当前状态:待评价";
            }else
            {
                _statusLabel.text = @"当前状态:交易结束";
            }
        }
        
        NSMutableAttributedString * attributedTextString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_statusLabel.text]];
        [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:TextDetailCOLOR range:NSMakeRange(0, 5)];
        [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(5, _statusLabel.text.length - 5)];
        _statusLabel.text = @"";
        _statusLabel.attributedText = attributedTextString2;

        
    }

}



- (void)callPhone
{
    [self.delegate callPhoneWithModel:_tempModel];
}

@end
