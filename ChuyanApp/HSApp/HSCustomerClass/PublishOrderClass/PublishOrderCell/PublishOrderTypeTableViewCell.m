//
//  PublishOrderTypeTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PublishOrderTypeTableViewCell.h"

@implementation PublishOrderTypeTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_titleLable) {
            _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 100, 60)];
            _titleLable.backgroundColor = [UIColor clearColor];
            _titleLable.font = LittleFont;
            _titleLable.textColor = TextMainCOLOR;
            _titleLable.text = @"需求类型";
            _titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _titleLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_titleLable];
        }
        
        if (!_contentLable) {
            _contentLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,0, SCREEN_WIDTH/2-35, 60)];
            _contentLable.backgroundColor = [UIColor clearColor];
            _contentLable.font = LittleFont;
            _contentLable.textColor = TextMainCOLOR;
            _contentLable.text = @"代购";
            _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLable.textAlignment = NSTextAlignmentRight;
            [self addSubview:_contentLable];
        }
        
        if (!_arrowImg) {
            _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 17, 25, 25)];
            _arrowImg.image = [UIImage imageNamed:@"btn_choice"];
            [self addSubview:_arrowImg];
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
