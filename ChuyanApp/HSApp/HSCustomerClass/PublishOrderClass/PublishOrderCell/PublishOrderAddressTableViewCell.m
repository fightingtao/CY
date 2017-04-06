//
//  PublishOrderAddressTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PublishOrderAddressTableViewCell.h"

@implementation PublishOrderAddressTableViewCell


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
            _titleLable.text = @"送达地址";
            _titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _titleLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_titleLable];
        }
        
        if (!_phoneLabel) {
            _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,0, SCREEN_WIDTH/2-35, 30)];
            _phoneLabel.backgroundColor = [UIColor clearColor];
            _phoneLabel.font = LittleFont;
            _phoneLabel.textColor = TextMainCOLOR;
            _phoneLabel.text = @"13923453240";
            _phoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _phoneLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_phoneLabel];
        }
        
        if (!_addressLabel) {
            _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,30, SCREEN_WIDTH/2-35, 30)];
            _addressLabel.backgroundColor = [UIColor clearColor];
            _addressLabel.font = LittleFont;
            _addressLabel.textColor = TextMainCOLOR;
            _addressLabel.text = @"南京市长江路长江贸易大楼";
            _addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _addressLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_addressLabel];
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
