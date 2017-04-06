//
//  WithdrawCashViewController.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WithdrawCashViewController.h"
#import "WithdrawCashTableViewCell.h"
#import "PersonOtherInfoTableViewCell.h"
#import "WithdrawBillsDetailViewController.h"

#import "WithdrawCashDetailViewController.h"
#import "BindingAccountViewController.h"

@interface WithdrawCashViewController ()<MoneyDetailDelegate>
{
    Out_MoneyBody *_moneyModel;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *cashTableView;

@end

@implementation WithdrawCashViewController

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
        _titleLabel.text = @"提现";
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
    
    //生成顶部右侧按钮
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"明细" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    [self initpersonTableView];
    [self.view addSubview:_cashTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self getWalletInfo];
}


//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_cashTableView != nil) {
        return _cashTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.cashTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _cashTableView.delegate = self;
    _cashTableView.dataSource = self;
    _cashTableView.backgroundColor = ViewBgColor;
    _cashTableView.showsVerticalScrollIndicator = NO;
    _cashTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _cashTableView;
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
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    mbp.labelText = @"加载中";
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
                [_cashTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
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
    if (indexPath.section == 0) {
        return [WithdrawCashTableViewCell cellHeight];
    }else
    {
        return 40;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellName = @"WithdrawCashTableViewCell";
        WithdrawCashTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[WithdrawCashTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        [cell setCashWithModel:_moneyModel];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        if (indexPath.row == 0)
        {
            static NSString *cellName = @"PersonOtherInfoTableViewCell";
            PersonOtherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[PersonOtherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"申请提现";
            cell.contentLable.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellName = @"PersonOtherInfoTableViewCell";
            PersonOtherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[PersonOtherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"绑定支付宝";
            cell.contentLable.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (indexPath.section == 0) {
        
    }else
    {
        if (indexPath.row == 0) {
            if (userInfoModel.isBindWithdrawAccount==0)
            {
                [[iToast makeText:@"请先绑定支付宝"] show];
                return;
            }
            WithdrawCashDetailViewController *withdrawDetailVC = [[WithdrawCashDetailViewController alloc] init];
            withdrawDetailVC.enableMoney = _moneyModel.withdrawAmount;
            [self.navigationController pushViewController:withdrawDetailVC animated:YES];
        }else
        {
            BindingAccountViewController *bindingVC = [[BindingAccountViewController alloc] init];
            [self.navigationController pushViewController:bindingVC animated:YES];
        }
    }
}


#pragma MoneyDetailDelegate 金额详细代理
- (void)showBuyDetail
{
    WithdrawBillsDetailViewController *billsVC = [[WithdrawBillsDetailViewController alloc] init];
    billsVC.detailType = MoneyDetailType_Buy;
    [self.navigationController pushViewController:billsVC animated:YES];
}
- (void)showTipsDetail
{
    WithdrawBillsDetailViewController *billsVC = [[WithdrawBillsDetailViewController alloc] init];
    billsVC.detailType = MoneyDetailType_Tips;
    [self.navigationController pushViewController:billsVC animated:YES];
}
- (void)showWithdrawDetail
{
    WithdrawBillsDetailViewController *billsVC = [[WithdrawBillsDetailViewController alloc] init];
    billsVC.detailType = MoneyDetailType_Withdraw;
    [self.navigationController pushViewController:billsVC animated:YES];
}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


//导航栏左右侧按钮点击

- (void)rightItemClick
{
    WithdrawBillsDetailViewController *billsVC = [[WithdrawBillsDetailViewController alloc] init];
    billsVC.detailType = MoneyDetailType_All;
    [self.navigationController pushViewController:billsVC animated:YES];
}

@end
