//
//  BOrderDetailAddressTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BOrderDetailAddressTableViewCell.h"

@implementation BOrderDetailAddressTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        self.contentView.backgroundColor = ViewBgColor;
        
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 120, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = LittleFont;
            _titleLabel.textColor = TextMainCOLOR;
            _titleLabel.text = @"送达信息";
            _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_titleLabel];
        }
        
        if (!_menuView) {
            _menuView = [[UIView alloc] initWithFrame:CGRectMake(0,30, SCREEN_WIDTH, OrderAddCellHeigth-30)];
            _menuView.backgroundColor = WhiteBgColor;
            [self addSubview:_menuView];
        }
        
        if (!_userTipImg) {
            _userTipImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
            _userTipImg.contentMode = UIViewContentModeScaleToFill;
            _userTipImg.image = [UIImage imageNamed:@"icon_head"];
            [_menuView addSubview:_userTipImg];
        }
        
        if (!_userNameLabel) {
            _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45,15, 120, 20)];
            _userNameLabel.backgroundColor = [UIColor clearColor];
            _userNameLabel.font = LittleFont;
            _userNameLabel.textColor = TextMainCOLOR;
            _userNameLabel.text = @"一呼哥";
            _userNameLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_userNameLabel];
        }
        
        if (!_phoneTipImg) {
            _phoneTipImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 15, 20, 20)];
            _phoneTipImg.contentMode = UIViewContentModeScaleToFill;
            _phoneTipImg.image = [UIImage imageNamed:@"icon_phone"];
            [_menuView addSubview:_phoneTipImg];
        }
        
        if (!_phoneLabel) {
            _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115,15, 120, 20)];
            _phoneLabel.backgroundColor = [UIColor clearColor];
            _phoneLabel.font = LittleFont;
            _phoneLabel.textColor = TextMainCOLOR;
            _phoneLabel.text = @"15334526536";
            _phoneLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_phoneLabel];
        }
        
        if (!_callBtn) {
            _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _callBtn.frame = CGRectMake(SCREEN_WIDTH-115,10, 120, 30);
            [_callBtn addTarget:self action:@selector(callPhoneClick) forControlEvents:UIControlEventTouchUpInside];
            [_menuView addSubview:_callBtn];
        }
        if (!_downLine) {
            _downLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115, 32, 95, 1)];
            _downLine.backgroundColor = TextDetailCOLOR;
            [_menuView addSubview:_downLine];
        }
        
        
        if (!_addressTipImg) {
            _addressTipImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 55, 20, 20)];
            _addressTipImg.contentMode = UIViewContentModeScaleToFill;
            _addressTipImg.image = [UIImage imageNamed:@"icon_add"];
            [_menuView addSubview:_addressTipImg];
        }
        
        if (!_addressLabel) {
            _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(45,55, SCREEN_WIDTH-65, 20)];
            _addressLabel.backgroundColor = [UIColor clearColor];
            _addressLabel.font = LittleFont;
            _addressLabel.textColor = TextMainCOLOR;
            _addressLabel.text = @"长江贸易大楼17楼";
            _addressLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_addressLabel];
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


+ (CGFloat)cellHeightWithModel:(NSString*)mode
{
    return OrderAddCellHeigth;
}


///设置地址信息 1是代购，2是代办  代送(3是取货 4是送达)
- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model AndType:(int)type
{
    _tempModel = model;
    _type = type;
    if (type == 1)
    {
        _titleLabel.text = @"送达信息";
        _userNameLabel.text = model.toName;
        _phoneLabel.text = model.toTelephone;
        _addressLabel.text = model.toAddress;
    }else if (type == 2)
    {
        _titleLabel.text = @"办事信息";
        _userNameLabel.text = model.toName;
        _phoneLabel.text = model.toTelephone;
        _addressLabel.text = model.toAddress;
    }else if (type == 3)
    {
        _titleLabel.text = @"取货信息";
        _userNameLabel.text = model.fromName;
        _phoneLabel.text = model.fromTelephone;
        _addressLabel.text = model.fromAddress;
    }else
    {
        _titleLabel.text = @"送达信息";
        _userNameLabel.text = model.toName;
        _phoneLabel.text = model.toTelephone;
        _addressLabel.text = model.toAddress;
    }
}

//type 1是代购，2是代办  代送(3是取货 4是送达)
- (void)callPhoneClick
{
    [self.delegate callAddressPhoneWithModel:_tempModel AndType:_type];
}

@end
