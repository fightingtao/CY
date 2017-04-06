//
//  COrderMoneyTotalTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderMoneyTotalTableViewCell.h"

@implementation COrderMoneyTotalTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_goodsLabel) {
            _goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 100, 40)];
            _goodsLabel.font = LittleFont;
            _goodsLabel.textColor = TextMainCOLOR;
            _goodsLabel.text = @"商品金额";
            _goodsLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_goodsLabel];
        }
        
        if (!_goodsMoneyLabel) {
            _goodsMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,0, SCREEN_WIDTH/2, 40)];
            _goodsMoneyLabel.font = LittleFont;
            _goodsMoneyLabel.textColor = TextMainCOLOR;
            _goodsMoneyLabel.text = @"待定";
            _goodsMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_goodsMoneyLabel];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LineColor;
        [self addSubview:line];
        
        if (!_tipsLabel) {
            _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,40, 100, 40)];
            _tipsLabel.font = LittleFont;
            _tipsLabel.textColor = TextMainCOLOR;
            _tipsLabel.text = @"经纪人小费";
            _tipsLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_tipsLabel];
        }
        
        if (!_tipsMoneyLabel) {
            _tipsMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,40, SCREEN_WIDTH/2, 40)];
            _tipsMoneyLabel.font = LittleFont;
            _tipsMoneyLabel.textColor = TextMainCOLOR;
            _tipsMoneyLabel.text = @"待定";
            _tipsMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_tipsMoneyLabel];
        }
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
        line2.backgroundColor = LineColor;
        [self addSubview:line2];
        
        if (!_discountLabel) {
            _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,80, 100, 40)];
            _discountLabel.font = LittleFont;
            _discountLabel.textColor = TextMainCOLOR;
            _discountLabel.text = @"商品优惠";
            _discountLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_discountLabel];
        }
        
        if (!_disMoneyLabel) {
            _disMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,80, SCREEN_WIDTH/2, 40)];
            _disMoneyLabel.font = LittleFont;
            _disMoneyLabel.textColor = TextMainCOLOR;
            _disMoneyLabel.text = @"待定";
            _disMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_disMoneyLabel];
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 0.5)];
        line3.backgroundColor = LineColor;
        [self addSubview:line3];
        if (!_redPacketsLabel) {
            _redPacketsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,120, 100, 40)];
            _redPacketsLabel.font = LittleFont;
            _redPacketsLabel.textColor = TextMainCOLOR;
            _redPacketsLabel.text = @"红包";
            _redPacketsLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_redPacketsLabel];
        }
        
        if (!_redPacketsMoneyLabel) {
            _redPacketsMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,120, SCREEN_WIDTH/2, 40)];
            _redPacketsMoneyLabel.font = LittleFont;
            _redPacketsMoneyLabel.textColor = TextMainCOLOR;
            _redPacketsMoneyLabel.text = @"待定";
            _redPacketsMoneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_redPacketsMoneyLabel];
        }
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 0.5)];
        line4.backgroundColor = LineColor;
        [self addSubview:line4];
        
        if (!_disTotalLabel) {
            _disTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,160, SCREEN_WIDTH/2, 44)];
            _disTotalLabel.font = [UIFont systemFontOfSize:12];
            _disTotalLabel.textColor = [UIColor colorWithRed:250.0/250.0 green:69.0/250.0 blue:53.0/250.0 alpha:1];
            _disTotalLabel.text = @"已优惠15元";
            _disTotalLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_disTotalLabel];
        }
        
        if (!_payMoneyLabel) {
            _payMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,160, SCREEN_WIDTH/2, 44)];
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
    return OrderMoneyTotalCellHeight;
}



- (void)setOrderContentWithModel:(Out_ReadyPayDetailBody*)model And:(Out_RedPacketBody*)redModel
{
    _goodsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.fee];
    _tipsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.tip];
    _disMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.discount];
    
    if (!redModel) {
        _redPacketsMoneyLabel.text = @"待定";
        _disTotalLabel.text = [NSString stringWithFormat:@"已优惠%0.2f元",model.discount];
        
        double needPay = model.fee+model.tip-model.discount;
        _payMoneyLabel.text = [NSString stringWithFormat:@"待付款%0.2f元",needPay];
    }else
    {
        _redPacketsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",redModel.amount];
        
        double allDiscount = model.discount+redModel.amount;
        _disTotalLabel.text = [NSString stringWithFormat:@"已优惠%0.2f元",allDiscount];
        
        double needPay = model.fee+model.tip-model.discount-redModel.amount;
        if (needPay <= 0) {
            _payMoneyLabel.text = @"待付款0.01元";
            return;
        }
        _payMoneyLabel.text = [NSString stringWithFormat:@"待付款%0.2f元",needPay];
    }

}

@end
