//
//  UserInfoTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 60, 60)];
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
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(105,54, 120, 20)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameLabel];
        }
        
        if (!_levelLabel) {
            _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(105,75, 120, 20)];
            _levelLabel.backgroundColor = [UIColor clearColor];
            _levelLabel.font = LittleFont;
            _levelLabel.textColor = TextMainCOLOR;
            _levelLabel.text = @"一代宗师  500点";
            _levelLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _levelLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_levelLabel];
        }
        
        if (!_starView) {
            _starView = [[LHRatingView alloc]initWithFrame:CGRectMake(105, 100, 72, 14)];
            _starView.enbleEdit = NO;
            _starView.score = 5.0;
            _starView.delegate = self;
            [self addSubview:_starView];
            
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
    return UserInfoCellHeigth;
}



- (void)setOrderContentWithModel:(NSString*)model
{
    
}


#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    NSLog(@"分数  %.2f",score);
    
}


@end
