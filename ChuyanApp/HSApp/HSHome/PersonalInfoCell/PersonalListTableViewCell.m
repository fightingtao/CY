//
//  PersonalListTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PersonalListTableViewCell.h"
#import "UserInfoSaveModel.h"
@implementation PersonalListTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        

        //各项控件初始化 start
        if (!_titleImg) {
            _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
            _titleImg.image = [UIImage imageNamed:@"btn_choice"];
            [self addSubview:_titleImg];
        }
        
        if (!_contentLable) {
            _contentLable = [[UILabel alloc] initWithFrame:CGRectMake(50,0, 120, 40)];
            _contentLable.backgroundColor = [UIColor clearColor];
            _contentLable.font = LittleFont;
            _contentLable.textColor = TextMainCOLOR;
            _contentLable.text = @"代购";
            _contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _contentLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_contentLable];
        }
        
        if (!_arrowImg) {
            _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45-60, 10, 20, 20)];
            _arrowImg.image = [UIImage imageNamed:@"btn_choice"];
            [self addSubview:_arrowImg];
        }
        
        if (!_ThreeTiShi){
            _ThreeTiShi = [[UILabel alloc]init];
            _ThreeTiShi.backgroundColor = [UIColor clearColor];
            if (userInfoModel.isbroker==1) {
                _ThreeTiShi.text = @"(充值、红包、提现)";
                
            }
            else{
                _ThreeTiShi.text = @"(充值、红包)";
                
            }            _ThreeTiShi.font = LittleFont;
            _ThreeTiShi.textColor = TextMainCOLOR;
            _ThreeTiShi.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_ThreeTiShi];
        }
        
        if (!_BrokerLable){
            _BrokerLable = [[UILabel alloc]init];
            _BrokerLable.backgroundColor = [UIColor clearColor];
            _BrokerLable.font = LittleFont;
            _BrokerLable.textColor = TextMainCOLOR;
            _contentLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_BrokerLable];
        }
        
        if (!_QiYeLable){
            _QiYeLable = [[UILabel alloc]init];
            _QiYeLable.backgroundColor = [UIColor clearColor];
            _QiYeLable.font = LittleFont;
            _QiYeLable.textColor = TextMainCOLOR;
            _QiYeLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_QiYeLable];
        }
        
        
        //end
    }
    return self;
}

- (void)YuAndHongAndTi{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel.isauthen==2) {
        _ThreeTiShi.text = @"(充值、红包、提现)";

    if (SCREEN_HEIGHT == 480){
        _ThreeTiShi.frame = CGRectMake(93, 0, 140, 40);
    }else if (SCREEN_HEIGHT == 568){
        _ThreeTiShi.frame = CGRectMake(93, 0, 140, 40);
    }else if (SCREEN_HEIGHT == 667){
        _ThreeTiShi.frame = CGRectMake(148, 0, 140, 40);
    }else if (SCREEN_HEIGHT == 736){
        _ThreeTiShi.frame = CGRectMake(185, 0, 140, 40);
    }
    }
    else{
        _ThreeTiShi.text = @"(充值、红包)";
        if (SCREEN_HEIGHT == 480){
            _ThreeTiShi.frame = CGRectMake(130, 0, 140, 40);
        }else if (SCREEN_HEIGHT == 568){
            _ThreeTiShi.frame = CGRectMake(130, 0, 140, 40);
        }else if (SCREEN_HEIGHT == 667){
            _ThreeTiShi.frame = CGRectMake(168, 0, 140, 40);
        }else if (SCREEN_HEIGHT == 736){
            _ThreeTiShi.frame = CGRectMake(205, 0, 140, 40);
        }
        
        
        
    }

}

- (void)BrokerLableWithMessage:(int)IntState;
{
    if (SCREEN_HEIGHT == 480) {
        if (IntState == 0){
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"待审核";
        }else if (IntState == 2)
        {
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"已认证";
        }else if (IntState == 3)
        {
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"审核拒绝";
        }
    }
    else if (SCREEN_HEIGHT == 568){
        if (IntState == 0){
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"待审核";
        }else if (IntState == 2)
        {
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"已认证";
        }else if (IntState == 3)
        {
            _BrokerLable.frame = CGRectMake(170, 0, 60, 40);
            _BrokerLable.text = @"审核拒绝";
        }
    }
    else if (SCREEN_HEIGHT == 667){
        if (IntState == 0){
            _BrokerLable.frame = CGRectMake(225, 0, 60, 40);
            _BrokerLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _BrokerLable.frame = CGRectMake(225, 0, 60, 40);
            _BrokerLable.text = @"待审核";
        }else if (IntState == 2)
        {
            _BrokerLable.frame = CGRectMake(225, 0, 60, 40);
            _BrokerLable.text = @"已认证";
        }else if (IntState == 3)
        {
            _BrokerLable.frame = CGRectMake(250, 0, 60, 40);
            _BrokerLable.text = @"审核拒绝";
        }
    }
    else if (SCREEN_HEIGHT == 736){
        if (IntState == 0){
            _BrokerLable.frame = CGRectMake(265, 0, 60, 40);
            _BrokerLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _BrokerLable.frame = CGRectMake(265, 0, 60, 40);
            _BrokerLable.text = @"待审核";
        }else if (IntState == 2)
        {
            _BrokerLable.frame = CGRectMake(265, 0, 60, 40);
            _BrokerLable.text = @"已认证";
        }else if (IntState == 3)
        {
            _BrokerLable.frame = CGRectMake(265, 0, 60, 40);
            _BrokerLable.text = @"审核拒绝";
        }
    }

  
}

- (void)QiYeLableWithMessage:(int)IntState{
    
    if (SCREEN_HEIGHT == 480) {
        if (IntState == 0)
        {
            _QiYeLable.frame = CGRectMake(170, 0, 60, 40);
            _QiYeLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _QiYeLable.frame = CGRectMake(170, 0, 60, 40);
            _QiYeLable.text = @"已认证";
        }
    }
    else if (SCREEN_HEIGHT == 568) {
        if (IntState == 0)
        {
            _QiYeLable.frame = CGRectMake(170, 0, 60, 40);
            _QiYeLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _QiYeLable.frame = CGRectMake(170, 0, 60, 40);
            _QiYeLable.text = @"已认证";
        }
    }
    else if (SCREEN_HEIGHT ==667) {
        if (IntState == 0)
        {
            _QiYeLable.frame = CGRectMake(225, 0, 60, 40);
            _QiYeLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _QiYeLable.frame = CGRectMake(225, 0, 60, 40);
            _QiYeLable.text = @"已认证";
        }
    }
    else if (SCREEN_HEIGHT == 736){
        if (IntState == 0)
        {
            _QiYeLable.frame = CGRectMake(265, 0, 60, 40);
            _QiYeLable.text = @"未认证";
        }else if (IntState == 1)
        {
            _QiYeLable.frame = CGRectMake(265, 0, 60, 40);
            _QiYeLable.text = @"已认证";
        }
    }
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
