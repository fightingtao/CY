//
//  DynamicOrderCommentTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DynamicOrderCommentTableViewCell.h"

@implementation DynamicOrderCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start

        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            _headImgView.layer.cornerRadius = 20;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,15, 200, 20)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameLabel];
        }
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,5, SCREEN_WIDTH/2-20, 20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:10];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"11-13";
            _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _timeLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_timeLabel];
        }

        
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,40, SCREEN_WIDTH-100, 20)];
            _contentLabel.backgroundColor = [UIColor clearColor];
            _contentLabel.font = [UIFont systemFontOfSize:12];
            _contentLabel.textColor = TextMainCOLOR;
            _contentLabel.text = @"评论内容";
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLabel];
        }
        
        
        if (!_commentBtn) {
            _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _commentBtn.frame = CGRectMake(SCREEN_WIDTH-35, CommentCellHeight-20, 15, 15);
            [_commentBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
            [_commentBtn setImage:[UIImage imageNamed:@"icon-comment"] forState:UIControlStateNormal];
//            [self addSubview:_commentBtn];
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
- (void)setOrderContentWithModel:(Out_OrderDynamicCommentBody*)model
{
    if (!model) {
        return;
    }
    if (!model.parent_username||model.parent_username.length == 0) {
        _nameLabel.text = model.username;
    }else
    {
        _nameLabel.text = [NSString stringWithFormat:@"%@对%@回复：",model.username,model.parent_username];
    }
    
    [_headImgView setImageURLStr:model.header placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
    double unixTimeStamp = model.create_date/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;
    _contentLabel.text = model.content;
}

//评论
- (void)commentClick
{
    
}

@end
