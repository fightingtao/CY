//
//  COrderDetailPay2TableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderDetailPay2TableViewCell.h"

@implementation COrderDetailPay2TableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_tipsLabel) {
            _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 100, 40)];
            _tipsLabel.font = LittleFont;
            _tipsLabel.textColor = TextMainCOLOR;
            _tipsLabel.text = @"经纪人小费";
            _tipsLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_tipsLabel];
        }
        
        if (!_tipsMoneyLabel) {
            _tipsMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,0, SCREEN_WIDTH/2, 40)];
            _tipsMoneyLabel.font = LittleFont;
            _tipsMoneyLabel.textColor = TextMainCOLOR;
            _tipsMoneyLabel.text = @"待定";
            _tipsMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_tipsMoneyLabel];
        }
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
        line3.backgroundColor = LineColor;
        [self addSubview:line3];
        
        
        if (!_redPacketsLabel) {
            _redPacketsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,40, 100, 40)];
            _redPacketsLabel.font = LittleFont;
            _redPacketsLabel.textColor = TextMainCOLOR;
            _redPacketsLabel.text = @"红包";
            _redPacketsLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_redPacketsLabel];
        }
        
        if (!_redPacketsMoneyLabel) {
            _redPacketsMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,40, SCREEN_WIDTH/2, 40)];
            _redPacketsMoneyLabel.font = LittleFont;
            _redPacketsMoneyLabel.textColor = TextMainCOLOR;
            _redPacketsMoneyLabel.text = @"待定";
            _redPacketsMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_redPacketsMoneyLabel];
        }
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
        line4.backgroundColor = LineColor;
        [self addSubview:line4];

        if (!_payMoneyLabel) {
            _payMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,80, SCREEN_WIDTH/2, 44)];
            _payMoneyLabel.font = LittleFont;
            _payMoneyLabel.textColor = TextMainCOLOR;
            _payMoneyLabel.text = @"待付款7元";
            _payMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_payMoneyLabel];
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


+ (CGFloat)cellHeightWithModel:(NSString*)model
{
    return OrderDetailPay2CellHeight;
}



- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model
{
    if (model.statusId < 4)
    {
        
        if (!model.tip||model.tip == 0) {
            _tipsMoneyLabel.text = @"待定";
        }else
        {
            _tipsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.tip];
        }
        
        if (!model.redAmount||model.redAmount == 0) {
            _redPacketsMoneyLabel.text = @"待定";
        }else
        {
            _redPacketsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.redAmount];
        }

        double needPay = model.tip - model.redAmount;
        if (needPay<0) {
            _payMoneyLabel.text = @"待付款0.01元";
        }else
        {
            _payMoneyLabel.text = [NSString stringWithFormat:@"待付款%0.2f元",needPay];
        }
    }else
    {
        _tipsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.tip];

        _redPacketsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.redAmount];

        double needPay = model.tip - model.redAmount;
        if (needPay<0) {
            _payMoneyLabel.text = @"待付款0.01元";
            
            if (model.statusId > 7) {
                _payMoneyLabel.text = @"已付款0.01元";
            }
        }else
        {
            _payMoneyLabel.text = [NSString stringWithFormat:@"待付款%0.2f元",needPay];
            
            if (model.statusId > 7) {
                _payMoneyLabel.text = [NSString stringWithFormat:@"已付款%0.2f元",needPay];
            }
        }
    }
}

@end
