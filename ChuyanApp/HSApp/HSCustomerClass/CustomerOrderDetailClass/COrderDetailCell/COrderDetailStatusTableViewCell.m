//
//  COrderDetailStatusTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderDetailStatusTableViewCell.h"

@implementation COrderDetailStatusTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = ViewBgColor;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, OrderDetailStatusCellHeight)];
        bgView.backgroundColor = ViewBgColor;
        [self addSubview:bgView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(25, 0, 1.5, OrderDetailStatusCellHeight)];
        line.backgroundColor = TextDetailCOLOR;
        [bgView addSubview:line];
        
        UIView *round = [[UIView alloc] initWithFrame:CGRectMake(21, 27, 10, 10)];
        round.backgroundColor = TextDetailCOLOR;
        round.layer.cornerRadius = 5;
        [bgView addSubview:round];
        
        
        if (!_contentImgView) {
            _contentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 5,SCREEN_WIDTH-60 , 55)];
            _contentImgView.image = [UIImage imageNamed:@"icon_triangle"];
            [bgView addSubview:_contentImgView];
        }
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,_contentImgView.frame.size.width/2,OrderDetailStatusCellHeight/2)];
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            [_titleLabel setTextColor:TextMainCOLOR];
            [_titleLabel setFont:LittleFont];
            _titleLabel.text = @"呼单已发布";
            [_contentImgView addSubview:_titleLabel];
        }
        
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_contentImgView.frame.size.width/2-10,0,_contentImgView.frame.size.width/2,OrderDetailStatusCellHeight/2)];
            _timeLabel.textAlignment = NSTextAlignmentRight;
            [_timeLabel setTextColor:TextMainCOLOR];
            [_timeLabel setFont:[UIFont systemFontOfSize:12.0]];
            _timeLabel.text = @"11-19";
            [_contentImgView addSubview:_timeLabel];
        }
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,OrderDetailStatusCellHeight/2-10,_contentImgView.frame.size.width-20,OrderDetailStatusCellHeight/2)];
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            [_contentLabel setTextColor:TextMainCOLOR];
            [_contentLabel setFont:[UIFont systemFontOfSize:12.0]];
            _contentLabel.text = @"呼单状态测试呼单状态测试";
            _contentLabel.numberOfLines = 2;
            [_contentImgView addSubview:_contentLabel];
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



+ (CGFloat)cellHeightWithModel:(NSString*)model
{
    return OrderDetailStatusCellHeight;
}



- (void)setOrderContentWithModel:(Out_OrderDetailStatusBody*)model
{
    _titleLabel.text = model.content;
    _contentLabel.text = model.user_msg;
    //设置时间
    double unixTimeStamp = model.create_date/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;

}
@end
