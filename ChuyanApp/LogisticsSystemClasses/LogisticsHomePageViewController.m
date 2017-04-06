//
//  LogisticsHomePageViewController.m
//  HSApp
//
//  Created by xc on 16/1/18.
//  Copyright © 2016年 xc. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "LogisticsHomePageViewController.h"
#import "LogisticsTotalTableViewCell.h"
#import "LogisticsMenusTableViewCell.h"
#import "LoginViewController.h"
#import "LScannerViewController.h"
#import "LSendGoodsViewController.h"
#import "LNotificationViewController.h"
#import "LWorkReportViewController.h"
#import "LPersonalViewController.h"
#import "forgetPswViewController.h"
#import "PayRreportVController.h"
@interface LogisticsHomePageViewController ()<MenusDelegate,BackHomeDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    Out_LogisticsHomeBody *_tempModel;
    
    UIAlertView *AlertViewOne;
//   AVAudioPlayer* avAudioPlayer ;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *homeTableview;


@end

@implementation LogisticsHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从budle路径下读取音频文件　　轻音乐 - 萨克斯回家 这个文件名是你的歌曲名字,mp3是你的音频格式
 
    //添加头部菜单栏
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 0, 150, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = WhiteBgColor;
        _titleLabel.text = @"晟邦物流";
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:_titleLabel];
    }
    self.navigationItem.titleView = _titleView;
    
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 30, 30);
    [leftItem setImage:[UIImage imageNamed:@"lbtn_back"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];

    [self inithomeTableView];
    [self.view addSubview:_homeTableview];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBarTintColor:MAINCOLOR];
    [self getLogisticsInfo];
}


//初始化table
-(UITableView *)inithomeTableView
{
    if (_homeTableview != nil) {
        return _homeTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.homeTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _homeTableview.delegate = self;
    _homeTableview.dataSource = self;
    _homeTableview.backgroundColor = MAINCOLOR;
    _homeTableview.showsVerticalScrollIndicator = NO;

    return _homeTableview;
}


#pragma mark    获取物流信息   工作首页列表
///获取物流信息
- (void)getLogisticsInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString *hamcString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LogisticsHomeModel *outModel = [[communcation sharedInstance] getLogisticsInfoWith:userInfoModel.userId andDigest:hamcString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _tempModel = outModel.data;
                _titleLabel.text=outModel.data.companyname;
                [_homeTableview reloadData];
                
            }else{
                [[iToast makeText:outModel.message] show];
                DLog(@"晟邦物流  %@",outModel.message);
                NSArray *arrayForg=[outModel.message componentsSeparatedByString:@"_"];
                NSString *indentfi=[arrayForg lastObject];
//                NSLog(@"%@",[arrayForg lastObject]);
                if ([indentfi isEqualToString:@"用户密码不正确"]) {
//                    NSLog(@"晟邦物流-密码已被修改");
                    UIAlertView *alerltView1=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"密码错误,请修改密码" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    alerltView1.tag=300;
                    [alerltView1 show];
                }
                
                if ([@"请登录" isEqualToString:outModel.message]){
                    UIAlertView *alerltView1=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    alerltView1.tag=200;
                    [alerltView1 show];
                }
            }
        });
        
    });

}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"屏幕尺寸%f",SCREEN_HEIGHT);
    if (indexPath.row == 0) {
        if (SCREEN_HEIGHT == 480) {
             return 230;
        }
        else if (SCREEN_HEIGHT ==568){
             return 283;
        }
        else if (SCREEN_HEIGHT ==667){
             return 383;
        }
        else if (SCREEN_HEIGHT ==736){
             return 383;
        }
        return 0;
    }else
    {
        if (SCREEN_HEIGHT == 480) {
            return 190;
        }
        else if (SCREEN_HEIGHT ==568){
            return 220;
        }
        else if (SCREEN_HEIGHT ==667){
            return 220;
        }
        else if (SCREEN_HEIGHT ==736){
            return 220;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identCell = @"LogisticsTotalTableViewCell";
        LogisticsTotalTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
        
        if (cell == nil) {
            cell = [[LogisticsTotalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        }
        [cell setModel:_tempModel];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else
    {
        static NSString *identCell = @"LogisticsMenusTableViewCell";
        LogisticsMenusTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
        
        if (cell == nil) {
            cell = [[LogisticsMenusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellFrame:_tempModel];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark   领货 角色ID，4表示站长，2表示小件员
- (void)getPacketClickDelegate
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        AlertViewOne = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"相机访问受限,是否前往设置界面打开" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [AlertViewOne show];
        return;
    }
    else{
        LScannerViewController *lScannerVC = [[LScannerViewController alloc] init];
        lScannerVC.type=2;
        [self.navigationController pushViewController:lScannerVC animated:YES];
    }
  
}
#pragma mark 送货
- (void)sendPacketClickDelegate
{
    LSendGoodsViewController *lSendVc = [[LSendGoodsViewController alloc] init];
    [self.navigationController pushViewController:lSendVc animated:YES];
}
#pragma mark 通知
- (void)messageClickDelegate
{
    LNotificationViewController *notificationVC = [[LNotificationViewController alloc] init];
    [self.navigationController pushViewController:notificationVC animated:YES];
}
#pragma mark 工作汇总

- (void)workClickDelegate
{
    LWorkReportViewController *workVC = [[LWorkReportViewController alloc] init];
    [self.navigationController pushViewController:workVC animated:YES];

}
#pragma mark 个人中心
- (void)personClickDelegate
{
    LPersonalViewController *personVC = [[LPersonalViewController alloc] init];
    personVC.delegate = self;
    [self.navigationController pushViewController:personVC animated:YES];
}
#pragma mark 缴款单  到货  角色ID，4表示站长，2表示小件员
- (void)JiaoKuanClickDelegate;//jiao缴款单
{
    if ([_tempModel.roleid isEqualToString:@"4"]){
        LScannerViewController *lScannerVC = [[LScannerViewController alloc] init];
        lScannerVC.type=4;
        [self.navigationController pushViewController:lScannerVC animated:YES];    }
    else{
        
        PayRreportVController *pay=[[PayRreportVController alloc]init];
        pay.model=_tempModel;
        [self.navigationController pushViewController:pay animated:YES];

    }
}


#pragma BackHomeDelegate 返回雏燕代理实现
- (void)backToHomeDelegate
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)JumpPage{
    

    LSendGoodsViewController *lSendVc = [[LSendGoodsViewController alloc] init];
    [self.navigationController pushViewController:lSendVc animated:YES];
}

//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView == AlertViewOne) {
        if (buttonIndex ==0) {
            
        }else
        {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
    else if (alertView.tag==200){
        if (buttonIndex==1) {
            LoginViewController *login=[[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    else if (alertView.tag==300){
        if (buttonIndex==1) {
            forgetPswViewController *login=[[forgetPswViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }

}

@end
