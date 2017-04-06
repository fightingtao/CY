//
//  MegDynamicTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MegDynamicTableViewCell.h"

@implementation MegDynamicTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_headImg) {
            _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 40, 40)];
            _headImg.image = [UIImage imageNamed:@"nav_leftbar_info"];
            _headImg.layer.cornerRadius = 20;
            _headImg.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImg.layer setBorderWidth:0.1];
            [_headImg.layer setBorderColor:[UIColor clearColor].CGColor];
            [self addSubview:_headImg];
        }
        
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,15, SCREEN_WIDTH/2, 20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:10];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"2015";
            _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_timeLabel];
        }
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,40, SCREEN_WIDTH-90, 20)];
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = LittleFont;
            _contentLabel.textColor = TextMainCOLOR;
            _contentLabel.text = @"评论";
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLabel];
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

+(CGFloat)cellHeightWithModel:(NSString*)model
{
    return MsgDynamicCellHeight;
}


- (void)setMsgWithModel:(Out_HSMessageBody*)model
{
    [_headImg setImageURLStr:model.header placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
    _contentLabel.text = model.message;
    
    double unixTimeStamp = model.createtime/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;
}

@end
