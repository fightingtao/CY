//
//  WithdrawBillsTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WithdrawBillsTableViewCell.h"

@implementation WithdrawBillsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 150, 15)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:10.0];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"11-25";
            _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_timeLabel];
        }
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,30, 100, 20)];
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = LittleFont;
            _contentLabel.textColor = TextMainCOLOR;
            _contentLabel.text = @"余额充值";
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLabel];
        }
        
        if (!_moneyLabel) {
            _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,20, SCREEN_WIDTH/2-20, 20)];
            _moneyLabel.backgroundColor = [UIColor clearColor];
            _moneyLabel.font = LittleFont;
            _moneyLabel.textColor = TextMainCOLOR;
            _moneyLabel.text = @"+100元";
            _moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _moneyLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_moneyLabel];
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


- (void)setBillsWithModel:(Out_BillsDetailBody*)model
{
    //交易类型，1：充值，2：经纪人收入，3：雇主支付支出，4：提现，5：提现失败退回
    
    _moneyLabel.text = [NSString stringWithFormat:@"%0.2f元",model.brokerAmount];
    _contentLabel.text = model.trade_desc;
    
    double unixTimeStamp = model.trade_time/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;
}

@end
