//
//  CertificateVController.m
//  HSApp
//
//  Created by cbwl on 16/9/9.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "CertificateVController.h"
#import "iToast.h"
#import "NetModel.h"
#import "communcation.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
@interface CertificateVController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITextField *CodeTF;
@property (nonatomic, strong) UITextField *NameTF;
@property (nonatomic, strong) UITextField *PwdTF;

@end

@implementation CertificateVController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBgColor;
    //添加头部菜单栏
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 0, 150, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = MiddleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = @"系统切换";
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:_titleLabel];
    }
    self.navigationItem.titleView = _titleView;
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 30, 30);
    [leftItem setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 40, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = MiddleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _CodeTF = [[UITextField alloc]init];
    _CodeTF.frame = CGRectMake((SCREEN_WIDTH -250)/2, 150, 250, 40);
    _CodeTF.placeholder = @" 请输入公司编码";
    _CodeTF.font = MiddleFont;
    _CodeTF.textColor = TextMainCOLOR;
    _CodeTF.layer.cornerRadius =10;
    _CodeTF.layer.borderColor = MAINCOLOR.CGColor;
    _CodeTF.layer.borderWidth = 0.5;
    [self.view addSubview:_CodeTF];
    
    _NameTF = [[UITextField alloc]init];
    _NameTF.frame = CGRectMake((SCREEN_WIDTH -250)/2, 200, 250, 40);
    _NameTF.placeholder = @" 请输入公司提供的用户名";
    _NameTF.font = MiddleFont;
    _NameTF.textColor = TextMainCOLOR;
    _NameTF.layer.cornerRadius =10;
    _NameTF.layer.borderColor = MAINCOLOR.CGColor;
    _NameTF.layer.borderWidth = 0.5;
    [self.view addSubview:_NameTF];
    
    _PwdTF = [[UITextField alloc]init];
    _PwdTF.frame = CGRectMake((SCREEN_WIDTH -250)/2, 250, 250, 40);
    _PwdTF.placeholder = @" 请输入公司提供的密码";
    _PwdTF.secureTextEntry = YES;
    _PwdTF.font = MiddleFont;
    _PwdTF.textColor = TextMainCOLOR;
    _PwdTF.layer.cornerRadius =10;
    _PwdTF.layer.borderColor = MAINCOLOR.CGColor;
    _PwdTF.layer.borderWidth = 0.5;
    [self.view addSubview:_PwdTF];
    
    
}

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightItemClick{
    
    if (_CodeTF.text.length ==0)
    {
        [[iToast makeText:@"请输入公司编码"] show];
        return;
    }
    else if (_NameTF.text.length ==0)
    {
        [[iToast makeText:@"请输入公司提供的用户名"] show];
        return;
    }
    else if (_PwdTF.text.length ==0)
    {
        [[iToast makeText:@"请输入公司提供的密码"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"企业认证中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *KeyArr = [[NSArray alloc]initWithObjects:userInfoModel.key,userInfoModel.telephone,userInfoModel.notifyid,_CodeTF.text,_NameTF.text,_PwdTF.text, nil];
    
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr];
    In_QiYeModel *InModel = [[In_QiYeModel alloc]init];
    
    InModel.key = userInfoModel.key;
    InModel.digest = hamcString;
    InModel.mobile = userInfoModel.telephone;
    InModel.notifyid = userInfoModel.notifyid;
    InModel.companycode = _CodeTF.text;
    InModel.username = _NameTF.text;
    InModel.password = _PwdTF.text;
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSDictionary *OutDic = [[communcation sharedInstance] CertificateVControllerWithModel:InModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            DLog(@"切换系统    %@",OutDic);
            int code=[[OutDic  objectForKey:@"code"] intValue];
            if (!OutDic){
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }
            else if (code ==1000)
            {
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                [userdefault setValue:@"1000" forKey:@"ChengGong"];
                [userdefault synchronize];

                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"系统切换成功!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                alert.tag=200;
                [alert show];

            
                NSString *str=[[OutDic objectForKey:@"data"] objectForKey:@"companycode"];
                [self upDataUserMag:userInfoModel NSString:str];
                         }else{
                
                [[iToast makeText:[OutDic objectForKey:@"message"]] show];
            }
        });
        
    });
    
    
}



-(void)upDataUserMag:(UserInfoSaveModel *)outModel NSString:(NSString *)comCode{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    UserInfoSaveModel *saveModel = [[UserInfoSaveModel alloc] init];
    //                NSLog(@"dianhua %@",saveModel.telephone);
    saveModel.primaryKey = outModel.primaryKey;
    saveModel.key = outModel.key;
    saveModel.userId = outModel .userId;
    saveModel.username = outModel .username;
    saveModel.type = outModel .type;
    saveModel.status = outModel .status;
    saveModel.isdelete = outModel .isdelete;
    saveModel.header = outModel .header;
    saveModel.telephone = outModel .telephone;
    saveModel.gender = outModel .gender;
    saveModel.notifyid = outModel .notifyid;
    saveModel.level = outModel .level;
    saveModel.point = outModel .point;
    saveModel.istested = outModel .istested;
    saveModel.istrained = outModel .istrained;
    saveModel.cityName = outModel .cityName;
    saveModel.tag = outModel .tag;
    saveModel.positiveIdPath = outModel .positiveIdPath;
    saveModel.negativeIdPath = outModel .negativeIdPath;
    saveModel.handIdPath = outModel .handIdPath;
    saveModel.authenTelephone = outModel .authenTelephone;
    saveModel.realName = outModel .realName;
    saveModel.idNum = outModel .idNum;
    saveModel.brokerStatus = outModel .brokerStatus;
    saveModel.isbroker = outModel .isbroker;
    saveModel.declaration = outModel .declaration;
    saveModel.birthday = outModel .birthday;
    saveModel.isauthen = outModel .isauthen;
    saveModel.stars = outModel .stars;
    saveModel.title = outModel .title;
    saveModel.isFirst = @"1";
    saveModel.isSetPayPassword = outModel .isSetPayPassword;
    saveModel.isBindWithdrawAccount = outModel .isBindWithdrawAccount;
    saveModel.iswork = outModel .iswork;
    saveModel.companycode = comCode;
    
    
    NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:saveModel];
    [userDefault setObject:setData forKey:UserKey];
    [userDefault synchronize];



    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
