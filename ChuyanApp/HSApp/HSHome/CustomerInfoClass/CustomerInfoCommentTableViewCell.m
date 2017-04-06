//
//  CustomerInfoCommentTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CustomerInfoCommentTableViewCell.h"

@implementation CustomerInfoCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 40, 40)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            _headImgView.layer.cornerRadius = 20;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,15, 120, 20)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameLabel];
        }
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,15, SCREEN_WIDTH/2-20, 20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:10];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"11-13";
            _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _timeLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_timeLabel];
        }
        
        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,40, SCREEN_WIDTH-100, 20)];
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = [UIFont systemFontOfSize:12];
            _contentLabel.textColor = TextMainCOLOR;
            _contentLabel.text = @"评论内容";
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


+ (CGFloat)cellHeightWithModel:(NSString*)model
{
    return CommentCellHeight;
}


- (void)setOrderContentWithModel:(Out_CommentListBody*)model
{
    [_headImgView setImageURLStr:model.header placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
    _nameLabel.text = model.username;
    
    double unixTimeStamp = model.create_date/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    
    _timeLabel.text = _date;
    _contentLabel.text = model.content;
}



@end
