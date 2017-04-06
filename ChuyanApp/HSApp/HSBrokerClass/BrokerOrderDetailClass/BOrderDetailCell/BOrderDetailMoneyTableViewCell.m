//
//  BOrderDetailMoneyTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BOrderDetailMoneyTableViewCell.h"

@implementation BOrderDetailMoneyTableViewCell

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
    return OrderDetailPayCellHeight;
}



- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model
{
    if (model.statusId < 4)
    {
        if (!model.fee||model.fee == 0) {
            _goodsMoneyLabel.text = @"待定";
        }else
        {
            _goodsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.fee];
        }
        if (!model.tip||model.tip == 0) {
            _tipsMoneyLabel.text = @"待定";
        }else
        {
            _tipsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.tip];
        }
       
        double needPay = model.fee + model.tip - model.discount - model.redAmount;
        if (needPay<0) {
            _payMoneyLabel.text = @"待付款0.01元";
        }else
        {
            _payMoneyLabel.text = [NSString stringWithFormat:@"待付款%0.2f元",needPay];
        }
    }else
    {

        _goodsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.fee];

        _tipsMoneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.tip];

        double needPay = model.fee + model.tip;
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
