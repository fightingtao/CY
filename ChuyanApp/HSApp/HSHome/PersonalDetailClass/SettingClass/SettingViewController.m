//
//  SettingViewController.m
//  HSApp
//
//  Created by xc on 15/11/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "SettingViewController.h"

#import "PersonOtherInfoTableViewCell.h"
#import "AddressListViewController.h"
#import "WalletPasswordViewController.h"

@interface SettingViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *setTableView;
@property (nonatomic, strong) UISwitch *pushSwitch;
@property (nonatomic, strong) UIButton *logoutBtn;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        _titleLabel.text = @"设置";
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

    
    [self initpersonTableView];
    [self.view addSubview:_setTableView];
    
    
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.frame = CGRectMake(20,SCREEN_HEIGHT-50, SCREEN_WIDTH-40, 40);
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _logoutBtn.layer.borderWidth = 0.5;
        _logoutBtn.layer.cornerRadius = 5;
        [_logoutBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_logoutBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_logoutBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_logoutBtn];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_setTableView != nil) {
        return _setTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT-50;
    
    self.setTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _setTableView.delegate = self;
    _setTableView.dataSource = self;
    _setTableView.backgroundColor = ViewBgColor;
    _setTableView.showsVerticalScrollIndicator = NO;
    _setTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _setTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
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
    
    return 40;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"PersonOtherInfoTableViewCell";
    PersonOtherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[PersonOtherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (indexPath.row == 0) {
        cell.titleLable.text = @"抢单通知";
        cell.contentLable.hidden = YES;
        cell.arrowImg.hidden = YES;
        if (!_pushSwitch)
        {
            _pushSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 5, 50, 20)];
            [_pushSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:_pushSwitch];
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSData *userData = [userDefault objectForKey:UserKey];
            UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
            
            if ([userInfoModel.tag isEqualToString:@"broker"]) {
                [_pushSwitch setOn:YES animated:YES];
            }else
            {
                [_pushSwitch setOn:NO animated:YES];
            }
        }
        
    }else if (indexPath.row == 1)
    {
        cell.titleLable.text = @"常用地址";
        cell.contentLable.hidden = YES;
    }else
    {
        cell.titleLable.text = @"钱包密码";
        cell.contentLable.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        
    }else if (indexPath.row == 1)
    {
        AddressListViewController *addressListVC = [[AddressListViewController alloc] init];
        [self.navigationController pushViewController:addressListVC animated:YES];
    }else
    {
        WalletPasswordViewController *walletPwd = [[WalletPasswordViewController alloc] init];
        [self.navigationController pushViewController:walletPwd animated:YES];
    }
}


//用户是否接收推送
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSString *type;
    if (isButtonOn) {
        type = @"1";
    }else {
        type = @"2";
    }
    
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,type, nil];
    NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_AllSameModel *outModel = [[communcation sharedInstance] setPushNotificationWithKey:userInfoModel.key AndDigest:hmacString AndUserId:userInfoModel.userId AndType:type];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([type isEqualToString:@"2"]) {
                    [[iToast makeText:@"当前不可接收到可抢呼单通知!"] show];
                    NSSet *set = [[NSSet alloc] initWithObjects:@"", nil];
                    [APService setTags:set alias:userInfoModel.notifyid callbackSelector:nil object:nil];
                }else
                {
                    [[iToast makeText:@"当前可接收到可抢呼单通知!"] show];
                    NSSet *set = [[NSSet alloc] initWithObjects:@"broker", nil];
                    [APService setTags:set alias:userInfoModel.notifyid callbackSelector:nil object:nil];
                }
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


///退出账号
- (void)logoutClick
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认退出账号" message:@"退出账号后将不能接收到任何通知" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {

    }else
    {
        //清除用户信息
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        UserInfoSaveModel *userInfoModel = [[UserInfoSaveModel alloc] init];
        userInfoModel.userId = @"";
        userInfoModel.isFirst = @"1";
        NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:userInfoModel];
        [userDefault setObject:setData forKey:UserKey];
        //退出推送
        NSSet *set = [[NSSet alloc] initWithObjects:@"", nil];
        [APService setTags:set alias:@"" callbackSelector:nil object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ChengGong"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];

}

@end
