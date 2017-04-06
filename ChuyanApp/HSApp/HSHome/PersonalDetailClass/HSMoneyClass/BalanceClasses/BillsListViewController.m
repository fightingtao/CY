//
//  BillsListViewController.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BillsListViewController.h"
#import "BillsDetailTableViewCell.h"

@interface BillsListViewController ()
{
    NSString *_lastDate;
    NSString *_lastorderid;
    NSMutableArray *_billsArray;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *billsTableView;

@end

@implementation BillsListViewController

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
        _titleLabel.text = @"账单";
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

    _lastorderid = @"0";
    _lastDate = @"0";
    _billsArray = [[NSMutableArray alloc] init];
    
    
    [self initpersonTableView];
    [self.view addSubview:_billsTableView];
    
    //添加刷新控件
    [self.billsTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.billsTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [self getBillsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_billsTableView != nil) {
        return _billsTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.billsTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _billsTableView.delegate = self;
    _billsTableView.dataSource = self;
    _billsTableView.backgroundColor = ViewBgColor;
    _billsTableView.showsVerticalScrollIndicator = NO;
    _billsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
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
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_BillsDetailModel *inModel = [[In_BillsDetailModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.user_id = userInfoModel.userId;
    inModel.lastDate = [_lastDate longLongValue];
    inModel.lastrowid = [_lastorderid longLongValue];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_PacketBillsModel *outModel = [[communcation sharedInstance] getPacketBillsWithModel:inModel];
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
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_PacketBillsBody *model = [outModel.data objectAtIndex:i];
                        [_billsArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_PacketBillsBody *model = [outModel.data objectAtIndex:i];
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

        return 60;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"BillsDetailTableViewCell";
    BillsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[BillsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    Out_PacketBillsBody *model = [_billsArray objectAtIndex:indexPath.row];
    [cell setBillsWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    Out_PacketBillsBody *model = [_billsArray objectAtIndex:_billsArray.count-1];
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
