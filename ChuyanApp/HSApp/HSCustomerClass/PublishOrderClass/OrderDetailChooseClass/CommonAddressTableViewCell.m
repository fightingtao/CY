//
//  CommonAddressTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CommonAddressTableViewCell.h"

@implementation CommonAddressTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_nameAndPhoneLabel) {
            _nameAndPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,10, SCREEN_WIDTH-40, 20)];
            _nameAndPhoneLabel.backgroundColor = [UIColor clearColor];
            _nameAndPhoneLabel.font = LittleFont;
            _nameAndPhoneLabel.textColor = TextMainCOLOR;
            _nameAndPhoneLabel.text = @"一呼哥 13912413252";
            _nameAndPhoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _nameAndPhoneLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_nameAndPhoneLabel];
        }
        
        if (!_addressLabel) {
            _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,35, SCREEN_WIDTH-40, 20)];
            _addressLabel.backgroundColor = [UIColor clearColor];
            _addressLabel.font = LittleFont;
            _addressLabel.textColor = TextMainCOLOR;
            _addressLabel.text = @"长江路99号";
            _addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _addressLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_addressLabel];
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

- (void)setAddressDataWithModel:(OutAddressBody*)model
{
    _nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@  %@",model.name,model.telephone];
    _addressLabel.text = model.text;
}

@end
