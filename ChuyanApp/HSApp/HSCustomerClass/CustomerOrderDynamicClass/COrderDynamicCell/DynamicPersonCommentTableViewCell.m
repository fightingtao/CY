//
//  DynamicPersonCommentTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DynamicPersonCommentTableViewCell.h"

@implementation DynamicPersonCommentTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 8, 33, 33)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            _headImgView.layer.cornerRadius = 16;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [self addSubview:_headImgView];
        }

        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(125,15, SCREEN_WIDTH-130, 20)];
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
- (void)setOrderContentWithModel:(NSString*)model
{
    
}

@end
