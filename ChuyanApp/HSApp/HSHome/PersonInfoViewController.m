//
//  PersonInfoViewController.m
//  HSApp
//
//  Created by xc on 15/11/6.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "PersonalListTableViewCell.h"
#import "LoginViewController.h"
#import "PersonalInfoViewController.h"
#import "EditUserVoiceViewController.h"
#import "MessageListViewController.h"
#import "RewardRecommendViewController.h"
#import "ApplyBrokerViewController.h"
#import "MoneyListViewController.h"
#import "AboutHSViewController.h"
#import "SettingViewController.h"
#import "BrokerinstitutionViewController.h"
#import "QiYeViewController.h"
#import "forgetPswViewController.h"
#import "AppDelegate.h"
#import "shareView.h"
#import "CertificateVController.h"//雏燕对接  企业认证
#import "ChangeTelephoneNumberController.h"

@interface PersonInfoViewController ()
{
    shareView *_share;
    UIView *_shareBG;
    NSString *_phoneNum;
}
@property (nonatomic, strong) UILabel *userVoiceLabel;//江湖口号
@property (nonatomic, strong) UITableView *personTableView;
@property(nonatomic,strong)UIAlertView *remindView;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:TRUE];
    [self initpersonTableView];
    [self.view addSubview:_personTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getPersonalInfo];
    //    if (_share) {
    //        [_share removeFromSuperview];
    //    }
    if (!_share) {
        _shareBG=[[UIView alloc]initWithFrame:self.view.frame];
        _shareBG.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
        _shareBG.hidden=YES;
        [self.view addSubview:_shareBG];
        
        _share=[[shareView alloc]init];
        _share.frame=CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH-50,110);
        _share.backgroundColor=[UIColor whiteColor];
        _share.hidden=YES;
        [_shareBG addSubview:_share];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapClick:)];
        [_shareBG addGestureRecognizer:tap];
        
    }else
    {
        _share.frame=CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH-50,230);
        _shareBG.hidden=YES;
        
    }
    
}
-(void)onTapClick:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^
     {
         if (_share) {
             _share.frame=CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH-50,220);
             
         }
         
     } completion:^(BOOL finished) {
         _share.hidden=YES;
         _shareBG.hidden=YES;
         
     }];
    
}

//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_personTableView != nil) {
        return _personTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.personTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _personTableView.delegate = self;
    _personTableView.dataSource = self;
    _personTableView.backgroundColor = ViewBgColor;
    self.automaticallyAdjustsScrollViewInsets = false;
    _personTableView.showsVerticalScrollIndicator = NO;
    _personTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _personTableView;
}


#pragma mark 实时刷新用户信息
- (void)getPersonalInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    _phoneNum = userInfoModel.telephone;
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        NSString *hmacString = [[communcation sharedInstance] hmac:userInfoModel.userId withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_RefreshUserInfoModel *outModel = [[communcation sharedInstance] refreshUserInfoWithKey:userInfoModel.userId AndDigest:hmacString];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    
                    UserInfoSaveModel *saveModel = [[UserInfoSaveModel alloc] init];
                    saveModel.primaryKey = outModel.data.primaryKey;
                    saveModel.key = outModel.data.key;
                    saveModel.userId = outModel.data.userId;
                    saveModel.username = outModel.data.username;
                    saveModel.type = outModel.data.type;
                    saveModel.status = outModel.data.status;
                    saveModel.isdelete = outModel.data.isdelete;
                    saveModel.header = outModel.data.header;
                    saveModel.telephone = outModel.data.telephone;
                    saveModel.gender = outModel.data.gender;
                    saveModel.notifyid = outModel.data.notifyid;
                    saveModel.level = outModel.data.level;
                    saveModel.point = outModel.data.point;
                    saveModel.istested = outModel.data.istested;
                    saveModel.istrained = outModel.data.istrained;
                    saveModel.cityName = outModel.data.cityName;
                    saveModel.tag = outModel.data.tag;
                    saveModel.positiveIdPath = outModel.data.positiveIdPath;
                    saveModel.negativeIdPath = outModel.data.negativeIdPath;
                    saveModel.handIdPath = outModel.data.handIdPath;
                    saveModel.authenTelephone = outModel.data.authenTelephone;
                    saveModel.realName = outModel.data.realName;
                    saveModel.idNum = outModel.data.idNum;
                    saveModel.brokerStatus = outModel.data.brokerStatus;
                    saveModel.isbroker = outModel.data.isbroker;
                    saveModel.declaration = outModel.data.declaration;
                    saveModel.birthday = outModel.data.birthday;
                    saveModel.isauthen = outModel.data.isauthen;
                    saveModel.stars = outModel.data.stars;
                    saveModel.title = outModel.data.title;
                    saveModel.isFirst = @"1";
                    saveModel.isSetPayPassword = outModel.data.isSetPayPassword;
                    saveModel.isBindWithdrawAccount = outModel.data.isBindWithdrawAccount;
                    saveModel.iswork = outModel.data.iswork;
                    saveModel.companycode = outModel.data.companycode;
                    NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:saveModel];
                    [userDefault setObject:setData forKey:UserKey];
                    [_personTableView reloadData];
                }else{
                    [[iToast makeText:outModel.message] show];
//                    if ([@"请登录" isEqualToString:outModel.message]){
//                        UIAlertView *alerltView1=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//                        alerltView1.tag=200;
//                        [alerltView1 show];
//                    }
                }
            });
            
        });
    }

}


