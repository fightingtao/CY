//
//  LSendGoodsViewController.m
//  HSApp
//
//  Created by xc on 16/1/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LSendGoodsViewController.h"
#import "LGoodsListTableViewCell.h"
#import "LoginViewController.h"
#import "LOrderDetailViewController.h"
#import "ScanningViewController.h"
#import "MJRefresh.h"
#import "COrderPayTypeChooseViewController.h"//支付宝测试
#import "LOtherSignViewController.h"//他人签收界面测试
#import "TiaoMaPayVController.h"//当面付 测试

static int _KindType;

@interface LSendGoodsViewController ()<UISearchDisplayDelegate,ScannerSearchDelegate,LOrderListDelegate>
{
    NSMutableArray *_totalOrderArray;
    
    NSArray *_searchData;
    NSMutableArray *_filterData;
    UIButton *_searchBtn;
    int _btnMove;//扫码搜索按钮移动
    int _pageIndex;//分页大小
    int _type;//当前类型
    
    
    float lastContentOffset;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UITextField *searchText;

@property (nonatomic, strong) UITableView *goodsTableview;

///头部类型选择按钮view
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *sendIngBtn;
@property (nonatomic, strong) UIButton *alreadySendBtn;
@property (nonatomic, strong) UIButton *problemBtn;


@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIImageView *searchImgview;
@property (nonatomic, strong) UIButton *scannerBtn;


///搜索输入
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;

@end

@implementation LSendGoodsViewController
//-(void)viewdiAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    if (_goodsTableview) {
////
////        //添加刷新控件
//////        [self.goodsTableview addHeaderWithTarget:self action:@selector(headerRereshing)];
//////        [self.goodsTableview addFooterWithTarget:self action:@selector(footerRereshing)];
////        [self getOrderListWithType:1];
////    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    // Do any additional setup after loading the view.
    //    //改变订单数量的通知
    //
    //    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    //    [center addObserver:self selector:@selector(noticeDingDan:) name:@"dingdan" object:nil];
    //
    self.view.backgroundColor = WhiteBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 0, 150, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = MiddleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = @"送货";
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
    
    
    //加载头部选择功能
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headView];
    }
    
    if (!_sendIngBtn) {
        _sendIngBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendIngBtn setTitle:@"配送中(0)" forState:UIControlStateNormal];
        [_sendIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_sendIngBtn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_sendIngBtn addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        _sendIngBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 40);
        _sendIngBtn.titleLabel.font = LittleFont;
        _sendIngBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _sendIngBtn.selected = YES;
        [_headView addSubview:_sendIngBtn];
    }
    
    if (!_alreadySendBtn) {
        _alreadySendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alreadySendBtn setTitle:@"已签收(0)" forState:UIControlStateNormal];
        [_alreadySendBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_alreadySendBtn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_alreadySendBtn addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        _alreadySendBtn.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40);
        _alreadySendBtn.titleLabel.font = LittleFont;
        _alreadySendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_alreadySendBtn];
    }
    
    
    if (!_problemBtn) {
        _problemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_problemBtn setTitle:@"异常件(0)" forState:UIControlStateNormal];
        [_problemBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_problemBtn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_problemBtn addTarget:self action:@selector(button3Click) forControlEvents:UIControlEventTouchUpInside];
        _problemBtn.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 40);
        _problemBtn.titleLabel.font = LittleFont;
        _problemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_problemBtn];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    
    _totalOrderArray = [[NSMutableArray alloc] init];
    _filterData = [[NSMutableArray alloc] init];
    _searchData = [[NSMutableArray alloc] init];
    
    [self inithomeTableView];
    [self.view addSubview:_goodsTableview];
    
    //添加刷新控件
    [self.goodsTableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.goodsTableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    if (!_scannerBtn) {
        _scannerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scannerBtn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        _scannerBtn.frame = CGRectMake(SCREEN_WIDTH-70,94,50,50);
        [_scannerBtn setImage:[UIImage imageNamed:@"scanning"] forState:UIControlStateNormal];
        [_scannerBtn addTarget:self action:@selector(dragEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        _scannerBtn.layer.cornerRadius = 25;
        _scannerBtn.layer.borderColor = [UIColor clearColor].CGColor;
        _scannerBtn.layer.borderWidth = 0.5;
        [_scannerBtn addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
        [self.view addSubview:_scannerBtn];
        
        _btnMove = 0;
    }
    _pageIndex = 0;

    _KindType = 1;
    [UIView animateWithDuration:0.7 animations:^{
        _scannerBtn.frame = CGRectMake(SCREEN_WIDTH-70,SCREEN_HEIGHT-120,50,50);
        _pageIndex = 0;
        _type = 1;
//        [self getOrderListWithType:_type];//获取配送中列表
    } completion: ^(BOOL finish){
        
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark 搜索按钮被点击
-(void)onSearchbtnClick:(UIButton *)btn{
    if (btn.tag==10){
        _pageIndex=0;
        [self getOrderListWithType:_type];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_goodsTableview) {
        [self headerRereshing];
//        [self getOrderListWithType:_type];
    }
    if (!_searchView){
        _searchView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        UIColor *gra=[[UIColor grayColor]colorWithAlphaComponent:0.5];
        [_searchView setBackgroundColor:gra];
        _goodsTableview.tableHeaderView=_searchView;
        
    }
    if (!_searchBtn) {
        
        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(onSearchbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.tag=10;
        _searchBtn.frame=CGRectMake(SCREEN_WIDTH-60, 10, 40, 30);
        [_searchBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [_searchView addSubview:_searchBtn];
        
    }
    if (!_searchText){
        _searchText=[[UITextField alloc]initWithFrame:CGRectMake(30, 10, SCREEN_WIDTH-100, 30)];
        _searchText.layer.cornerRadius = 10.0;
        _searchText.backgroundColor=[UIColor whiteColor];
        _searchText.placeholder=@"   请输入订单号或地址";
        _searchText.clearsOnBeginEditing=YES;
        [_searchView addSubview:_searchText];
    }
}

//初始化table
-(UITableView *)inithomeTableView
{
    if (_goodsTableview != nil) {
        return _goodsTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104;
    
    self.goodsTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _goodsTableview.delegate = self;
    _goodsTableview.dataSource = self;
    _goodsTableview.backgroundColor = ViewBgColor;
    _goodsTableview.showsVerticalScrollIndicator = NO;
    _type = 1;

    return _goodsTableview;
}
#pragma mark 送货列表数据

- (void)getOrderListWithType:(int)type{
    //1 配送中 2 已签收  3 异常件
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取列表中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",_pageIndex],@"10",[NSString stringWithFormat:@"%d",type],[NSString stringWithFormat:@"%f",app.staticlng],[NSString stringWithFormat:@"%f",app.staticlat], _searchText.text,nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    In_DeliveringGoodsModel *inModel = [[In_DeliveringGoodsModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.offset = _pageIndex;
    inModel.pagesize = 10;
    inModel.deliverystate = type;
    inModel.lon = app.staticlng;
    inModel.lat = app.staticlat;
    inModel.searchstr=_searchText.text;
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//           [[communcation sharedInstance] sendGoodsListWithMsg:inModel resultDic:^(NSDictionary *dic) {
//               dispatch_async(dispatch_get_main_queue(), ^{
//                   
//                   [MBProgressHUD hideHUDForView:self.view animated:YES];
//                   [_goodsTableview headerEndRefreshing];
//                   [_goodsTableview footerEndRefreshing];
//                           Out_LDeliveringModel *outModel = [[Out_LDeliveringModel alloc] initWithDictionary:dic error:nil];
//                   if (!outModel)
//                   {
//                       [[iToast makeText:@"网络不给力,请稍后重试!"] show];
//                       
//                   }
//                   else if (outModel.code ==1000)
//                   {
//                       NSString *deliveryString = [NSString stringWithFormat:@"配送中(%d)",outModel.data.delivering];
//                       [_sendIngBtn setTitle:deliveryString forState:UIControlStateNormal];
//                       
//                       NSString *deliveryString2 = [NSString stringWithFormat:@"已签收(%d)",outModel.data.sign];
//                       [_alreadySendBtn setTitle:deliveryString2 forState:UIControlStateNormal];
//                       
//                       NSString *deliveryString3 = [NSString stringWithFormat:@"异常件(%d)",outModel.data.exception];
//                       [_problemBtn setTitle:deliveryString3 forState:UIControlStateNormal];
//                       
//                       if (_pageIndex == 0) {
//                           
//                           [_totalOrderArray removeAllObjects];
//                           if (outModel.data.order.count == 0) {
//                               [[iToast makeText:@"暂无订单！"] show];
//                               [_goodsTableview reloadData];
//                               return ;
//                           }
//                           
//                           for (int i = 0; i < outModel.data.order.count; i++) {
//                               Out_LOrderListBody *model = [outModel.data.order objectAtIndex:i];
//                               DLog(@"Model%@",model);
//                               [_totalOrderArray addObject:model];
//                           }
//                       }
//                       else
//                       {
//                           for (int i = 0; i < outModel.data.order.count; i++) {
//                               Out_LOrderListBody *model = [outModel.data.order objectAtIndex:i];
//                               [_totalOrderArray addObject:model];
//                           }
//                           if (outModel.data.order.count == 0) {
//                               [[iToast makeText:@"别拉了，都出来了！"] show];
//                               return ;
//                           }
//                           [_goodsTableview reloadData];
//                       }
//                       [_goodsTableview reloadData];
//                       
//                   }else{
//                       [[iToast makeText:outModel.message] show];
//                       if ([@"请登录" isEqualToString:outModel.message]){
//                           UIAlertView *alerltView1=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//                           alerltView1.tag=200;
//                           [alerltView1 show];
//                       }
//                       
//                   }
//               });
//               
//           }];
//
//            
//        });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LDeliveringModel *outModel = [[communcation sharedInstance] getDeliveringOrderWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_goodsTableview headerEndRefreshing];
            [_goodsTableview footerEndRefreshing];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }
            else if (outModel.code ==1000)
            {
                DLog(@"列表数据%@",outModel);
                NSString *deliveryString = [NSString stringWithFormat:@"配送中(%d)",outModel.data.delivering];
                [_sendIngBtn setTitle:deliveryString forState:UIControlStateNormal];
                
                NSString *deliveryString2 = [NSString stringWithFormat:@"已签收(%d)",[outModel.data.sign intValue]];
                [_alreadySendBtn setTitle:deliveryString2 forState:UIControlStateNormal];
                
                NSString *deliveryString3 = [NSString stringWithFormat:@"异常件(%d)",outModel.data.exception];
                [_problemBtn setTitle:deliveryString3 forState:UIControlStateNormal];
                
                if (_pageIndex == 0) {
                    
                    [_totalOrderArray removeAllObjects];
                    if (outModel.data.order.count == 0) {
                        [[iToast makeText:@"暂无订单！"] show];
                        [_goodsTableview reloadData];
                        return ;
                    }
                    
                    for (int i = 0; i < outModel.data.order.count; i++) {
                        Out_LOrderListBody *model = [outModel.data.order objectAtIndex:i];
                        DLog(@"Model%@",model);
                        [_totalOrderArray addObject:model];
                    }
                }
                else
                {
                    for (int i = 0; i < outModel.data.order.count; i++) {
                        Out_LOrderListBody *model = [outModel.data.order objectAtIndex:i];
                        [_totalOrderArray addObject:model];
                    }
                    if (outModel.data.order.count == 0) {
                        [[iToast makeText:@"别拉了，都出来了！"] show];
                        return ;
                    }
//                    [_goodsTableview reloadData];
                }
                [_goodsTableview reloadData];
                
            }else{
                [[iToast makeText:outModel.message] show];
                if ([@"请登录" isEqualToString:outModel.message]){
                    UIAlertView *alerltView1=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                    alerltView1.tag=200;
                    [alerltView1 show];
                }
                
            }
        });
        
    });
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _goodsTableview) {
        return _totalOrderArray.count;

    }
    else
    { // 谓词搜索天
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"cwb contains [cd] %@",_searchDisplayController.searchBar.text];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"dssnname contains [cd] %@",_searchDisplayController.searchBar.text];
        NSArray *array=[[NSArray alloc]initWithArray:[_totalOrderArray filteredArrayUsingPredicate:predicate1]];
        
        NSArray *array2=[[NSArray alloc]initWithArray:[_totalOrderArray filteredArrayUsingPredicate:predicate2]];
        
        NSMutableArray *arra=[[NSMutableArray alloc]initWithArray:array];
        [arra addObjectsFromArray:array2];
        _searchData = [[NSArray alloc]initWithArray:arra];
        return _searchData.count;
    }
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Out_LOrderListBody *model = [_totalOrderArray objectAtIndex:indexPath.section];
    LGoodsListTableViewCell *cell = [[LGoodsListTableViewCell alloc]init];
    return [cell CellHeightWithModel:model];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identCell = @"LGoodsListTableViewCell";
    LGoodsListTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
    
    if (cell == nil) {
        cell = [[LGoodsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == _goodsTableview) {
        Out_LOrderListBody *model = [_totalOrderArray objectAtIndex:indexPath.section];
        cell.KindType = _KindType;
        [cell setModel:model];
    }else
    {
        Out_LOrderListBody *model = [_searchData objectAtIndex:indexPath.section];
        [cell setModel:model];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationController.navigationBar.hidden  = NO;

    
//    TiaoMaPayVController * orderDetailVC = [[TiaoMaPayVController alloc] init];
//        [self.navigationController pushViewController:orderDetailVC animated:YES];


    _headView.hidden = NO;
    _goodsTableview.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    
    LOrderDetailViewController *orderDetailVC = [[LOrderDetailViewController alloc] init];
    orderDetailVC.KindType = _KindType;
    
    if (tableView == _goodsTableview) {
        Out_LOrderListBody *model = [_totalOrderArray objectAtIndex:indexPath.section];
        orderDetailVC.orderId = model.cwb;
    }else
    {
        Out_LOrderListBody *model = [_searchData objectAtIndex:indexPath.section];
        orderDetailVC.orderId = model.cwb;
    }
    [self.navigationController pushViewController:orderDetailVC animated:YES];

}

#pragma LOrderListDelegate 拨打电话代理实现
- (void)callPhoneWithModel:(Out_LOrderListBody*)model
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.consigneemobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)button1Click
{
//        [_totalOrderArray removeAllObjects];
    
    _pageIndex = 0;
    _type = 1;
    _KindType = 1;
    
    [self getOrderListWithType:_type];
    _sendIngBtn.selected = YES;
    _alreadySendBtn.selected = NO;
    _problemBtn.selected = NO;
}

#pragma mark 已签收 点击
- (void)button2Click
{
//        [_totalOrderArray removeAllObjects];
    
    _pageIndex = 0;
    _type = 2;
    _KindType = 2;
    [self getOrderListWithType:_type];
    _sendIngBtn.selected = NO;;
    _alreadySendBtn.selected = YES;
    _problemBtn.selected = NO;
}
#pragma mark 异常件 点击
- (void)button3Click
{
//        [_totalOrderArray removeAllObjects];
    
    _pageIndex = 0;
    _type = 3;
    _KindType = 3;
    [self getOrderListWithType:_type];
    _sendIngBtn.selected = NO;;
    _alreadySendBtn.selected = NO;;
    _problemBtn.selected = YES;
}


//点击扫码搜索
- (void) dragEnded: (UIControl *) c withEvent:ev
{
    if (_btnMove == 0) {
        self.navigationController.navigationBar.hidden  = NO;
        _headView.hidden = NO;
        _goodsTableview.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        
        ScanningViewController *scannerVC = [[ScanningViewController alloc] init];
        scannerVC.delegate = self;
        [self.navigationController pushViewController:scannerVC animated:YES];
    }
    _btnMove = 0;
    
    
    
}

#pragma ScannerSearchDelegate 扫码搜索代理实现

- (void)scannerSearchWithResult:(NSString *)result
{
    self.navigationController.navigationBar.hidden  = NO;
    _headView.hidden = NO;
    _goodsTableview.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    
//    LOrderDetailViewController *orderDetailVC = [[LOrderDetailViewController alloc] init];
//    orderDetailVC.KindType = _KindType;
//    
//    [self.navigationController pushViewController:orderDetailVC animated:YES];
//
//        orderDetailVC.orderId = result;


    _searchDisplayController.active = YES;
    _searchText.text = result;
    [self getOrderListWithType:_type];
    [_searchDisplayController.searchBar becomeFirstResponder];
}

//顶部刷新和底部刷新
- (void)headerRereshing
{
//        [_totalOrderArray removeAllObjects];
    
//    _pageIndex = 0;
    [self getOrderListWithType:_type];
}

- (void)footerRereshing
{
    
    _pageIndex = (int)_totalOrderArray.count;
    //_pageIndex = _pageIndex +4;
    [self getOrderListWithType:_type];
}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) dragMoving: (UIButton *)btn withEvent:(UIEvent *)event

{
    _btnMove = 1;
    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    
    CGFloat x = point.x;
    
    CGFloat y = point.y;
    CGFloat btnx = btn.frame.size.width/2;
    
    CGFloat btny = btn.frame.size.height/2;
    
    
    
    if(x<=btnx)
        
    {
        
        point.x = btnx;
        
    }

    if(x >= self.view.bounds.size.width - btnx)
        
    {
        
        point.x = self.view.bounds.size.width - btnx;
        
    }
    
    if(y<=btny)
        
    {
        
        point.y = btny;
        
    }
    
    if(y >= self.view.bounds.size.height - btny)
        
    {
        
        point.y = self.view.bounds.size.height - btny;
        
    }
    
    if (y <= 64) {
        point.y = 94;
    }
        DLog(@"fs:%f %f",x, btnx);
    
    btn.center = point;
    
    //    DLog(@"%f,,,%f",btn.center.x,btn.center.y);
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    DLog(@"ddddddd");
    lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (lastContentOffset < scrollView.contentOffset.y) {
                DLog(@"向上滚动");
        _headView.hidden = YES;
        self.navigationController.navigationBar.hidden  = YES;
        _goodsTableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }else{
                DLog(@"向下滚动");
        self.navigationController.navigationBar.hidden  = NO;
        _headView.hidden = NO;
        _goodsTableview.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==200) {
        if (buttonIndex==1) {
            LoginViewController *login=[[LoginViewController alloc]init];
            [self .navigationController pushViewController:login animated:YES];
        }
    }
}
//-(void)noticeDingDan:(NSNotification *)tongzhi{
//     DLog(@"%@",tongzhi.userInfo[@"1"]);
////    DLog( @"tongzhi通知改变了%@",tongzhi.userInfoModel);
//}
@end
