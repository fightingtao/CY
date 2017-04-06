//
//  BillsDetailTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BillsDetailTableViewCell.h"

@implementation BillsDetailTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        if (!_tipImg) {
            _tipImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
            _tipImg.image = [UIImage imageNamed:@"icon_bill"];
            [self addSubview:_tipImg];
        }

        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,10, 150, 15)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:10.0];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"11-25";
            _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_timeLabel];
        }
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,30, 100, 20)];
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


- (void)setBillsWithModel:(Out_PacketBillsBody*)model
{
    //交易类型，1：充值，2：经纪人收入，3：雇主支付支出，4：提现，5：提现失败退回
    
    //经纪人收支金额，trade_type=2,4,5 -- brokerAmount
    
    //雇主收支金额,trade_type=1,3 -- amount
    
    double unixTimeStamp = model.trade_time/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;
    _contentLabel.text = model.trade_desc;
    if (model.trade_type == 2 || model.trade_type == 4 ||model.trade_type == 5) {
        _moneyLabel.text = [NSString stringWithFormat:@"%0.2f",model.brokerAmount];
    }else
    {
        _moneyLabel.text = [NSString stringWithFormat:@"%0.2f",model.amount];
    }
    
}

@end