#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 1;
    }else if (section == 2)
    {
        return 4;
    }else if (section == 3)
    {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        if ([userInfoModel.iswork isEqualToString:@"1"]){
            return 2;
        }
        else if(userInfoModel.iswork == 0)
        {
            return 2;
        }
        else{
            return 0;
        }
    }
    else
    {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 0.01;
    }
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [UserInfoTableViewCell cellHeight];
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (indexPath.section == 0) {
        static NSString *cellName = @"UserInfoTableViewCell";
        UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
        {
            [cell.headImgView setImageURLStr:userInfoModel.header placeholder:[UIImage imageNamed:@"nav_leftbar_info"]];
            cell.nameLabel.text = userInfoModel.username;
            cell.levelLabel.text = [NSString stringWithFormat:@"%@ %@点",userInfoModel.title,userInfoModel.point];
            cell.starView.score = [userInfoModel.stars floatValue];
        }else
        {
            cell.headImgView.image = [UIImage imageNamed:@"nav_leftbar_info"];
            cell.nameLabel.text = @"雏燕";
            cell.levelLabel.text = @"";
            cell.starView.score = 5;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *cellName = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (!_userVoiceLabel)
        {
            _userVoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, SCREEN_WIDTH-80, 40)];
            _userVoiceLabel.backgroundColor = [UIColor clearColor];
            _userVoiceLabel.font = [UIFont systemFontOfSize:12];
            _userVoiceLabel.textColor = TextDetailCOLOR;
            _userVoiceLabel.text = @"在此输入您的江湖口号";
            _userVoiceLabel.numberOfLines = 2;
            _userVoiceLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _userVoiceLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:_userVoiceLabel];
        }
        if (userInfoModel.declaration&&![userInfoModel.declaration isEqualToString:@""]) {
            _userVoiceLabel.text = [NSString stringWithFormat:@"江湖口号:%@",userInfoModel.declaration];
        }else
        {
            _userVoiceLabel.text = @"在此输入您的江湖口号";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString *cellName = @"PersonalListTableViewCell";
        PersonalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonalListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (indexPath.row == 0) {
            cell.titleImg.image = [UIImage imageNamed:@"icon_money"];
            cell.contentLable.text = @"钱包";
            [cell YuAndHongAndTi];
        }else if (indexPath.row == 1)
        {
            cell.titleImg.image = [UIImage imageNamed:@"icon_message"];
            cell.contentLable.text = @"消息";
        }else if (indexPath.row == 2)
        {
            cell.titleImg.image = [UIImage imageNamed:@"icon_good"];
            cell.contentLable.text = @"推荐有奖";
        }else
        {
            cell.titleImg.image = [UIImage imageNamed:@"icon_share"];
            cell.contentLable.text = @"分享朋友";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 3)
    {
        static NSString *cellName = @"PersonalListTableViewCell";
        PersonalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonalListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (indexPath.row == 0) {
            cell.titleImg.image = [UIImage imageNamed:@"icon_agent"];
            cell.contentLable.text = @"认证经纪人";
            [cell BrokerLableWithMessage:[userInfoModel.isauthen intValue]];
        }
//        else if (indexPath.row == 1){
//            cell.titleImg.image = [UIImage imageNamed:@"icon_agent"];
//            cell.contentLable.text = @"企业认证";
//            [cell QiYeLableWithMessage:[userInfoModel.iswork intValue]];
//        }
    else  if (indexPath.row == 1)
        {
            cell.titleImg.image = [UIImage imageNamed:@"icon_system"];
            cell.contentLable.text = @"经纪人管理制度";
        }
//        if ([userInfoModel.iswork isEqualToString:@"1"]) {
//            if (indexPath.row==2) {
//                cell.titleImg.image = [UIImage imageNamed:@"icon_agent"];
//                cell.contentLable.text = @"系统切换";
//
//            }
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 4)
    {
        static NSString *cellName = @"PersonalListTableViewCell";
        PersonalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonalListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
     if(indexPath.row == 0)
        {
            cell.titleImg.image = [UIImage imageNamed:@"icon_about"];
            cell.contentLable.text = @"关于雏燕";
           
        }else{
            cell.titleImg.image = [UIImage imageNamed:@"icon_set"];
            cell.contentLable.text = @"设置";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else
    {
        static NSString *cellName = @"PersonalListTableViewCell";
        PersonalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonalListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.personTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
     AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (indexPath.section == 0) {
        PersonalInfoViewController *personalInfoVC = [[PersonalInfoViewController alloc] init];
        [app.menuViewController pushToNewViewController:personalInfoVC animation:YES];
    }else if (indexPath.section == 1)
    {
//        编辑江湖口号
        EditUserVoiceViewController *editUserVoiceVC = [[EditUserVoiceViewController alloc] init];
//        PersonalInfoViewController *persent=[[PersonalInfoViewController alloc]init];
         [app.menuViewController pushToNewViewController:editUserVoiceVC animation:YES];
//        [self presentViewController:editUserVoiceVC animated:NO completion:nil];
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
//            钱包
            MoneyListViewController *moneyVC = [[MoneyListViewController alloc] init];
            [app.menuViewController pushToNewViewController:moneyVC animation:YES];
        }else if (indexPath.row == 1)
        {
//            消息
            MessageListViewController *msglistVC = [[MessageListViewController alloc] init];
            [app.menuViewController pushToNewViewController:msglistVC animation:YES];
        }else if (indexPath.row == 2)
        {
//            推荐有奖
            RewardRecommendViewController *rewardRecommendVC = [[RewardRecommendViewController alloc] init];
            [app.menuViewController pushToNewViewController:rewardRecommendVC animation:YES];
        }else
        {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^
             {
                 _shareBG.hidden=NO;
                 
                 _share.frame=CGRectMake(0,SCREEN_HEIGHT-110, SCREEN_WIDTH-50,110);
                 _share.hidden=NO;
                 
             }completion:nil];
            
////            分享
//            [UMSocialSnsService presentSnsIconSheetView:app.menuViewController
//                                                 appKey:@"565e5ace67e58eb976007f94"
//                                              shareText:@"http://wxddc42d0f25ecb72c.m.weimob.com/weisite/detail?_tj_twtype=2&_tj_pid=492069&_tt=1&_tj_graphicid=8715021&_tj_title=%E5%85%B3%E4%BA%8E%E5%91%BC%E9%80%81&_tj_keywords=%E5%85%B3%E4%BA%8E%E5%91%BC%E9%80%81&did=1894011&bid=1000107&pid=492069&wechatid=oYLtYuDswKQoqRAirK1ZhFx-vyUs&channel=menu%255E%2523%255E5YWz5LqO5ZG86YCB&from=singlemessage&isappinstalled=0"
//                                             shareImage:nil
//                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,nil]
//                                               delegate:nil];
        }
    }else if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            if (userInfoModel.isauthen == 0) {
                [[iToast makeText:@"未认证"] show];
            }
            if ([userInfoModel.isauthen intValue]== 1) {
                [[iToast makeText:@"待审核"] show];
                return;
            }
            if ([userInfoModel.isauthen intValue]== 2) {
                [[iToast makeText:@"已认证"] show];
                return ;
            }
            if ([userInfoModel.isauthen intValue] == 3) {
                [[iToast makeText:@"审核拒绝"] show];
                
            }
            ApplyBrokerViewController *applyBrokerVC = [[ApplyBrokerViewController alloc] init];
            applyBrokerVC.isRootVC = YES;
            [app.menuViewController pushToNewViewController:applyBrokerVC animation:YES];
        }
//        else if (indexPath.row == 1)
//        {
////            企业认证
//            if (userInfoModel.iswork == 0){
//                QiYeViewController *QiYe = [[QiYeViewController alloc]init];
//                [app.menuViewController pushToNewViewController:QiYe animation:YES];
//            }else if ([userInfoModel.iswork intValue] == 1)
//            {
//                [[iToast makeText:@"已认证"] show];
//
//                                return;
//            }
//          
//        }
//       else if (indexPath.row==3) {
//           if ([userInfoModel.iswork intValue]==1) {
//               //雏燕对接  系统切换
//               CertificateVController *QiYe = [[CertificateVController alloc]init];
//               [app.menuViewController pushToNewViewController:QiYe animation:YES];
//               
//            }
//        }

        else
        {
            
            BrokerinstitutionViewController *institutionVC = [[BrokerinstitutionViewController alloc] init];
            institutionVC.type = 2;
            [app.menuViewController pushToNewViewController:institutionVC animation:YES];
        }
    }else if (indexPath.section == 4)
        
    {
      if  (indexPath.row == 0) {
            //关于雏燕
            AboutHSViewController *acoutVC = [[AboutHSViewController alloc] init];
            [app.menuViewController pushToNewViewController:acoutVC animation:YES];
//            forgetPswViewController *login=[[forgetPswViewController alloc]init];
//           [app.menuViewController pushToNewViewController:login animation:YES];
        }else
        {
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            [app.menuViewController pushToNewViewController:settingVC animation:YES];
        }
        
    }else
    {
        
    }
}





@end
