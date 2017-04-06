//
//  LNotificationViewController.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LNotificationViewController.h"

#import "LNotificationTableViewCell.h"
#import "LOrderDetailViewController.h"


@interface LNotificationViewController ()
{
    int _pageIndex;
    NSMutableArray *_totalOrderArray;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UITableView *msgTableview;

@end

@implementation LNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    
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
        _titleLabel.text = @"通知";
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
    
    _pageIndex = 0;
    _totalOrderArray = [[NSMutableArray alloc] init];
    
    
    [self inithomeTableView];
    [self.view addSubview:_msgTableview];
    
    //添加刷新控件
    [self.msgTableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.msgTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [self getMsgList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//初始化table
-(UITableView *)inithomeTableView
{
    if (_msgTableview != nil) {
        return _msgTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.msgTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _msgTableview.delegate = self;
    _msgTableview.dataSource = self;
    _msgTableview.backgroundColor = ViewBgColor;
    _msgTableview.showsVerticalScrollIndicator = NO;
    return _msgTableview;
}



- (void)getMsgList
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];

    NSArray *dataArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",_pageIndex],@"10", nil];
    
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    In_LNotificationModel *inModel = [[In_LNotificationModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.offset = _pageIndex;
    inModel.pagesize = 10;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LNotificationModel *outModel = [[communcation sharedInstance] getNotificationWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_msgTableview headerEndRefreshing];
            [_msgTableview footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {

                if (_pageIndex == 0) {
                    [_totalOrderArray removeAllObjects];
                    
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_LNotificationBody *model = [outModel.data objectAtIndex:i];
                        [_totalOrderArray addObject:model];
                    }
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"暂无通知！"] show];
                        return ;
                    }
                }else
                {
                    
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_LNotificationBody *model = [outModel.data objectAtIndex:i];
                        [_totalOrderArray addObject:model];
                    }
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"别拉了，都出来了！"] show];
                        return ;
                    }
                }
                [_msgTableview reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

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
    return [_totalOrderArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identCell = @"LNotificationTableViewCell";
    LNotificationTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
    
    if (cell == nil) {
        cell = [[LNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Out_LNotificationBody *model = [_totalOrderArray objectAtIndex:indexPath.section];
    [cell setDataWithModel:model];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOrderDetailViewController *orderDetailVC = [[LOrderDetailViewController alloc] init];
    
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    Out_LNotificationBody *model = [_totalOrderArray objectAtIndex:indexPath.section];
    orderDetailVC.orderId = model.cwb;
}



//顶部刷新和底部刷新
- (void)headerRereshing
{
    _pageIndex = 0;
    [self getMsgList];
}

- (void)footerRereshing
{
    
    _pageIndex = (int)_totalOrderArray.count;
    [self getMsgList];
}


//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
