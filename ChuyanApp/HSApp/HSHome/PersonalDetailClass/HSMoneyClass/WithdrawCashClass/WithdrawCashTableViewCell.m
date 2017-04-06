//
//  WithdrawCashTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WithdrawCashTableViewCell.h"

@implementation WithdrawCashTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        if (!_tipLabel1) {
            _tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,15,SCREEN_WIDTH,15)];
            _tipLabel1.textAlignment = NSTextAlignmentCenter;
            [_tipLabel1 setTextColor:TextMainCOLOR];
            [_tipLabel1 setFont:[UIFont systemFontOfSize:12]];
            _tipLabel1.text = @"可用余额";
            _tipLabel1.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_tipLabel1];
        }
        
        if (!_enableMoneyLabel) {
            _enableMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,50,SCREEN_WIDTH,50)];
            _enableMoneyLabel.textAlignment = NSTextAlignmentCenter;
            [_enableMoneyLabel setTextColor:[UIColor redColor]];
            [_enableMoneyLabel setFont:[UIFont systemFontOfSize:36.0]];
            _enableMoneyLabel.text = @"--";
            _enableMoneyLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_enableMoneyLabel];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 1)];
        line.backgroundColor = LineColor;
        [self addSubview:line];
        
        if (!_tipLabel2) {
            _tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,165,SCREEN_WIDTH/3,15)];
            _tipLabel2.textAlignment = NSTextAlignmentCenter;
            [_tipLabel2 setTextColor:TextMainCOLOR];
            [_tipLabel2 setFont:LittleFont];
            _tipLabel2.text = @"代购总额";
            _tipLabel2.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_tipLabel2];
        }
        
        if (!_buyTotalLabel) {
            _buyTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,185,SCREEN_WIDTH/3,20)];
            _buyTotalLabel.textAlignment = NSTextAlignmentCenter;
            [_buyTotalLabel setTextColor:[UIColor redColor]];
            [_buyTotalLabel setFont:LittleFont];
            _buyTotalLabel.text = @"--";
            _buyTotalLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_buyTotalLabel];
        }
        
        if (!_buyDetailBtn) {
            _buyDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_buyDetailBtn addTarget:self action:@selector(buyDetailClick) forControlEvents:UIControlEventTouchUpInside];
            _buyDetailBtn.frame = CGRectMake(0, 150, SCREEN_WIDTH/3, 70);
            _buyDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:_buyDetailBtn];
        }
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,  163, 0.5, 44)];
        line2.backgroundColor = LineColor;
        [self addSubview:line2];
        
        
        if (!_tipLabel3) {
            _tipLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,165,SCREEN_WIDTH/3,15)];
            _tipLabel3.textAlignment = NSTextAlignmentCenter;
            [_tipLabel3 setTextColor:TextMainCOLOR];
            [_tipLabel3 setFont:LittleFont];
            _tipLabel3.text = @"小费总额";
            _tipLabel3.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_tipLabel3];
        }
        
        if (!_tipsTotalLabel) {
            _tipsTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,185,SCREEN_WIDTH/3,20)];
            _tipsTotalLabel.textAlignment = NSTextAlignmentCenter;
            [_tipsTotalLabel setTextColor:[UIColor redColor]];
            [_tipsTotalLabel setFont:LittleFont];
            _tipsTotalLabel.text = @"--";
            _tipsTotalLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_tipsTotalLabel];
        }
        
        if (!_tipsDetailBtn) {
            _tipsDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_tipsDetailBtn addTarget:self action:@selector(tipsDetailClick) forControlEvents:UIControlEventTouchUpInside];
            _tipsDetailBtn.frame = CGRectMake(SCREEN_WIDTH/3, 150, SCREEN_WIDTH/3, 70);
            _tipsDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:_tipsDetailBtn];
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 163, 0.5, 44)];
        line3.backgroundColor = LineColor;
        [self addSubview:line3];
        
        
        if (!_tipLabel4) {
            _tipLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2,165,SCREEN_WIDTH/3,15)];
            _tipLabel4.textAlignment = NSTextAlignmentCenter;
            [_tipLabel4 setTextColor:TextMainCOLOR];
            [_tipLabel4 setFont:LittleFont];
            _tipLabel4.text = @"正在提现";
            _tipLabel4.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_tipLabel4];
        }
        
        if (!_withdrawMoneyLabel) {
            _withdrawMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2,185,SCREEN_WIDTH/3,20)];
            _withdrawMoneyLabel.textAlignment = NSTextAlignmentCenter;
            [_withdrawMoneyLabel setTextColor:[UIColor redColor]];
            [_withdrawMoneyLabel setFont:LittleFont];
            _withdrawMoneyLabel.text = @"--";
            _withdrawMoneyLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_withdrawMoneyLabel];
        }
        
        if (!_withdrawDetailBtn) {
            _withdrawDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_withdrawDetailBtn addTarget:self action:@selector(withdrawDetailClick) forControlEvents:UIControlEventTouchUpInside];
            _withdrawDetailBtn.frame = CGRectMake(SCREEN_WIDTH/3*2, 150, SCREEN_WIDTH/3, 70);
            _withdrawDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:_withdrawDetailBtn];
        }
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


+(CGFloat)cellHeight
{
    return WithdrawCashCellHeight;
}


- (void)setCashWithModel:(Out_MoneyBody*)model
{
    if (!model) {
        return;
    }
    _enableMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",model.withdrawAmount];
    _buyTotalLabel.text = [NSString stringWithFormat:@"￥%0.2f",model.purchase_amount];
    _tipsTotalLabel.text = [NSString stringWithFormat:@"￥%0.2f",model.tip_amount];
    _withdrawMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",model.frozen_amount];
}


- (void)buyDetailClick
{
    [self.delegate showBuyDetail];
}

- (void)tipsDetailClick
{
    [self.delegate showTipsDetail];
}

- (void)withdrawDetailClick
{
    [self.delegate showWithdrawDetail];
}

@end
