//
//  BrokerHomeViewController.m
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BrokerHomeViewController.h"
#import "LoginViewController.h"

#import "BHomeOrderTableViewCell.h"
#import "BHomeOrderIngTableViewCell.h"
#import "CHomeCommentTableViewCell.h"
#import "COrderDynamicViewController.h"

#import "bOrderDetailViewController.h"

#import "CustomerCommentViewController.h"

#import "CustomerInfoViewController.h"

@interface BrokerHomeViewController ()<BrokerHeadDelegate,BHomeOrderDelegate,BHomeOrderIngCellDelegate,CommentSuccessDelegate>
{
    NSString *_cityName;
    NSString *_lastDate;
    NSString *_lastorderid;
    ///抢单类型
    int _type;
    
    ///数据内容
    NSMutableArray *_orderListArray;
    
    ///呼单中类型
    int _orderIngType;
    
    ///评论类型
    int _commentType;
}

@property (nonatomic, strong) BrokerHeadView *bHeadView;
@property (nonatomic, strong) UITableView *homeTableView;

@property (strong, nonatomic)   AVAudioPlayer    *player;


@end

@implementation BrokerHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    
    //默认获取抢单列表
    _nowType = BFuncType_GetOrder;
    
    [self initbheadView];
    [self.view addSubview:_bHeadView];
    
    [self inithomeTableView];
    [self.view addSubview:_homeTableView];
    
    //添加刷新控件
    [self.homeTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.homeTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
    //初始化列表获取数据
    _orderListArray = [[NSMutableArray alloc] init];
    _cityName = @"南京市";
    _lastDate = @"0";
    _lastorderid = @"0";
    _type = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化table
-(UITableView *)inithomeTableView
{
    if (_homeTableView != nil) {
        return _homeTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104;
    
    self.homeTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.backgroundColor = ViewBgColor;
    self.automaticallyAdjustsScrollViewInsets = false;
    _homeTableView.showsVerticalScrollIndicator = NO;
    _homeTableView.scrollsToTop = YES;
    return _homeTableView;
}

//初始化雇主headview
- (UIView *)initbheadView
{
    if (_bHeadView != nil) {
        return _bHeadView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 64.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = 40;
    _bHeadView.backgroundColor = WhiteBgColor;
    _bHeadView = [[BrokerHeadView alloc] initWithFrame:rect];
    _bHeadView.delegate = self;
    return _bHeadView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

///获取待接单列表
- (void)getWaitOrderlist
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"正在获取可抢呼单...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:_cityName,[NSString stringWithFormat:@"%d",_type],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_WaitOrderListModel *inModel = [[In_WaitOrderListModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.cityname = _cityName;
    inModel.type = _type;
    inModel.lastDate = _lastDate;
    inModel.lastorderid = _lastorderid;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        Out_WaitOrderListModel *outModel = [[communcation sharedInstance] getWaitOrderListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_homeTableView headerEndRefreshing];
            [_homeTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([_lastDate isEqualToString:@"0"]) {
                    [_orderListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        OutHomeListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"暂无可抢呼单!"] show];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        OutHomeListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }
                [_homeTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles: nil];
                alert.tag=200;
                [alert show];
            }
        });
        
    });

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==200) {
        if (buttonIndex==0) {
            LoginViewController *goLogin=[[LoginViewController alloc ]init];
            AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;

            [app.menuViewController pushToNewViewController:goLogin animation:YES];
        }
    }
}
///获取呼单中列表
- (void)getOrderIngList
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,@"1",[NSString stringWithFormat:@"%d",_orderIngType],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中";
    
    In_OrderIngListModel *inModel = [[In_OrderIngListModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.userId = userInfoModel.userId;
    inModel.usertype = @"1";
    inModel.type = [NSString stringWithFormat:@"%d",_orderIngType];
    inModel.lastDate = _lastDate;
    inModel.lastorderid = _lastorderid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderIngListModel *outModel = [[communcation sharedInstance] getOrderIngListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_homeTableView headerEndRefreshing];
            [_homeTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([_lastDate isEqualToString:@"0"]) {
                    [_orderListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }
                [_homeTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
}


///获取评论列表
- (void)getCommentList
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%d",_commentType],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中";
    In_CommentListModel *inModel = [[In_CommentListModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.user_id = userInfoModel.userId;
    inModel.type = _commentType;
    inModel.lastDate = [_lastDate longLongValue];
    inModel.lastrowid = [_lastorderid longLongValue];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CommentListModel *outModel = [[communcation sharedInstance] getCommentListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_homeTableView headerEndRefreshing];
            [_homeTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([_lastDate isEqualToString:@"0"]) {
                    [_orderListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }
                [_homeTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
}



#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_nowType) {
        case BFuncType_GetOrder:
        {
            return [_orderListArray count];
        }
        case BFuncType_OrderIng:
        {
            return [_orderListArray count];
        }
        case BFuncType_Comment:
        {
            return [_orderListArray count];
        }
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_nowType == BFuncType_GetOrder) {
        
        return 10.0;
        
    }else if (_nowType == BFuncType_OrderIng)
    {
        return 0.01;
    }else{
        return 0.01;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nowType == BFuncType_GetOrder) {
        OutWaitOrderListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        return [BHomeOrderTableViewCell cellHeightWithModel:model];
        
    }else if (_nowType == BFuncType_OrderIng)
    {
        Out_OrderIngListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        return [BHomeOrderIngTableViewCell cellHeightWithModel:model];
    }else{
        return [CHomeCommentTableViewCell cellHeightWithModel:@""];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nowType == BFuncType_GetOrder) {
        static NSString *identCell = @"BHomeOrderTableViewCell";
        BHomeOrderTableViewCell *cell = [[BHomeOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        OutWaitOrderListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        [cell setOrderContentWithModel:model];
        return cell;

    }else if (_nowType == BFuncType_OrderIng)
    {

        static NSString *identCell = @"BHomeOrderIngTableViewCell";
        BHomeOrderIngTableViewCell *cell = [[BHomeOrderIngTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        Out_OrderIngListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        [cell setOrderContentWithModel:model];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *cellName = @"CHomeCommentTableViewCell";
        CHomeCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[CHomeCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        Out_CommentListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        [cell setOrderContentWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (_nowType == BFuncType_GetOrder)
    {
        OutHomeListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        COrderDynamicViewController *orderDynamicVC = [[COrderDynamicViewController alloc] init];
        orderDynamicVC.orderId = model.orderId;
        orderDynamicVC.isGetOrder = YES;
        [app.menuViewController pushToNewViewController:orderDynamicVC animation:YES];
        
        
    }else if (_nowType == BFuncType_OrderIng)
    {
        Out_OrderIngListBody *model = [_orderListArray objectAtIndex:indexPath.section];
        bOrderDetailViewController *bOrderDetailVC = [[bOrderDetailViewController alloc] init];
        [app.menuViewController pushToNewViewController:bOrderDetailVC animation:YES];
        //判断状态和传入orderid
        if (model.statusId >= 3)
        {
            bOrderDetailVC.nowStatus = OrderStatus_YJD;
        }else
        {
            bOrderDetailVC.nowStatus = OrderStatus_WJD;
        }
        bOrderDetailVC.orderId = model.orderId;
        [bOrderDetailVC getOrderDetail];
    }else
    {
        
        
    }
}


#pragma BrokerHeadDelegate 经纪人头部选择代理

- (void)headOrderListClick
{
    if (_nowType == BFuncType_GetOrder) {
        [UIView animateWithDuration:0.3 animations:^{
            _bHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
            _homeTableView.frame = CGRectMake(0, 144, SCREEN_WIDTH, SCREEN_HEIGHT-144);
            _bHeadView.line.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
        } completion: ^(BOOL finish){
            _nowType = BFuncType_GetOrder;
//            [_homeTableView reloadData];
        }];
    }else
    {
        [_orderListArray removeAllObjects];
        [_homeTableView reloadData];
        _bHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
        _homeTableView.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _bHeadView.line.frame = CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5);
        _nowType = BFuncType_GetOrder;
        _lastDate = @"0";
        _lastorderid = @"0";
        _type = 0;
        [self getWaitOrderlist];
    }

}

- (void)headOrderWorkClick
{
    if (_nowType == BFuncType_OrderIng) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _bHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
        _homeTableView.frame = CGRectMake(0, 144, SCREEN_WIDTH, SCREEN_HEIGHT-144);
        _bHeadView.line.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
        _homeTableView.tableHeaderView=nil;
    } completion: ^(BOOL finish){
        _nowType = BFuncType_OrderIng;
        _lastDate = @"0";
        _lastorderid = @"0";
        _orderIngType = 1;
        [self getOrderIngList];
    }];

}

- (void)headOrderCommentClick
{
    if (_nowType == BFuncType_Comment) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _bHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
        _homeTableView.frame = CGRectMake(0, 144, SCREEN_WIDTH, SCREEN_HEIGHT-144);
        _bHeadView.line.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
    } completion: ^(BOOL finish){
        _nowType = BFuncType_Comment;
        //初始化
        _lastDate = @"0";
        _lastorderid = @"0";
        _commentType = 3;
         [self getCommentList];
    }];

}

- (void)bDetailFuncClick:(BDetailFuncType)temptype
{
    switch (temptype) {
        case BDetailFuncType_GetAll://子菜单功能类型-全部订单
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _type = 0;
            [self getWaitOrderlist];
            return;
        }
        case BDetailFuncType_GetDG://子菜单功能类型-代购订单
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _type = 2;
            [self getWaitOrderlist];
            return;
        }
        case BDetailFuncType_GetDB://子菜单功能类型-代办订单
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _type = 1;
            [self getWaitOrderlist];
            return;
        }
        case BDetailFuncType_GetDS://子菜单功能类型-代送订单
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _type = 3;
            [self getWaitOrderlist];
            return;
        }
        case BDetailFuncType_OrderIng://子菜单功能类型-任务中
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _orderIngType = 1;
            [self getOrderIngList];
            return;
        }
        case BDetailFuncType_History://子菜单功能类型-历史
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _orderIngType = 2;
            [self getOrderIngList];
            return;
        }
        case BDetailFuncType_ToCustomerComment://子菜单功能类型-对用户评价
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _commentType = 3;
            [self getCommentList];
            return;
        }
        case BDetailFuncType_ToUserComment://子菜单功能类型-对我评价
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _commentType = 4;
            [self getCommentList];
            return;
        }
        default:
            return;
    }

}
//------------------------------------------------------------------
#pragma BHomeOrderDelegate 经纪人抢单代理
///抢单
- (void)getOrderDelegateWithModel:(OutWaitOrderListBody *)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"正在抢单...";
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%f",app.staticlat],[NSString stringWithFormat:@"%f",app.staticlng],model.orderId, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_GetOrderModel *inModel = [[In_GetOrderModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.userId = userInfoModel.userId;
    inModel.orderid = model.orderId;
    inModel.lat = [NSString stringWithFormat:@"%f",app.staticlat];
    inModel.lng = [NSString stringWithFormat:@"%f",app.staticlng];
   
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_GetOrderModel *outModel = [[communcation sharedInstance] getOrderWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_homeTableView headerEndRefreshing];
            [_homeTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"抢单成功，请耐心等待雇主确认!"] show];
                [self headerRereshing];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

