//
//  CHomeCommentTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CHomeCommentTableViewCell.h"

@implementation CHomeCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 50, 50)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.layer.cornerRadius = 25;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85,25, 120, 20)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameLabel];
        }

        if (!_starView) {
            _starView = [[LHRatingView alloc]initWithFrame:CGRectMake(85, 50, 72, 14)];
            _starView.enbleEdit = NO;
            _starView.score = 5.0;
            _starView.delegate = self;
            [self addSubview:_starView];

        }
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(85,75, SCREEN_WIDTH-105, 20)];
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = LittleFont;
            _contentLabel.textColor = TextMainCOLOR;
            _contentLabel.text = @"评论内容";
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLabel];
        }
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,25, SCREEN_WIDTH/2-20, 20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:12];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"11-13";
            _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _timeLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_timeLabel];
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
    return CHomeCommentCellHeigth;
}

- (void)setOrderContentWithModel:(Out_CommentListBody*)model
{
    if (!model) {
        return;
    }
    _nameLabel.text = model.username;
    [_headImgView setImageURLStr:model.header placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
    _contentLabel.text = model.content;
//    NSLog(@"测试结果输出:%@",model.content);
    double unixTimeStamp = model.create_date/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;
    
    _starView.score = model.point;
    
}

#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    
}
@end
