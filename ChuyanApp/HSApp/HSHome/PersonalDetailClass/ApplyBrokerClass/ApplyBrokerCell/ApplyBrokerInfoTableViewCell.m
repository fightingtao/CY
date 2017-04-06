//
//  ApplyBrokerInfoTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ApplyBrokerInfoTableViewCell.h"

@interface ApplyBrokerInfoTableViewCell ()

@property (nonatomic, strong) UIView *menucontentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UILabel *tipLabel1;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UILabel *tipLabel2;

@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UITextField *idTextField;
@property (nonatomic, strong) UILabel *tipLabel3;

@end

@implementation ApplyBrokerInfoTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        if (!_menucontentView) {
            _menucontentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CellViewHeight)];
            [self.contentView addSubview:_menucontentView];
        }
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftBackViewHeight,0,60,50)];
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            [_nameLabel setTextColor:TextMainCOLOR];
            [_nameLabel setFont:LittleFont];
            _nameLabel.text = @"真实姓名";
            [_menucontentView addSubview:_nameLabel];
        }
        
        if (!_nameTextField) {
            _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftBackViewHeight+80, 0, SCREEN_WIDTH-LeftBackViewHeight-100, 50)];
            _nameTextField.borderStyle = UITextBorderStyleNone;
            _nameTextField.placeholder = @"请输入您的真实姓名";
            _nameTextField.backgroundColor = [UIColor clearColor];
            _nameTextField.textColor = TextMainCOLOR;
            _nameTextField.delegate = self;
            _nameTextField.font = LittleFont;
            _nameTextField.returnKeyType = UIReturnKeyDone;
            [_menucontentView addSubview:_nameTextField];
        }
        if (!_tipLabel1) {
            _tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-LeftBackViewHeight,0,10,50)];
            _tipLabel1.textAlignment = NSTextAlignmentCenter;
            [_tipLabel1 setTextColor:[UIColor redColor]];
            [_tipLabel1 setFont:[UIFont systemFontOfSize:15.0]];
            _tipLabel1.text = @"*";
            [_menucontentView addSubview:_tipLabel1];
        }
        
        
        
        
        if (!_phoneLabel) {
            _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftBackViewHeight,50,60,50)];
            _phoneLabel.textAlignment = NSTextAlignmentCenter;
            [_phoneLabel setTextColor:TextMainCOLOR];
            [_phoneLabel setFont:LittleFont];
            _phoneLabel.text = @"联系电话";
            [_menucontentView addSubview:_phoneLabel];
        }
        
        if (!_phoneTextField) {
            _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftBackViewHeight+80, 50, SCREEN_WIDTH-LeftBackViewHeight-100, 50)];
            _phoneTextField.borderStyle = UITextBorderStyleNone;
            _phoneTextField.placeholder = @"请输入您的电话号码";
            _phoneTextField.backgroundColor = [UIColor clearColor];
            _phoneTextField.textColor = TextMainCOLOR;
            _phoneTextField.delegate = self;
            _phoneTextField.font = LittleFont;
            _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
            _phoneTextField.returnKeyType = UIReturnKeyDone;
            [_menucontentView addSubview:_phoneTextField];
        }
        
        if (!_tipLabel2) {
            _tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-LeftBackViewHeight,50,10,50)];
            _tipLabel2.textAlignment = NSTextAlignmentCenter;
            [_tipLabel2 setTextColor:[UIColor redColor]];
            [_tipLabel2 setFont:LittleFont];
            _tipLabel2.text = @"*";
            [_menucontentView addSubview:_tipLabel2];
        }
        
        
        
        if (!_idLabel) {
            _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftBackViewHeight,100,60,50)];
            _idLabel.textAlignment = NSTextAlignmentCenter;
            [_idLabel setTextColor:TextMainCOLOR];
            [_idLabel setFont:LittleFont];
            _idLabel.text = @"身份证号";
            [_menucontentView addSubview:_idLabel];
        }
        
        if (!_idTextField) {
            _idTextField = [[UITextField alloc] initWithFrame:CGRectMake(LeftBackViewHeight+80, 100, SCREEN_WIDTH-LeftBackViewHeight-100, 50)];
            _idTextField.borderStyle = UITextBorderStyleNone;
            _idTextField.placeholder = @"请输入您的身份证号码";
            _idTextField.backgroundColor = [UIColor clearColor];
            _idTextField.textColor = TextMainCOLOR;
            _idTextField.delegate = self;
            _idTextField.font = LittleFont;
            _idTextField.returnKeyType = UIReturnKeyDone;
            [_menucontentView addSubview:_idTextField];
        }
        
        if (!_tipLabel3) {
            _tipLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-LeftBackViewHeight,100,10,45)];
            _tipLabel3.textAlignment = NSTextAlignmentCenter;
            [_tipLabel3 setTextColor:[UIColor redColor]];
            [_tipLabel3 setFont:LittleFont];
            _tipLabel3.text = @"*";
            [_menucontentView addSubview:_tipLabel3];
        }
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50,SCREEN_WIDTH, 0.5)];
        line1.backgroundColor = LineColor;
        [_menucontentView addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 0.5)];
        line2.backgroundColor = LineColor;
        [_menucontentView addSubview:line2];
        
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


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _nameTextField) {
        
        [self.delegate setAgentInfo:_nameTextField.text andType:1];
    }else if (textField == _phoneTextField)
    {
        [self.delegate setAgentInfo:_phoneTextField.text andType:2];
    }else
    {
        [self.delegate setAgentInfo:_idTextField.text andType:3];
    }
}


+(CGFloat)cellHeight
{
    return CellViewHeight;
}

@end