///展示订单图片
- (void)showOrderImgWithModel:(OutWaitOrderListBody*)model AndIndex:(int)index
{
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:model.picpaths AndType:0];
    ib.currentIndex = index;
    [ib show];
}

///播放语音内容
- (void)playOrderVoiceWithModel:(OutWaitOrderListBody*)model
{
    NSURL *url=[NSURL URLWithString:model.voicePath];
    NSData *audioData = [NSData dataWithContentsOfURL:url];
    
    //根据当前时间生成文件名
    NSString *tempFileName = [self GetCurrentTimeString];
    //获取路径
    NSString *tempRecordFilePath = [self GetPathByFileName:tempFileName ofType:@"amr"];
    [audioData writeToFile:tempRecordFilePath atomically:YES];
    NSString *convertedPath = [self GetPathByFileName:[tempFileName stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
    if ([VoiceConverter ConvertAmrToWav:tempRecordFilePath wavSavePath:convertedPath]==1) {
        self.player = [[AVAudioPlayer alloc]init];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        self.player = [self.player initWithContentsOfURL:[NSURL URLWithString:convertedPath] error:nil];
        [self.player play];
    }else
        [[iToast makeText:@"改语音不能识别并播放!"] show];
}

///抢单列表点击头像代理实现
- (void)headImgClickWithModel:(OutWaitOrderListBody*)model
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CustomerInfoViewController *customerInfoVC = [[CustomerInfoViewController alloc] init];
    customerInfoVC.userId = model.userId;
    customerInfoVC.commentType = 2;
    [app.menuViewController pushToNewViewController:customerInfoVC animation:YES];
}
//------------------------------------------------------------------


#pragma BHomeOrderIngCellDelegate 经纪人呼单代理
///展示订单图片
- (void)orderIngshowOrderImgWithModel:(Out_OrderIngListBody*)model AndIndex:(int)index
{
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:model.picpaths AndType:0];
    ib.currentIndex = index;
    [ib show];
}
///播放语音内容
- (void)orderIngplayOrderVoiceWithModel:(Out_OrderIngListBody*)model
{
    NSURL *url=[NSURL URLWithString:model.voicePath];
    NSData *audioData = [NSData dataWithContentsOfURL:url];
    
    //根据当前时间生成文件名
    NSString *tempFileName = [self GetCurrentTimeString];
    //获取路径
    NSString *tempRecordFilePath = [self GetPathByFileName:tempFileName ofType:@"amr"];
    [audioData writeToFile:tempRecordFilePath atomically:YES];
    NSString *convertedPath = [self GetPathByFileName:[tempFileName stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
    if ([VoiceConverter ConvertAmrToWav:tempRecordFilePath wavSavePath:convertedPath]==1) {
        self.player = [[AVAudioPlayer alloc]init];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        self.player = [self.player initWithContentsOfURL:[NSURL URLWithString:convertedPath] error:nil];
        [self.player play];
    }else
        [[iToast makeText:@"改语音不能识别并播放1"] show];
}

///拨打雇主电话
- (void)OrderIngCallCustomerWithModel:(Out_OrderIngListBody*)model
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.uTelephone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


///确认购买
- (void)orderIngConfirmOrderWithModel:(Out_OrderIngListBody*)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"确认中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    //呼单类型，1：代办，2：代购，3：代送
    if (model.orderTypeId == 1) {
        NSString *hamcString = [[communcation sharedInstance] hmac:model.orderId withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] brokerConfirmDBOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:model.orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"订单完成，等待雇主支付!"] show];
                    [self headerRereshing];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });

    }else if (model.orderTypeId == 2)
    {
         AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        bOrderDetailViewController *bOrderDetailVC = [[bOrderDetailViewController alloc] init];
        [app.menuViewController pushToNewViewController:bOrderDetailVC animation:YES];
        //判断状态和传入orderid
        if (model.statusId >= 3)
        {
            bOrderDetailVC.nowStatus = OrderStatus_YJD;
        }else
        {
            bOrderDetailVC.nowStatus = OrderStatus_WJD;
        }
        bOrderDetailVC.orderId = model.orderId;
        [bOrderDetailVC getOrderDetail];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }else
    {
        NSString *hamcString = [[communcation sharedInstance] hmac:model.orderId withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] brokerConfirmDSOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:model.orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"订单完成，等待雇主支付!"] show];
                    [self headerRereshing];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });

    }

}


