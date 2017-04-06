//
//  LogisticsMenusTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/18.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LogisticsMenusTableViewCell.h"
#import "UserInfoSaveModel.h"

@interface LogisticsMenusTableViewCell()
//领货
@property (nonatomic, strong) UIImageView *getPacketImg;
@property (nonatomic, strong) UILabel *getPacketLabel;
@property (nonatomic, strong) UIButton *getPacketBtn;
//送货
@property (nonatomic, strong) UIImageView *sendPacketImg;
@property (nonatomic, strong) UILabel *sendPacketLabel;
@property (nonatomic, strong) UIButton *sendPacketBtn;
//通知
@property (nonatomic, strong) UIImageView *msgImg;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIButton *msgBtn;
//工作汇总
@property (nonatomic, strong) UIImageView *workImg;
@property (nonatomic, strong) UILabel *workLabel;
@property (nonatomic, strong) UIButton *workBtn;
//个人中心
@property (nonatomic, strong) UIImageView *personImg;
@property (nonatomic, strong) UILabel *personLabel;
@property (nonatomic, strong) UIButton *personBtn;

//jiao缴款单
@property (nonatomic, strong) UIImageView *jiaoKuanImg;
@property (nonatomic, strong) UILabel *jiaoKuanLabel;
@property (nonatomic, strong) UIButton *jiaoKuanBtn;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UIView *line5;

@end

