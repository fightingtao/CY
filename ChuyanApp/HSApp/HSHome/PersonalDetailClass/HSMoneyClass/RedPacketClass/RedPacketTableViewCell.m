//
//  RedPacketTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RedPacketTableViewCell.h"

@implementation RedPacketTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = ViewBgColor;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 116)];
        [imageView setImage:[UIImage imageNamed:@"Icon_Red_bg"]];
        [self.contentView addSubview:imageView];
        
        if (!_sideImageView) {
            _sideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2, 116)];
            _sideImageView.image = [[communcation sharedInstance] createImageWithColor:[UIColor redColor]];
            [imageView addSubview:_sideImageView];
        }
        
        if (!_redMoneyLabel) {
            _redMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 92)];
            _redMoneyLabel.backgroundColor = [UIColor clearColor];
            _redMoneyLabel.font = [UIFont systemFontOfSize:36];
            _redMoneyLabel.textColor = [UIColor redColor];
            _redMoneyLabel.text = @"￥10";
            _redMoneyLabel.textAlignment = NSTextAlignmentCenter;
            [imageView addSubview:_redMoneyLabel];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 92, SCREEN_WIDTH-30-30, 0.5)];
        line.backgroundColor = LineColor;
        [imageView addSubview:line];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(100, 10, 0.5, 72)];
        line2.backgroundColor = LineColor;
        [imageView addSubview:line2];
        
        
        if (!_userfulDayLabel) {
            _userfulDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 92, 100, 24)];
            _userfulDayLabel.backgroundColor = [UIColor clearColor];
            _userfulDayLabel.font = [UIFont systemFontOfSize:10];
            _userfulDayLabel.textColor = [UIColor redColor];
            _userfulDayLabel.text = @"还有3天过期";
            _userfulDayLabel.textAlignment = NSTextAlignmentCenter;
            [imageView addSubview:_userfulDayLabel];
        }
        if (!_userfulTimeLabel) {
            _userfulTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 92, SCREEN_WIDTH-40-120-14, 24)];
            _userfulTimeLabel.backgroundColor = [UIColor clearColor];
            _userfulTimeLabel.font = [UIFont systemFontOfSize:10];
            _userfulTimeLabel.textColor = [UIColor lightGrayColor];
            _userfulTimeLabel.text = @"有效期至:2015.11.11";
            _userfulTimeLabel.textAlignment = NSTextAlignmentRight;
            [imageView addSubview:_userfulTimeLabel];
        }
        
        
        if (!_redTitleLabel) {
            _redTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, SCREEN_WIDTH-40-148, 30)];
            _redTitleLabel.backgroundColor = [UIColor clearColor];
            _redTitleLabel.font = LittleFont;
            _redTitleLabel.textColor = TextMainCOLOR;
            _redTitleLabel.text = @"雏燕红包";
            _redTitleLabel.textAlignment = NSTextAlignmentLeft;
            [imageView addSubview:_redTitleLabel];
        }
        
        if (!_redTipLabel) {
            _redTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, SCREEN_WIDTH-40-115, 20)];
            _redTipLabel.backgroundColor = [UIColor clearColor];
            _redTipLabel.font = [UIFont systemFontOfSize:12];
            _redTipLabel.textColor = TextMainCOLOR;
            _redTipLabel.text = @"APP下单使用,专享雏燕优惠";
            _redTipLabel.textAlignment = NSTextAlignmentLeft;
            [imageView addSubview:_redTipLabel];
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

- (void)setRedDataWithModel:(Out_RedPacketBody*)model
{
    //红包状态，1：未使用，2：已使用	3：已过期	4：活动还未开始
    if (model.red_status == 1) {
        _sideImageView.image = [[communcation sharedInstance] createImageWithColor:[UIColor redColor]];
        NSDate *datenow = [NSDate date];
        double nowDate =  (long)[datenow timeIntervalSince1970];
        double endTime = model.active_end_time/1000;
        double tempDate = endTime-nowDate;
        int tempDay = tempDate/(3600*24);
        _userfulDayLabel.text = [NSString stringWithFormat:@"还有%d天过期",tempDay];
        _redMoneyLabel.textColor = [UIColor redColor];
        _userfulDayLabel.textColor = [UIColor redColor];
    }else if (model.red_status == 2)
    {
        _sideImageView.image = [[communcation sharedInstance] createImageWithColor:[UIColor lightGrayColor]];
        _userfulDayLabel.text = @"已使用";
        _redMoneyLabel.textColor = [UIColor lightGrayColor];
        _userfulDayLabel.textColor = [UIColor lightGrayColor];
    }else if (model.red_status == 3)
    {
        _sideImageView.image = [[communcation sharedInstance] createImageWithColor:[UIColor lightGrayColor]];
        _userfulDayLabel.text = @"已过期";
        _redMoneyLabel.textColor = [UIColor lightGrayColor];
        _userfulDayLabel.textColor = [UIColor lightGrayColor];
    }else
    {
        _sideImageView.image = [[communcation sharedInstance] createImageWithColor:[UIColor lightGrayColor]];
        _userfulDayLabel.text = @"活动还未开始";
        _redMoneyLabel.textColor = [UIColor lightGrayColor];
        _userfulDayLabel.textColor = [UIColor lightGrayColor];
    }
    _redMoneyLabel.text = [NSString stringWithFormat:@"￥%0.0f",model.amount];
    _userfulTimeLabel.text =[NSString stringWithFormat:@"有效期至:%@",[self getDateWith:model.active_end_time]] ;
}


- (NSString*)getDateWith:(long)tempdate
{
    double unixTimeStamp = tempdate/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *_date=[_formatter stringFromDate:date];
    return _date;
}

@end
