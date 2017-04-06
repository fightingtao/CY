//
//  MixedPayTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MixedPayTableViewCell.h"

@implementation MixedPayTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        self.contentView.backgroundColor = ViewBgColor;
        
        if (!_orderInfoView) {
            _orderInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
            _orderInfoView.backgroundColor = WhiteBgColor;
            [self addSubview:_orderInfoView];
        }
        if (!_numTitleLabel) {
            _numTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 80, 40)];
            _numTitleLabel.font = LittleFont;
            _numTitleLabel.textColor = TextMainCOLOR;
            _numTitleLabel.text = @"呼单号:";
            _numTitleLabel.textAlignment = NSTextAlignmentLeft;
            [_orderInfoView addSubview:_numTitleLabel];
        }
        
        if (!_orderNumLabel) {
            _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,0, SCREEN_WIDTH-120, 40)];
            _orderNumLabel.font = LittleFont;
            _orderNumLabel.textColor = TextMainCOLOR;
            _orderNumLabel.text = @"2342435235423623423";
            _orderNumLabel.textAlignment = NSTextAlignmentLeft;
            [_orderInfoView addSubview:_orderNumLabel];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LineColor;
        [_orderInfoView addSubview:line];
        
        if (!_payTitleLabel) {
            _payTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,40, 80, 40)];
            _payTitleLabel.font = LittleFont;
            _payTitleLabel.textColor = TextMainCOLOR;
            _payTitleLabel.text = @"实付款:";
            _payTitleLabel.textAlignment = NSTextAlignmentLeft;
            [_orderInfoView addSubview:_payTitleLabel];
        }
        
        if (!_realPayLabel) {
            _realPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,40, SCREEN_WIDTH-120, 40)];
            _realPayLabel.font = LittleFont;
            _realPayLabel.textColor = TextMainCOLOR;
            _realPayLabel.text = @"20元";
            _realPayLabel.textAlignment = NSTextAlignmentLeft;
            [_orderInfoView addSubview:_realPayLabel];
        }
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
        line2.backgroundColor = LineColor;
        [_orderInfoView addSubview:line2];
        
        
        if (!_balanceTitleLabel) {
            _balanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,80, 80, 40)];
            _balanceTitleLabel.font = LittleFont;
            _balanceTitleLabel.textColor = TextMainCOLOR;
            _balanceTitleLabel.text = @"余额:";
            _balanceTitleLabel.textAlignment = NSTextAlignmentLeft;
            [_orderInfoView addSubview:_balanceTitleLabel];
        }
        
        if (!_balanceLabel) {
            _balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,80, SCREEN_WIDTH-120, 40)];
            _balanceLabel.font = LittleFont;
            _balanceLabel.textColor = TextMainCOLOR;
            _balanceLabel.text = @"16元";
            _balanceLabel.textAlignment = NSTextAlignmentLeft;
            [_orderInfoView addSubview:_balanceLabel];
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 119.5, SCREEN_WIDTH, 0.5)];
        line3.backgroundColor = LineColor;
        [_orderInfoView addSubview:line3];
        
        if (!_mixedTitleLabel) {
            _mixedTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,120, 80, 40)];
            _mixedTitleLabel.font = LittleFont;
            _mixedTitleLabel.textColor = TextMainCOLOR;
            _mixedTitleLabel.text = @"还需支付:";
            _mixedTitleLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_mixedTitleLabel];
        }
        
        if (!_mixedPayLabel) {
            _mixedPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,120, SCREEN_WIDTH-120, 40)];
            _mixedPayLabel.font = LittleFont;
            _mixedPayLabel.textColor = [UIColor colorWithRed:250.0/250.0 green:69.0/250.0 blue:53.0/250.0 alpha:1];
            _mixedPayLabel.text = @"4元";
            _mixedPayLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_mixedPayLabel];
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
    return MixedPayCellHeight;
}



- (void)setOrderContentWithModel:(NSString*)model
{
    
}


@end