@implementation LogisticsMenusTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_getPacketImg) {
            //_getPacketImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-40)/2, 25, 40, 40)];
            _getPacketImg = [[UIImageView alloc] init];
            _getPacketImg.contentMode = UIViewContentModeScaleAspectFill;
            _getPacketImg.image = [UIImage imageNamed:@"Pi2"];
            [self addSubview:_getPacketImg];
        }
        
        if (!_getPacketLabel) {
            //_getPacketLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70,SCREEN_WIDTH/2,20)];
            _getPacketLabel = [[UILabel alloc]init];
            _getPacketLabel.backgroundColor = [UIColor clearColor];
            _getPacketLabel.font = [UIFont systemFontOfSize:15];
            _getPacketLabel.textColor = TextMainCOLOR;
            _getPacketLabel.text = @"领货";
            _getPacketLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _getPacketLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_getPacketLabel];
        }
        
        
        if (!_getPacketBtn) {
            _getPacketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //_getPacketBtn.frame = CGRectMake(0,0,SCREEN_WIDTH/2,110);
            [_getPacketBtn addTarget:self action:@selector(getpacketClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_getPacketBtn];
        }
        
        if (!_sendPacketImg) {
            //_sendPacketImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-40)/2+SCREEN_WIDTH/2, 25, 40, 40)];
            _sendPacketImg = [[UIImageView alloc]init];
            _sendPacketImg.contentMode = UIViewContentModeScaleAspectFill;
            _sendPacketImg.image = [UIImage imageNamed:@"D2"];
            [self addSubview:_sendPacketImg];
        }
        
        if (!_sendPacketLabel) {
            //_sendPacketLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,70,SCREEN_WIDTH/2,20)];
            _sendPacketLabel = [[UILabel alloc]init];
            _sendPacketLabel.backgroundColor = [UIColor clearColor];
            _sendPacketLabel.font = [UIFont systemFontOfSize:15];
            _sendPacketLabel.textColor = TextMainCOLOR;
            _sendPacketLabel.text = @"送货";
            _sendPacketLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _sendPacketLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_sendPacketLabel];
        }
        
        if (!_sendPacketBtn) {
            _sendPacketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //_sendPacketBtn.frame = CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/2,110);
            [_sendPacketBtn addTarget:self action:@selector(sendpacketClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_sendPacketBtn];
        }
        
        if (!_line1) {
            //_line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 0.5)];
            _line1 = [[UIView alloc]init];
            _line1.backgroundColor = LineColor;
            [self addSubview:_line1];
        }
        
        if (!_line2) {
            //_line2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 0.5, 110)];
            _line2 = [[UIView alloc]init];
            _line2.backgroundColor = LineColor;
            [self addSubview:_line2];
        }
        
        if (!_msgImg) {
            //_msgImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3-40)/2, 135, 40, 40)];
            _msgImg = [[UIImageView alloc]init];
            _msgImg.contentMode = UIViewContentModeScaleAspectFill;
            _msgImg.image = [UIImage imageNamed:@"i2"];
            [self addSubview:_msgImg];
        }
        
        if (!_msgLabel) {
            //_msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,180,SCREEN_WIDTH/3,20)];
            _msgLabel = [[UILabel alloc]init];
            _msgLabel.backgroundColor = [UIColor clearColor];
            _msgLabel.font = [UIFont systemFontOfSize:15];
            _msgLabel.textColor = TextMainCOLOR;
            _msgLabel.text = @"通知";
            _msgLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _msgLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_msgLabel];
        }
        
        
        if (!_msgBtn) {
            _msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //_msgBtn.frame = CGRectMake(0,110,SCREEN_WIDTH/3,110);
            [_msgBtn addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_msgBtn];
        }
        
        if (!_workImg) {
            //_workImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3, 135, 40, 40)];
            _workImg = [[UIImageView alloc]init];
            _workImg.contentMode = UIViewContentModeScaleAspectFill;
            _workImg.image = [UIImage imageNamed:@"wo2"];
            [self addSubview:_workImg];
        }
        
        if (!_workLabel) {
            //_workLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,180,SCREEN_WIDTH/3,20)];
            _workLabel = [[UILabel alloc]init];
            _workLabel.backgroundColor = [UIColor clearColor];
            _workLabel.font = [UIFont systemFontOfSize:15];
            _workLabel.textColor = TextMainCOLOR;
            _workLabel.text = @"工作汇总";
            _workLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _workLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_workLabel];
        }
        
        
        if (!_workBtn) {
            _workBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //_workBtn.frame = CGRectMake(SCREEN_WIDTH/3,110,SCREEN_WIDTH/3,110);
            [_workBtn addTarget:self action:@selector(workClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_workBtn];
        }
        
        if (!_personImg) {
            //_personImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3*2, 135, 40, 40)];
            _personImg = [[UIImageView alloc]init];
            _personImg.contentMode = UIViewContentModeScaleAspectFill;
            _personImg.image = [UIImage imageNamed:@"p2"];
            [self addSubview:_personImg];
        }
        
        if (!_personLabel) {
            //_personLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2,180,SCREEN_WIDTH/3,20)];
            _personLabel = [[UILabel alloc]init];
            _personLabel.backgroundColor = [UIColor clearColor];
            _personLabel.font = [UIFont systemFontOfSize:15];
            _personLabel.textColor = TextMainCOLOR;
            _personLabel.text = @"个人中心";
            _personLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _personLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_personLabel];
        }
        
        if (!_personBtn) {
            _personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //_personBtn.frame = CGRectMake(SCREEN_WIDTH/3*2,110,SCREEN_WIDTH/3,110);
            [_personBtn addTarget:self action:@selector(personClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_personBtn];
        }
#pragma mark 缴款单
        
        if (!_jiaoKuanImg) {
            //_personImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3*2, 135, 40, 40)];
            _jiaoKuanImg = [[UIImageView alloc]init];
            _jiaoKuanImg.contentMode = UIViewContentModeScaleAspectFill;
            _jiaoKuanImg.image = [UIImage imageNamed:@"icon_arrive"];
            [self addSubview:_jiaoKuanImg];
        }
        
        if (!_jiaoKuanLabel) {
            //_personLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2,180,SCREEN_WIDTH/3,20)];
            _jiaoKuanLabel = [[UILabel alloc]init];
            _jiaoKuanLabel.backgroundColor = [UIColor clearColor];
            _jiaoKuanLabel.font = [UIFont systemFontOfSize:15];
            _jiaoKuanLabel.textColor = TextMainCOLOR;
            _jiaoKuanLabel.text = @"缴款单";
            _jiaoKuanLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _jiaoKuanLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_jiaoKuanLabel];
        }
        
        if (!_jiaoKuanBtn) {
            _jiaoKuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //_personBtn.frame = CGRectMake(SCREEN_WIDTH/3*2,110,SCREEN_WIDTH/3,110);
            [_jiaoKuanBtn addTarget:self action:@selector(jiaoKuanClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_jiaoKuanBtn];
        }
        

        if (!_line3) {
            //_line3 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 110, 0.5, 110)];
            _line3 = [[UIView alloc]init];
            _line3.backgroundColor = LineColor;
            [self addSubview:_line3];
        }
        
        if (!_line4) {
            //_line4 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 110, 0.5, 110)];
            _line4 = [[UIView alloc]init];
            _line4.backgroundColor = LineColor;
            [self addSubview:_line4];
        }
        
        if (!_line5) {
            //_line4 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 110, 0.5, 110)];
            _line5 = [[UIView alloc]init];
            _line5.backgroundColor = LineColor;
            [self addSubview:_line5];
        }
        _getPacketImg.sd_layout.leftSpaceToView(self,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _getPacketLabel.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _getPacketBtn.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(95);
        
        _line2.sd_layout.leftSpaceToView(_getPacketBtn,0)
        .widthIs(0.5)
        .topSpaceToView(self,0)
        .heightIs(95);
        
        _sendPacketImg.sd_layout.leftSpaceToView(_getPacketBtn,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _sendPacketLabel.sd_layout.leftSpaceToView(_getPacketLabel,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _sendPacketBtn.sd_layout.leftSpaceToView(_getPacketBtn,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(95);
        
        _line3.sd_layout.leftSpaceToView(_sendPacketBtn,0)
        .widthIs(0.5)
        .topSpaceToView(self,0)
        .heightIs(95);
        
        _jiaoKuanImg.sd_layout.leftSpaceToView(_sendPacketBtn,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _jiaoKuanLabel.sd_layout.leftSpaceToView(_sendPacketLabel,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _jiaoKuanBtn.sd_layout.leftSpaceToView(_sendPacketBtn,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(95);
        
        _line1.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(_getPacketBtn,0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(0.5);
        
        
        _msgImg.sd_layout.leftSpaceToView(self,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(_line1,15)
        .widthIs(40)
        .heightIs(40);
        
        _msgLabel.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(_line1,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _msgBtn.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(_line1,0)
        .widthIs(SCREEN_WIDTH/3)
        .bottomSpaceToView(self,0);
        
        _line4.sd_layout.leftSpaceToView(_msgBtn,0)
        .topSpaceToView(_line1,0)
        .widthIs(0.5)
        .bottomSpaceToView(self,0);
        

        _workImg.sd_layout.leftSpaceToView(_msgBtn,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(_line1,15)
        .widthIs(40)
        .heightIs(40);
        
        _workLabel.sd_layout.leftSpaceToView(_msgLabel,0)
        .topSpaceToView(_line1,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _workBtn.sd_layout.leftSpaceToView(_msgBtn,0)
        .topSpaceToView(_line1,0)
        .widthIs(SCREEN_WIDTH/3)
        .bottomSpaceToView(self,0);
        
        _line5.sd_layout.leftSpaceToView(_workBtn,0)
        .topSpaceToView(_line1,0)
        .widthIs(0.5)
        .bottomSpaceToView(self,0);
        _personImg.sd_layout.leftSpaceToView(_workBtn,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(_line1,15)
        .widthIs(40)
        .heightIs(40);
        
        _personLabel.sd_layout.leftSpaceToView(_workLabel,0)
        .topSpaceToView(_line1,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _personBtn.sd_layout.leftSpaceToView(_workBtn,0)
        .topSpaceToView(_line1,0)
        .widthIs(SCREEN_WIDTH/3)
        .bottomSpaceToView(self,0);

        
//        if (SCREEN_HEIGHT == 480) {
//           _getPacketImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2, 15, 40, 40);
//           _getPacketLabel.frame = CGRectMake(0,60,SCREEN_WIDTH/2,20);
//           _getPacketBtn.frame = CGRectMake(0,0,SCREEN_WIDTH/2,95);
//            
//           _sendPacketImg.frame= CGRectMake((SCREEN_WIDTH/2-40)/2+SCREEN_WIDTH/2, 15, 40, 40);
//           _sendPacketLabel.frame= CGRectMake(SCREEN_WIDTH/2,60,SCREEN_WIDTH/2,20);
//           _sendPacketBtn.frame = CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/2,95);
//            
//           _line1.frame = CGRectMake(0, 95, SCREEN_WIDTH, 0.5);
//           _line2.frame = CGRectMake(SCREEN_WIDTH/2, 0, 0.5, 95);
//            
//           _msgImg.frame= CGRectMake((SCREEN_WIDTH/3-40)/2, 110, 40, 40);
//           _msgLabel.frame = CGRectMake(0,155,SCREEN_WIDTH/3,20);
//           _msgBtn.frame = CGRectMake(0,95,SCREEN_WIDTH/3,95);
//            
//           _workImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3, 110, 40, 40);
//           _workLabel.frame = CGRectMake(SCREEN_WIDTH/3,155,SCREEN_WIDTH/3,20);
//           _workBtn.frame = CGRectMake(SCREEN_WIDTH/3,95,SCREEN_WIDTH/3,95);
//            
//           _personImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3*2, 110, 40, 40);
//           _personLabel.frame = CGRectMake(SCREEN_WIDTH/3*2,155,SCREEN_WIDTH/3,20);
//           _personBtn.frame = CGRectMake(SCREEN_WIDTH/3*2,95,SCREEN_WIDTH/3,95);
//           _line3.frame = CGRectMake(SCREEN_WIDTH/3, 95, 0.5, 95);
//           _line4.frame = CGRectMake(SCREEN_WIDTH/3*2, 95, 0.5, 95);
//
//            
//        }
//        else if (SCREEN_HEIGHT ==568){
//            _getPacketImg.frame = CGRectMake((SCREEN_WIDTH/2-40)/2, 25, 40, 40);
//            _getPacketLabel.frame = CGRectMake(0,70,SCREEN_WIDTH/2,20);
//            _getPacketBtn.frame = CGRectMake(0,0,SCREEN_WIDTH/2,110);
//            
//            _sendPacketImg.frame= CGRectMake((SCREEN_WIDTH/2-40)/2+SCREEN_WIDTH/2, 25, 40, 40);
//            _sendPacketLabel.frame= CGRectMake(SCREEN_WIDTH/2,70,SCREEN_WIDTH/2,20);
//            _sendPacketBtn.frame = CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/2,110);
//            
//            _line1.frame = CGRectMake(0, 110, SCREEN_WIDTH, 0.5);
//            _line2.frame = CGRectMake(SCREEN_WIDTH/2, 0, 0.5, 110);
//            
//            _msgImg.frame= CGRectMake((SCREEN_WIDTH/3-40)/2, 135, 40, 40);
//            _msgLabel.frame = CGRectMake(0,180,SCREEN_WIDTH/3,20);
//            _msgBtn.frame = CGRectMake(0,110,SCREEN_WIDTH/3,110);
//            
//            _workImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3, 135, 40, 40);
//            _workLabel.frame = CGRectMake(SCREEN_WIDTH/3,180,SCREEN_WIDTH/3,20);
//            _workBtn.frame = CGRectMake(SCREEN_WIDTH/3,110,SCREEN_WIDTH/3,110);
//            
//            _personImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3*2, 135, 40, 40);
//            _personLabel.frame = CGRectMake(SCREEN_WIDTH/3*2,180,SCREEN_WIDTH/3,20);
//            _personBtn.frame = CGRectMake(SCREEN_WIDTH/3*2,110,SCREEN_WIDTH/3,110);
//            _line3.frame = CGRectMake(SCREEN_WIDTH/3, 110, 0.5, 110);
//            _line4.frame = CGRectMake(SCREEN_WIDTH/3*2, 110, 0.5, 110);
//        }
//        else if (SCREEN_HEIGHT ==667){
//            _getPacketImg.frame = CGRectMake((SCREEN_WIDTH/2-40)/2, 25, 40, 40);
//            _getPacketLabel.frame = CGRectMake(0,70,SCREEN_WIDTH/2,20);
//            _getPacketBtn.frame = CGRectMake(0,0,SCREEN_WIDTH/2,110);
//            
//            _sendPacketImg.frame= CGRectMake((SCREEN_WIDTH/2-40)/2+SCREEN_WIDTH/2, 25, 40, 40);
//            _sendPacketLabel.frame= CGRectMake(SCREEN_WIDTH/2,70,SCREEN_WIDTH/2,20);
//            _sendPacketBtn.frame = CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/2,110);
//            
//            _line1.frame = CGRectMake(0, 110, SCREEN_WIDTH, 0.5);
//            _line2.frame = CGRectMake(SCREEN_WIDTH/2, 0, 0.5, 110);
//            
//            _msgImg.frame= CGRectMake((SCREEN_WIDTH/3-40)/2, 135, 40, 40);
//            _msgLabel.frame = CGRectMake(0,180,SCREEN_WIDTH/3,20);
//            _msgBtn.frame = CGRectMake(0,110,SCREEN_WIDTH/3,110);
//            
//            _workImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3, 135, 40, 40);
//            _workLabel.frame = CGRectMake(SCREEN_WIDTH/3,180,SCREEN_WIDTH/3,20);
//            _workBtn.frame = CGRectMake(SCREEN_WIDTH/3,110,SCREEN_WIDTH/3,110);
//            
//            _personImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3*2, 135, 40, 40);
//            _personLabel.frame = CGRectMake(SCREEN_WIDTH/3*2,180,SCREEN_WIDTH/3,20);
//            _personBtn.frame = CGRectMake(SCREEN_WIDTH/3*2,110,SCREEN_WIDTH/3,110);
//            _line3.frame = CGRectMake(SCREEN_WIDTH/3, 110, 0.5, 110);
//            _line4.frame = CGRectMake(SCREEN_WIDTH/3*2, 110, 0.5, 110);
//        }
//        else if (SCREEN_HEIGHT ==736){
//            _getPacketImg.frame = CGRectMake((SCREEN_WIDTH/2-40)/2, 25, 40, 40);
//            _getPacketLabel.frame = CGRectMake(0,70,SCREEN_WIDTH/2,20);
//            _getPacketBtn.frame = CGRectMake(0,0,SCREEN_WIDTH/2,110);
//            
//            _sendPacketImg.frame= CGRectMake((SCREEN_WIDTH/2-40)/2+SCREEN_WIDTH/2, 25, 40, 40);
//            _sendPacketLabel.frame= CGRectMake(SCREEN_WIDTH/2,70,SCREEN_WIDTH/2,20);
//            _sendPacketBtn.frame = CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/2,110);
//            
//            _line1.frame = CGRectMake(0, 110, SCREEN_WIDTH, 0.5);
//            _line2.frame = CGRectMake(SCREEN_WIDTH/2, 0, 0.5, 110);
//            
//            _msgImg.frame= CGRectMake((SCREEN_WIDTH/3-40)/2, 135, 40, 40);
//            _msgLabel.frame = CGRectMake(0,180,SCREEN_WIDTH/3,20);
//            _msgBtn.frame = CGRectMake(0,110,SCREEN_WIDTH/3,110);
//            
//            _workImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3, 135, 40, 40);
//            _workLabel.frame = CGRectMake(SCREEN_WIDTH/3,180,SCREEN_WIDTH/3,20);
//            _workBtn.frame = CGRectMake(SCREEN_WIDTH/3,110,SCREEN_WIDTH/3,110);
//            
//            _personImg.frame = CGRectMake((SCREEN_WIDTH/3-40)/2+SCREEN_WIDTH/3*2, 135, 40, 40);
//            _personLabel.frame = CGRectMake(SCREEN_WIDTH/3*2,180,SCREEN_WIDTH/3,20);
//            _personBtn.frame = CGRectMake(SCREEN_WIDTH/3*2,110,SCREEN_WIDTH/3,110);
//            _line3.frame = CGRectMake(SCREEN_WIDTH/3, 110, 0.5, 110);
//            _line4.frame = CGRectMake(SCREEN_WIDTH/3*2, 110, 0.5, 110);
//        }
    }
    return self;
}
-(void)setCellFrame:(Out_LogisticsHomeBody *)model;{
    if ([model.roleid isEqualToString:@"4"]) {
        
        _jiaoKuanLabel.text=@"到货";
    }
    else{
        _jiaoKuanLabel.text=@"缴款单";

    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if ([model.companyname isEqualToString:@"雏燕科技"]&&[userInfoModel.companycode isEqualToString:@"chuyan"]){
        self.jiaoKuanBtn.hidden=NO;
        self.jiaoKuanImg.hidden=NO;
        self.jiaoKuanLabel.hidden=NO;
        _getPacketImg.sd_layout.leftSpaceToView(self,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _getPacketLabel.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _getPacketBtn.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(95);
        
        _line2.sd_layout.leftSpaceToView(_getPacketBtn,0)
        .widthIs(0.5)
        .topSpaceToView(self,0)
        .heightIs(95);
        
        _sendPacketImg.sd_layout.leftSpaceToView(_getPacketBtn,(SCREEN_WIDTH/3-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _sendPacketLabel.sd_layout.leftSpaceToView(_getPacketLabel,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(20);
        
        _sendPacketBtn.sd_layout.leftSpaceToView(_getPacketBtn,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/3)
        .heightIs(95);
        

    }
    else{
        self.jiaoKuanBtn.hidden=YES;
        self.jiaoKuanImg.hidden=YES;
        self.jiaoKuanLabel.hidden=YES;
        _getPacketImg.sd_layout.leftSpaceToView(self,(SCREEN_WIDTH/2-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _getPacketLabel.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/2)
        .heightIs(20);
        
        _getPacketBtn.sd_layout.leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/2)
        .heightIs(95);
        
        _line2.sd_layout.leftSpaceToView(_getPacketBtn,0)
        .widthIs(0.5)
        .topSpaceToView(self,0)
        .heightIs(95);
        
        _sendPacketImg.sd_layout.leftSpaceToView(_getPacketBtn,(SCREEN_WIDTH/2-40)/2)
        .topSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        _sendPacketLabel.sd_layout.leftSpaceToView(_getPacketLabel,0)
        .topSpaceToView(self,60)
        .widthIs(SCREEN_WIDTH/2)
        .heightIs(20);
        
        _sendPacketBtn.sd_layout.leftSpaceToView(_getPacketBtn,0)
        .topSpaceToView(self,0)
        .widthIs(SCREEN_WIDTH/2)
        .heightIs(95);
        

    }
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)getpacketClick
{
    [self.delegate getPacketClickDelegate];
}

- (void)sendpacketClick
{
    [self.delegate sendPacketClickDelegate];
}

- (void)msgClick
{
    [self.delegate messageClickDelegate];
}

- (void)workClick
{
    [self.delegate workClickDelegate];
}

- (void)personClick
{
    [self.delegate personClickDelegate];
}
-(void)jiaoKuanClick{
    [self.delegate JiaoKuanClickDelegate];
}
@end