///评价雇主
- (void)orderIngCommentCustomerWithModel:(Out_OrderIngListBody*)model
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CustomerCommentViewController *commentVC = [[CustomerCommentViewController alloc] init];
    commentVC.type = @"0";
    commentVC.orderId = model.orderId;
    [app.menuViewController pushToNewViewController:commentVC animation:YES];
    commentVC.delegate = self;
}

#pragma CommentSuccessDelegate 评论成功刷新
- (void)commentSuccessBackRefresh
{
    [self headerRereshing];
}

///点击头像
- (void)orderIngHeaderClickWithModel:(Out_OrderIngListBody*)model
{
//    [self.delegate orderIngHeaderClickWithModel:_tempOrderModel];
//    CustomerInfoViewController *customerInfoVC = [[CustomerInfoViewController alloc] init];
//    customerInfoVC.userId = model.userId;
////    customerInfoVC.commentType = 2;
//    [[self delegate].menuViewController pushToNewViewController:customerInfoVC animation:YES];
    
}

//------------------------------------------------------------------
//顶部刷新和底部刷新
- (void)headerRereshing
{
    switch (_nowType) {
        case BFuncType_GetOrder:
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            [self getWaitOrderlist];
            return;
        }
        case BFuncType_OrderIng:
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            [self getOrderIngList];
            return;
        }
        case BFuncType_Comment:
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            [self getCommentList];
            return;
        }
        default:
            return;
    }
    
}

