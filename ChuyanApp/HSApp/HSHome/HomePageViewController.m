//
//  HomePageViewController.m
//  HSApp
//
//  Created by xc on 15/11/5.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "HomePageViewController.h"
#import "CustomerHomeViewController.h"
#import "BrokerHomeViewController.h"

#import "LoginViewController.h"
#import "loginViewController.h"
#import "AppDelegate.h"

#import "JKNotifier.h"

#import "BrokerinstitutionViewController.h"
#import "ApplyBrokerViewController.h"

#import "LogisticsHomePageViewController.h"
#import "MKJNavigationViewController.h"
@interface HomePageViewController ()<UIAlertViewDelegate>
{
    UIAlertView  *_alertGoLogin;
    UIAlertView *alertV;
    NSString *iosDownLoad;
}
@property (nonatomic, strong) CustomerHomeViewController *customerHomeVC;
@property (nonatomic, strong) BrokerHomeViewController *brokerHomeVC;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:WhiteBgColor}];

    //警告框
    _alertGoLogin = [[UIAlertView alloc]initWithTitle:@"暂未登录，先登录吧" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    _alertGoLogin.delegate=self;
    
    //添加头部菜单栏
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, SCREEN_WIDTH-(SCREEN_WIDTH-200)/2, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_customerBtn) {
        _customerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_customerBtn setTitle:@"雇主" forState:UIControlStateNormal];
        [_customerBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [_customerBtn addTarget:self action:@selector(customerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _customerBtn.titleLabel.font = MiddleFont;
        [_customerBtn setBackgroundImage:[UIImage imageNamed:@"nav_btn_agent"] forState:UIControlStateNormal];
        [_titleView addSubview:_customerBtn];
    }
    
    if (!_brokerBtn) {
        _brokerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //_brokerBtn.frame = CGRectMake(70, 8, 60, 25);
        [_brokerBtn setTitle:@"经纪人" forState:UIControlStateNormal];
        [_brokerBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_brokerBtn addTarget:self action:@selector(brokerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _brokerBtn.titleLabel.font = MiddleFont;
        [_brokerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_titleView addSubview:_brokerBtn];
    }
    
    if (!_workBtn) {
        _workBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_workBtn setTitle:@"工作" forState:UIControlStateNormal];
        [_workBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_workBtn addTarget:self action:@selector(workBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _workBtn.titleLabel.font = MiddleFont;
        [_workBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_titleView addSubview:_workBtn];
    }
    self.navigationItem.titleView = _titleView;
    
    //生成顶部右侧按钮
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 44)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 40, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"成就" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = MiddleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    //初始化雇主和经纪人内容view
    if (!_cContentView) {
        _cContentView = [[UIView alloc] initWithFrame:self.view.frame];
        _cContentView.backgroundColor = WhiteBgColor;
        _type = UserType_Customer;
        [self.view addSubview:_cContentView];
    }
    
    if (!_bContentView) {
        _bContentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bContentView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_bContentView];
    }
    
    if (!_customerHomeVC) {
        _customerHomeVC = [[CustomerHomeViewController alloc] init];
        _customerHomeVC.view.frame = self.view.frame;
        [_cContentView addSubview:_customerHomeVC.view];
    }
    
    if (!_brokerHomeVC) {
        _brokerHomeVC = [[BrokerHomeViewController alloc] init];
        _brokerHomeVC.view.frame = self.view.frame;
        [_bContentView addSubview:_brokerHomeVC.view];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = WhiteBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:WhiteBgColor}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushResult:) name:PushNotifyName object:nil];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId && ![userInfoModel.userId isEqualToString:@""]){//已登录
             UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
            leftItem.frame = CGRectMake(0, 0, 30, 30);
            leftItem.layer.cornerRadius = 15;
            leftItem.layer.borderWidth = 1.0;
            leftItem.layer.borderColor =[UIColor clearColor].CGColor;
            leftItem.clipsToBounds = TRUE;
            NSURL *headerUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",userInfoModel.header]];
            [leftItem setImageWithURL:headerUrl forState:UIControlStateNormal placeholderImage:PlaceHoldHeadImg(PLACEHOLDERIMG)];
            [leftItem addTarget:self action:@selector(leftItemClick1) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];

    }else{
      UIButton *   leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        leftItem.frame = CGRectMake(0, 0, 30, 30);
        leftItem.layer.cornerRadius = 15;
        leftItem.layer.borderWidth = 1.0;
        leftItem.layer.borderColor =[UIColor clearColor].CGColor;
        leftItem.clipsToBounds = TRUE;
        [leftItem setImage:[UIImage imageNamed:@"nav_leftbar_info"] forState:UIControlStateNormal];
        [leftItem addTarget:self action:@selector(leftItemClick2) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    }
//手机型号适配
    if (SCREEN_HEIGHT == 480){
        if ([userInfoModel.iswork intValue]== 0){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-10, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2+50-20, 8, 50, 25);
            _workBtn.hidden = YES;
        }
        else if ([userInfoModel.iswork intValue]== 1){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-35, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2-10, 8, 50, 25);
            _workBtn.hidden = NO;
            _workBtn.frame = CGRectMake(_titleView.frame.size.width/4*3+5,8, 50, 25 );
        }
    }
    if (SCREEN_HEIGHT == 568){
        if ([userInfoModel.iswork intValue]== 0){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-10, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2+50-20, 8, 50, 25);
            _workBtn.hidden = YES;
        }
        else if ([userInfoModel.iswork intValue] == 1){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-35, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2-10, 8, 50, 25);
            _workBtn.hidden = NO;
            _workBtn.frame = CGRectMake(_titleView.frame.size.width/4*3+5,8, 50, 25 );
        }
    }
    if (SCREEN_HEIGHT == 667){
        if ([userInfoModel.iswork intValue]== 0){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-10, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2+50-10, 8, 50, 25);
            _workBtn.hidden = YES;
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ChengGong"] intValue ]== 1000) {
                _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-35, 8, 50, 25);
                _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2-5, 8, 50, 25);
                _workBtn.hidden = NO;
                _workBtn.frame = CGRectMake(_titleView.frame.size.width/4*3+7,8, 50, 25 );
            }
        }
        else if ([userInfoModel.iswork intValue] == 1){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-35, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2-5, 8, 50, 25);
            _workBtn.hidden = NO;
            _workBtn.frame = CGRectMake(_titleView.frame.size.width/4*3+7,8, 50, 25 );
        }
    }
    if (SCREEN_HEIGHT == 736){
        if ([userInfoModel.iswork intValue]== 0){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-10, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2+50-10, 8, 50, 25);
            _workBtn.hidden = YES;
        }
        else if ([userInfoModel.iswork intValue]== 1){
            _customerBtn.frame = CGRectMake(_titleView.frame.size.width/4-35, 8, 50, 25);
            _brokerBtn.frame = CGRectMake(_titleView.frame.size.width/4*2-5, 8, 50, 25);
            _workBtn.hidden = NO;
            _workBtn.frame = CGRectMake(_titleView.frame.size.width/4*3+7,8, 50, 25 );
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PushNotifyName object:nil];
}

