//
//  YuEZhiFuTableViewCell.m
//  HSApp
//
//  Created by cbwl on 16/5/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "YuEZhiFuTableViewCell.h"
#import "publicResource.h"

@implementation YuEZhiFuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        
        if (!_imgview) {
            _imgview = [[UIImageView alloc] initWithFrame:CGRectMake(20,25/2,35,35)];
            _imgview.image = [UIImage imageNamed:@"btn_choice"];
            [self addSubview:_imgview];
        }
        
        if (!_titleLable) {
            _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(70,5, SCREEN_WIDTH/2, 30)];
            _titleLable.backgroundColor = [UIColor clearColor];
            _titleLable.font = LittleFont;
            _titleLable.textColor = TextMainCOLOR;
            _titleLable.text = @"余额支付";
            _titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _titleLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_titleLable];
        }
        
        if (!_contentLable) {
            _contentLable = [[UILabel alloc] initWithFrame:CGRectMake(70,25, SCREEN_WIDTH/2, 30)];
            _contentLable.backgroundColor = [UIColor clearColor];
            _contentLable.font = [UIFont systemFontOfSize:10];
            _contentLable.textColor = TextDetailCOLOR;
            _contentLable.text = @"推荐";
            _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLable];
        }
        
        if (!_arrowImg) {
            _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 17, 25, 25)];
            _arrowImg.image = [UIImage imageNamed:@"btn_choice"];
            [self addSubview:_arrowImg];
        }
        
        if (!_balanceLable) {
            _balanceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,0, SCREEN_WIDTH/2-35, 60)];
            _balanceLable.backgroundColor = [UIColor clearColor];
            _balanceLable.font = LittleFont;
            _balanceLable.textColor = [UIColor colorWithRed:250.0/250.0 green:69.0/250.0 blue:53.0/250.0 alpha:1];
            _balanceLable.text = @"16.9";
            _balanceLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _balanceLable.textAlignment = NSTextAlignmentRight;
            [self addSubview:_balanceLable];
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

@end