- (void)footerRereshing
{
    switch (_nowType) {
        case BFuncType_GetOrder:
        {
            if ([_orderListArray count] != 0) {
                OutWaitOrderListBody *model = [_orderListArray objectAtIndex:[_orderListArray count]-1];
                _lastDate = [NSString stringWithFormat:@"%@",model.createTime];
                _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
                [self getWaitOrderlist];
            }else
            {
                [[iToast makeText:@"暂无数据"] show];
                [_homeTableView footerEndRefreshing];
            }

            return;
        }
        case BFuncType_OrderIng:
        {
            if ([_orderListArray count] != 0) {
                Out_OrderIngListBody *model = [_orderListArray objectAtIndex:[_orderListArray count]-1];
                _lastDate = [NSString stringWithFormat:@"%@",model.createTime];
                _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
                [self getOrderIngList];
            }else
            {
                [[iToast makeText:@"暂无数据"] show];
                [_homeTableView footerEndRefreshing];
            }

            return;
        }
        case BFuncType_Comment:
        {
            if ([_orderListArray count] != 0) {
                Out_CommentListBody *model = [_orderListArray objectAtIndex:[_orderListArray count]-1];
                _lastDate = [NSString stringWithFormat:@"%ld",model.create_date];
                _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
                [self getCommentList];
            }else
            {
                [[iToast makeText:@"暂无数据"] show];
                [_homeTableView footerEndRefreshing];
            }
            return;
        }
        default:
            return ;
    }
    
}

#pragma mark - 生成当前时间字符串
- (NSString*)GetCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

#pragma mark - 生成文件路径
- (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_1type{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:_fileName]
                                stringByAppendingPathExtension:_1type]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
}


@end