#pragma mark 选择雇主功能(切换功能)
- (void)customerBtnClick
{
    [_customerBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_brokerBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_customerBtn setBackgroundImage:[UIImage imageNamed:@"nav_btn_agent"] forState:UIControlStateNormal];
    [_brokerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    
    [_workBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_workBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    if (_type == UserType_Customer) {
        //当前为雇主时点击雇主不做处理
    }else{
        //显示雇主功能内容，隐藏经纪人功能内容
        [UIView animateWithDuration:0.3 animations:^{
            _cContentView.frame = self.view.frame;
            _bContentView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion: ^(BOOL finish){
            _type = UserType_Customer;
        }];
    }
}

#pragma mark 选择经纪人功能(切换功能)
- (void)brokerBtnClick
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        if (userInfoModel.isbroker == 0) {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"您还不是经纪人" message:@"赶紧去认证经纪人吧" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            alert.delegate=self;
            alert.tag=100;
            [alert show];
            return;
        }
    
        [_customerBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_brokerBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [_customerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_brokerBtn setBackgroundImage:[UIImage imageNamed:@"nav_btn_agent"] forState:UIControlStateNormal];
        
        [_workBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_workBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        if (_type == UserType_Broker) {
            //当前为经纪人时点击经纪人不做处理
        }else
        {
            //显示经纪人功能内容，隐藏雇主功能内容
            [UIView animateWithDuration:0.3 animations:^{
                _cContentView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                _bContentView.frame = self.view.frame;
                if (_brokerHomeVC.nowType == BFuncType_GetOrder) {
                     [_brokerHomeVC getWaitOrderlist];
                }
            } completion: ^(BOOL finish){
                _type = UserType_Broker;
            }];
        }
    }else{
    _alertGoLogin.tag = 200;
    [_alertGoLogin show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            [self goApplybroker];
        }
    }
    else if (alertView.tag==200 || alertView.tag==300 ){
        if (buttonIndex==1) {
            [self leftItemClick2];
        }
    }
    else if (alertView==alertV){
        if (buttonIndex==0){
            NSURL *url = [NSURL URLWithString:iosDownLoad];
            [[UIApplication sharedApplication] openURL:url];
        }
    }

}

//进入认证界面
-(void)goApplybroker{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    ApplyBrokerViewController *applyBrokerVC = [[ApplyBrokerViewController alloc] init];
    applyBrokerVC.isRootVC = YES;
    [app.menuViewController pushToNewViewController:applyBrokerVC animation:YES];

}

- (void)workBtnClick

{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    LogisticsHomePageViewController *logisticsVC = [[LogisticsHomePageViewController alloc] init];
    
    [delegate.menuViewController pushToNewViewController:logisticsVC animation:YES];
}

//导航栏左右侧按钮点击
- (void)leftItemClick1
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.menuViewController showLeftViewController];
    [delegate.personVC getPersonalInfo];
}

//进入登陆界面
- (void)leftItemClick2
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [delegate.menuViewController pushToNewViewController:loginVC animation:YES];
}

