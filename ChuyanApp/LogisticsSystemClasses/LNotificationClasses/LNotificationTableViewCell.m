//
//  LNotificationTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LNotificationTableViewCell.h"

@implementation LNotificationTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,10,SCREEN_WIDTH-40,20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = MiddleFont;
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"2016-01-22";
            _timeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_timeLabel];
        }

        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,35,SCREEN_WIDTH-40,20)];
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = MiddleFont;
            _contentLabel.textColor = TextMainCOLOR;
            _contentLabel.text = @"加急订单4325253";
            _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLabel];
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


- (void)setDataWithModel:(Out_LNotificationBody*)model
{
    _timeLabel.text = model.messagetime;
    _contentLabel.text = model.messagecontent;
//    NSLog(@"测试输出%@",model.messagecontent);
}

@end
