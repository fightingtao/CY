//
//  WithdrawBillsDetailViewController.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WithdrawBillsDetailViewController.h"
#import "WithdrawBillsTableViewCell.h"

@interface WithdrawBillsDetailViewController ()
{
    NSString *_lastDate;
    NSString *_lastorderid;
    NSMutableArray *_billsArray;
    int _type;
    double _availableAmount;
    double _historyAmount;
    
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *billsTableView;


@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;

@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) UIView *totalView;
@property (nonatomic, strong) UILabel *moneyTotalLabel;
@property (nonatomic, strong) UILabel *historyMoneyLabel;

@end

@implementation WithdrawBillsDetailViewController

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
        _titleLabel.text = @"明细";
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
    
    //头部功能初始化start
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headView];
    }
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"全部" forState:UIControlStateNormal];
        [_button1 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button1 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        _button1.frame = CGRectMake(0, 0, SCREEN_WIDTH/4, 40);
        _button1.titleLabel.font = LittleFont;
        _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button1.selected = YES;
        [_headView addSubview:_button1];
    }
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"代购" forState:UIControlStateNormal];
        [_button2 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button2 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        _button2.frame = CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 40);
        _button2.titleLabel.font = LittleFont;
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button2];
    }
    
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitle:@"小费" forState:UIControlStateNormal];
        [_button3 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button3 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button3 addTarget:self action:@selector(button3Click) forControlEvents:UIControlEventTouchUpInside];
        _button3.frame = CGRectMake(SCREEN_WIDTH/4*2, 0, SCREEN_WIDTH/4, 40);
        _button3.titleLabel.font = LittleFont;
        _button3.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button3];
    }
    
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setTitle:@"提现" forState:UIControlStateNormal];
        [_button4 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button4 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button4 addTarget:self action:@selector(button4Click) forControlEvents:UIControlEventTouchUpInside];
        _button4.frame = CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 40);
        _button4.titleLabel.font = LittleFont;
        _button4.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button4];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    //头部功能初始化end
    
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _tableHeadView.backgroundColor = ViewBgColor;
    }
    if (!_totalView) {
        _totalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _totalView.backgroundColor = WhiteBgColor;
        [_tableHeadView addSubview:_totalView];
    }
    
    if (!_moneyTotalLabel) {
        _moneyTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,120)];
        _moneyTotalLabel.textAlignment = NSTextAlignmentCenter;
        [_moneyTotalLabel setTextColor:[UIColor redColor]];
        [_moneyTotalLabel setFont:[UIFont systemFontOfSize:36.0]];
        _moneyTotalLabel.text = @"--";
        _moneyTotalLabel.adjustsFontSizeToFitWidth = YES;
        [_totalView addSubview:_moneyTotalLabel];
    }
    
    if (!_historyMoneyLabel) {
        _historyMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 30)];
        _historyMoneyLabel.textColor =  TextMainCOLOR;
        _historyMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _historyMoneyLabel.font = LittleFont;
        [_tableHeadView addSubview:_historyMoneyLabel];
    }
    
    _lastorderid = @"0";
    _lastDate = @"0";
    _billsArray = [[NSMutableArray alloc] init];
    
    if (_detailType == MoneyDetailType_All) {
        _button1.selected = YES;
        _button2.selected = NO;
        _button3.selected = NO;
        _button4.selected = NO;
        _type = 4;
    }else if (_detailType == MoneyDetailType_Buy)
    {
        _button1.selected = NO;
        _button2.selected = YES;
        _button3.selected = NO;
        _button4.selected = NO;
        _type = 1;
    }else if (_detailType == MoneyDetailType_Tips)
    {
        _button1.selected = NO;
        _button2.selected = NO;
        _button3.selected = YES;
        _button4.selected = NO;
        _type = 2;
    }else
    {
        _button1.selected = NO;
        _button2.selected = NO;
        _button3.selected = NO;
        _button4.selected = YES;
        _type = 3;
    }
    
    [self initpublishTableView];
    [self.view addSubview:_billsTableView];
    
    [self getBillsList];
    
    //添加刷新控件
    [self.billsTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.billsTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化table
-(UITableView *)initpublishTableView
{
    if (_billsTableView != nil) {
        return _billsTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104;
    
    self.billsTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _billsTableView.delegate = self;
    _billsTableView.dataSource = self;
    _billsTableView.backgroundColor = ViewBgColor;
    _billsTableView.showsVerticalScrollIndicator = NO;
    return _billsTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getBillsList
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%d",_type],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_BillsDetailModel *inModel = [[In_BillsDetailModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.user_id = userInfoModel.userId;
    inModel.lastDate = [_lastDate longLongValue];
    inModel.lastrowid = [_lastorderid longLongValue];
    inModel.type = _type;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_BillsDetailModel *outModel = [[communcation sharedInstance] getBillsDetailWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_billsTableView headerEndRefreshing];
            [_billsTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([_lastDate isEqualToString:@"0"]) {
                    [_billsArray removeAllObjects];
                    for (int i = 0; i < outModel.data.bills.count; i++) {
                        Out_BillsDetailBody *model = [outModel.data.bills objectAtIndex:i];
                        [_billsArray addObject:model];
                    }
                    
                    _availableAmount = outModel.data.availableAmount;
                    _historyAmount = outModel.data.historyAmount;
                    
                    _moneyTotalLabel.text = [NSString stringWithFormat:@"￥%0.2f",_availableAmount];
                    NSString *string = [NSString stringWithFormat:@"历史代购总额:￥%0.2f",_historyAmount];
                    NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc] initWithString:string];
                    [tipStr addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
                    [tipStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, string.length-7)];
                    _historyMoneyLabel.attributedText = tipStr;
                }else
                {
                    if (outModel.data.bills.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.bills.count; i++) {
                        Out_BillsDetailBody *model = [outModel.data.bills objectAtIndex:i];
                        [_billsArray addObject:model];
                    }
                }
                [_billsTableView reloadData];
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
    
    return [_billsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_detailType != MoneyDetailType_All)
    {
        return 150;
    }
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_detailType != MoneyDetailType_All) {
        return _tableHeadView;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"WithdrawBillsTableViewCell";
    WithdrawBillsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[WithdrawBillsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    Out_BillsDetailBody *model = [_billsArray objectAtIndex:indexPath.row];
    [cell setBillsWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




//全部
- (void)button1Click
{
    _button1.selected = YES;
    _button2.selected = NO;
    _button3.selected = NO;
    _button4.selected = NO;
    _detailType = MoneyDetailType_All;
    _type = 4;
    _lastorderid = @"0";
    _lastDate = @"0";
    [self getBillsList];
}

//代购
- (void)button2Click
{
    _button1.selected = NO;
    _button2.selected = YES;
    _button3.selected = NO;
    _button4.selected = NO;
    _detailType = MoneyDetailType_Buy;
     _type = 1;
    _lastorderid = @"0";
    _lastDate = @"0";
    [self getBillsList];
}

//小费
- (void)button3Click
{
    _button1.selected = NO;
    _button2.selected = NO;
    _button3.selected = YES;
    _button4.selected = NO;
    _detailType = MoneyDetailType_Tips;
     _type = 2;
    _lastorderid = @"0";
    _lastDate = @"0";
    [self getBillsList];
}

//提现
- (void)button4Click
{
    _button1.selected = NO;
    _button2.selected = NO;
    _button3.selected = NO;
    _button4.selected = YES;
    _detailType = MoneyDetailType_Withdraw;
    _type = 3;
    _lastorderid = @"0";
    _lastDate = @"0";
    [self getBillsList];
}


- (void)headerRereshing
{
    _lastorderid = @"0";
    _lastDate = @"0";
    [self getBillsList];
}


- (void)footerRereshing
{
    if (_billsArray.count == 0) {
        [[iToast makeText:@"暂无数据"] show];
        return;
    }
    Out_BillsDetailBody *model = [_billsArray objectAtIndex:_billsArray.count-1];
    _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
    _lastDate = [NSString stringWithFormat:@"%ld",model.trade_time];
    [self getBillsList];
}

//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
