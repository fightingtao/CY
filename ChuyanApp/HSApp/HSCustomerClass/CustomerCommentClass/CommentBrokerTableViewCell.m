//
//  CommentBrokerTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CommentBrokerTableViewCell.h"

@implementation CommentBrokerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 60, 60)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.layer.cornerRadius = 30;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95,20, 120, 20)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameLabel];
        }
        
        if (!_levelLabel) {
            _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(95,45, 120, 20)];
            _levelLabel.backgroundColor = [UIColor clearColor];
            _levelLabel.font = LittleFont;
            _levelLabel.textColor = TextMainCOLOR;
            _levelLabel.text = @"一代宗师  500点";
            _levelLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _levelLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_levelLabel];
        }
        
        if (!_starView) {
            _starView = [[LHRatingView alloc]initWithFrame:CGRectMake(95, 70, 72, 14)];
            _starView.enbleEdit = NO;
            _starView.score = 5.0;
            _starView.delegate = self;
            [self addSubview:_starView];
            
        }
        
        if (!_userVoiceLabel) {
            _userVoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(95,80, SCREEN_WIDTH-115, 40)];
            _userVoiceLabel.backgroundColor = [UIColor clearColor];
            _userVoiceLabel.font = [UIFont systemFontOfSize:12];
            _userVoiceLabel.textColor = TextDetailCOLOR;
            _userVoiceLabel.text = @"江湖口号：测试";
            _userVoiceLabel.numberOfLines = 2;
            _userVoiceLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _userVoiceLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_userVoiceLabel];
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

+ (CGFloat)cellHeight
{
    return CBrokerCellHeigth;
}



- (void)setOrderContentWithModel:(Out_CommentUserBody*)model
{
    _nameLabel.text = model.username;
    _levelLabel.text = [NSString stringWithFormat:@"%@  %ld",model.title,model.point];
    _starView.score = model.stars;
    _userVoiceLabel.text = [NSString stringWithFormat:@"江湖口号:%@",model.declaration];
    [_headImgView setImageURLStr:model.header placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
}


#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    
}

@end