- (void)rightItemClick
{

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId && ![userInfoModel.userId isEqualToString:@""])
    {
        BrokerinstitutionViewController *institutionVC = [[BrokerinstitutionViewController alloc] init];
        institutionVC.type = 1;
        [delegate.menuViewController pushToNewViewController:institutionVC animation:YES];

    }else
    {
        _alertGoLogin.tag = 300;
        [_alertGoLogin show];
        [[iToast makeText:@"请登录!"] show];
        return;
    }

}

- (void)pushResult:(NSNotification *)notification{
    NSDictionary *object = notification.object;
    NSDictionary *aps = [object objectForKey:@"aps"];
    NSString *alertString = [aps objectForKey:@"alert"];
    [JKNotifier showNotifer:[NSString stringWithFormat:@"您有一条新消息:%@",alertString]];
    
    [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
        [notifier dismiss];
//        NSLog(@"AutoHidden JKNotifierBar clicked");
        
    }];
}
//#pragma mark ----------
//-(void)getAppStore{
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[communcation sharedInstance]getVerisonFromAppStoreWithResultDic:^(NSDictionary *dic) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                DLog(@"当前版本号%@",dic);
//                NSDictionary *data=[[dic objectForKey:@"results"] firstObject];
//                
//                ///AppStore最新的版本号
//                NSString *version=[data objectForKey:@"version"];
//#pragma  mark -  获取当前本地的版本号
//                NSDictionary *localDic =[[NSBundle mainBundle] infoDictionary];
//                NSString * localVersion =[localDic objectForKey:@"CFBundleShortVersionString"] ;
//                
//                if (![localVersion isEqualToString: version])//如果本地版本比较低 证明要更新版本
//                {
////                    self.view.userInteractionEnabled=NO;
////                  
////                    _customerHomeVC.view.userInteractionEnabled=NO;
////                    _brokerHomeVC.view.userInteractionEnabled=NO;
////                   _titleView.userInteractionEnabled=NO;
////                    _personVC.view.userInteractionEnabled=NO;
//                    iosDownLoad=[data objectForKey:@"trackViewUrl"];
//                    
//                    alertV=[[UIAlertView alloc]initWithTitle:@"有更新了" message:@"感谢认真工作的你" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新喽", nil];
//                    [alertV show];
//                }
//            });
//            
//        }];
//    });
//}
@end
