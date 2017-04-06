//
//  MoneyListViewController.m
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MoneyListViewController.h"
#import "PersonOtherInfoTableViewCell.h"

#import "BalanceDetailViewController.h"
#import "ApplyBrokerViewController.h"
#import "RedPacketViewController.h"
#import "WithdrawCashViewController.h"

@interface MoneyListViewController ()<AlertShowDelegate>
{
    Out_MoneyBody *_moneyModel;

}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *walletTableView;
@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) HSAlertShowViewController *alertShowVC;

@end

@implementation MoneyListViewController

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
        _titleLabel.text = @"钱包";
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
    [self.view addSubview:_walletTableView];
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    if (!_alertShowVC) {
        _alertShowVC = [[HSAlertShowViewController alloc] init];
        _alertShowVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _alertShowVC.view.backgroundColor = WhiteBgColor;
        [_alertShowVC setDataWithTitle:@"去认证经纪人" andDetail:@"成为雏燕经纪人，即可赚钱提现啦~" andConfirmBtnTitle:@"是" andCancelBtnTitle:@"否"];
        _alertShowVC.delegate = self;
    }
    
    [self getWalletInfo];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_walletTableView != nil) {
        return _walletTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.walletTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _walletTableView.delegate = self;
    _walletTableView.dataSource = self;
    _walletTableView.backgroundColor = ViewBgColor;
    _walletTableView.showsVerticalScrollIndicator = NO;
    _walletTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _walletTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)getWalletInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *hmacString = [[communcation sharedInstance] hmac:userInfoModel.userId withKey:userInfoModel.primaryKey];
        Out_MoneyModel *outModel = [[communcation sharedInstance] getMoneyInfoWithKey:userInfoModel.userId AndDigest:hmacString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _moneyModel = outModel.data;
                [_walletTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
}

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
        cell.titleLable.text = @"余额";
        cell.contentLable.textColor = [UIColor redColor];
        if (_moneyModel) {
            cell.contentLable.text = [NSString stringWithFormat:@"%0.2f元",_moneyModel.recharge_amount];
        }else
        {
            cell.contentLable.text = @"--";
        }
        
    }else if (indexPath.row == 1)
    {
        cell.titleLable.text = @"红包";
        cell.contentLable.hidden = YES;
    }else
    {
        cell.titleLable.text = @"提现";
        cell.contentLable.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (indexPath.row == 0) {
        BalanceDetailViewController *balanceVC = [[BalanceDetailViewController alloc] init];
        [self.navigationController pushViewController:balanceVC animated:YES];
        
    }else if (indexPath.row == 1)
    {
        RedPacketViewController *redVC = [[RedPacketViewController alloc] init];
        redVC.type = 2;
        [self.navigationController pushViewController:redVC animated:YES];
    }else
    {
        if (userInfoModel.isbroker == 1)
        {
            WithdrawCashViewController *withdrawVC = [[WithdrawCashViewController alloc] init];
            [self.navigationController pushViewController:withdrawVC animated:YES];
        }else
        {
            if (userInfoModel.isauthen == 1) {
                [[iToast makeText:@"您已提交审核，请耐心等待!"] show];
                return;
            }

            if (userInfoModel.isauthen == 3) {
                [[iToast makeText:@"您的认证未通过审核！请重新提交资料认证！"] show];
            }
            [self.view addSubview:_maskView];
            [self.view addSubview:_alertShowVC.view];
            [UIView animateWithDuration:0.3 animations:^{
                _maskView.alpha = 0.7;
                _alertShowVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-170)/2, SCREEN_WIDTH-40, 170);
            } completion: ^(BOOL finish){
            }];
        }
        
    }
}

#pragma AlertShowDelegate 弹出提示框代理
- (void)confirmBtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0;
        _alertShowVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 170);
    } completion: ^(BOOL finish){
        [_maskView removeFromSuperview];
        [_alertShowVC.view removeFromSuperview];
        ApplyBrokerViewController *applyVC = [[ApplyBrokerViewController alloc] init];
        applyVC.isRootVC = NO;
        [self.navigationController pushViewController:applyVC animated:YES];
    }];
    
}

- (void)cancelBtnClick
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0;
        _alertShowVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 170);
    } completion: ^(BOOL finish){
        [_maskView removeFromSuperview];
        [_alertShowVC.view removeFromSuperview];
    }];
}


//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];

}

@end
