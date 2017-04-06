//
//  COrderDetailViewController.m
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderDetailViewController.h"
#import "COrderDetailBrokerTableViewCell.h"
#import "BOrderDetailOrderTableViewCell.h"
#import "COrderDetailPayTableViewCell.h"
#import "COrderDetailPay2TableViewCell.h"
#import "COrderDetailStatusTableViewCell.h"
#import "BOrderDetailAddressTableViewCell.h"

#import "COrderPayTypeChooseViewController.h"
#import "CustomerCommentViewController.h"

#import "ChooseBrokerViewController.h"

#import "CustomerCommentViewController.h"

#import "OrderFeesChooseViewController.h"

#import "ComplainOrderViewController.h"

@interface COrderDetailViewController ()<DetailOrderContentDelegate,DetailOrderBrokerDelegate,DetailOrderAddressDelegate,ChooseBrokerCompleteDelegate,OrderFeesChooseDelegate,PaySuccessBackDelegate,CommentSuccessDelegate>
{
    Out_OrderDetailBody *_tempOrderDetail;
    NSArray *_orderStatusArray;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UITableView *orderTableView;


@property (nonatomic, strong) UIView *orderInfoView;//展示订单号和时间
@property (nonatomic, strong) UILabel *orderNumLabel;//订单号
@property (nonatomic, strong) UILabel *orderTimeLabel;//订单时间


@property (nonatomic, strong) UIView *orderDealView;//订单处理
@property (nonatomic, strong) UIButton *orderConfirmBtn;//确认
@property (nonatomic, strong) UIButton *orderCancelBtn;//取消
@property (nonatomic, strong) UIButton *chooseBrokerBtn;//选择经纪人
@property (nonatomic, strong) UIButton *moreTipsBtn;//追加小费
@property (nonatomic, strong) UIButton *payMoneyBtn;//立即付款
@property (nonatomic, strong) UIButton *commmentBtn;//立即评价



@property (nonatomic, strong) UIActionSheet *moreDealSheet;
@property (nonatomic, strong) UIAlertView *cancelOrderAlert;


@property (strong, nonatomic)   AVAudioPlayer    *player;

@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) OrderFeesChooseViewController *feesChooseVC;

@end

@implementation COrderDetailViewController

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
        _titleLabel.text = @"我的呼单";
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
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"呼单详情" forState:UIControlStateNormal];
        [_button1 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button1 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        _button1.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 40);
        _button1.titleLabel.font = LittleFont;
        _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button1.selected = YES;
        [_headView addSubview:_button1];
    }
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"呼单状态" forState:UIControlStateNormal];
        [_button2 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button2 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        _button2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 40);
        _button2.titleLabel.font = LittleFont;
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button2];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    
    _nowInfoType = OrderInfoType_Detail;//默认展示呼单详情
    
    //呼单信息
    if (!_orderInfoView) {
        _orderInfoView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 20)];
        _orderInfoView.backgroundColor = ViewBgColor;
    }
    
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, SCREEN_WIDTH/2, 20)];
        _orderNumLabel.backgroundColor = [UIColor clearColor];
        _orderNumLabel.font = [UIFont systemFontOfSize:10];
        _orderNumLabel.textColor = TextDetailCOLOR;
        _orderNumLabel.text = @"呼单号:3242398579285";
        _orderNumLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        [_orderInfoView addSubview:_orderNumLabel];
    }
    
    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,0, SCREEN_WIDTH/2-20, 20)];
        _orderTimeLabel.backgroundColor = [UIColor clearColor];
        _orderTimeLabel.font = [UIFont systemFontOfSize:10];
        _orderTimeLabel.textColor = TextDetailCOLOR;
        _orderTimeLabel.text = @"2015-11-18";
        _orderTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _orderTimeLabel.textAlignment = NSTextAlignmentRight;
        [_orderInfoView addSubview:_orderTimeLabel];
    }
    
    //加载tableview
    [self initpublishTableView];
    [self.view addSubview:_orderTableView];
    
    _orderTableView.hidden = YES;
    
    
    //加载订单处理功能
    if (!_orderDealView) {
        _orderDealView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _orderDealView.backgroundColor = ViewBgColor;
        [self.view addSubview:_orderDealView];
    }
    
    if (!_orderConfirmBtn) {
        _orderConfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderConfirmBtn.frame = CGRectZero;
        [_orderConfirmBtn setTitle:@"确认完成" forState:UIControlStateNormal];
        [_orderConfirmBtn addTarget:self action:@selector(confirmOrderClick) forControlEvents:UIControlEventTouchUpInside];
        _orderConfirmBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _orderConfirmBtn.layer.borderWidth = 0.5;
        _orderConfirmBtn.layer.cornerRadius = 5;
        [_orderConfirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_orderConfirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_orderConfirmBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderConfirmBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_orderConfirmBtn];
    }
    
    if (!_orderCancelBtn) {
        _orderCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderCancelBtn.frame = CGRectZero;
        [_orderCancelBtn setTitle:@"取消呼单" forState:UIControlStateNormal];
        [_orderCancelBtn addTarget:self action:@selector(cancelOrderClick) forControlEvents:UIControlEventTouchUpInside];
        _orderCancelBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _orderCancelBtn.layer.borderWidth = 0.5;
        _orderCancelBtn.layer.cornerRadius = 5;
        [_orderCancelBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_orderCancelBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_orderCancelBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderCancelBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_orderCancelBtn];
    }
    
    
    if (!_chooseBrokerBtn) {
        _chooseBrokerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBrokerBtn.frame = CGRectZero;
        [_chooseBrokerBtn setTitle:@"选择经纪人" forState:UIControlStateNormal];
        [_chooseBrokerBtn addTarget:self action:@selector(chooseBrokerClick) forControlEvents:UIControlEventTouchUpInside];
        _chooseBrokerBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _chooseBrokerBtn.layer.borderWidth = 0.5;
        _chooseBrokerBtn.layer.cornerRadius = 5;
        [_chooseBrokerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_chooseBrokerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_chooseBrokerBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _chooseBrokerBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_chooseBrokerBtn];
    }
    
    if (!_moreTipsBtn) {
        _moreTipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreTipsBtn.frame = CGRectZero;
        [_moreTipsBtn setTitle:@"追加小费" forState:UIControlStateNormal];
        [_moreTipsBtn addTarget:self action:@selector(moreTipsClick) forControlEvents:UIControlEventTouchUpInside];
        _moreTipsBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _moreTipsBtn.layer.borderWidth = 0.5;
        _moreTipsBtn.layer.cornerRadius = 5;
        [_moreTipsBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_moreTipsBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_moreTipsBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _moreTipsBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_moreTipsBtn];
    }
    
    if (!_payMoneyBtn) {
        _payMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payMoneyBtn.frame = CGRectZero;
        [_payMoneyBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [_payMoneyBtn addTarget:self action:@selector(payMoneyClick) forControlEvents:UIControlEventTouchUpInside];
        _payMoneyBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _payMoneyBtn.layer.borderWidth = 0.5;
        _payMoneyBtn.layer.cornerRadius = 5;
        [_payMoneyBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_payMoneyBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_payMoneyBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _payMoneyBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_payMoneyBtn];
    }

    if (!_commmentBtn) {
        _commmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commmentBtn.frame = CGRectZero;
        [_commmentBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        [_commmentBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        _commmentBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _commmentBtn.layer.borderWidth = 0.5;
        _commmentBtn.layer.cornerRadius = 5;
        [_commmentBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_commmentBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_commmentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _commmentBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_commmentBtn];
        
    }
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    if (!_feesChooseVC) {
        _feesChooseVC = [[OrderFeesChooseViewController alloc] init];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _feesChooseVC.delegate = self;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackVC) name:@"BackVC" object:nil];
    
}

- (void)BackVC{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化table
-(UITableView *)initpublishTableView
{
    if (_orderTableView != nil) {
        return _orderTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104-50;
    
    self.orderTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _orderTableView.delegate = self;
    _orderTableView.dataSource = self;
    _orderTableView.backgroundColor = ViewBgColor;
    _orderTableView.showsVerticalScrollIndicator = NO;
    return _orderTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

///获取订单详情
- (void)getOrderDetail
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *dataArray = [[NSArray alloc] initWithObjects:_orderId,@"0", nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderDetailModel *outModel = [[communcation sharedInstance] getOrderDetailWithKey:userInfoModel.key AndDigest:hamcString AndOrderId:_orderId AndType:@"0"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _tempOrderDetail = outModel.data;
                [_orderTableView reloadData];
                _orderTableView.hidden = NO;
                if (_tempOrderDetail.statusId == 0)
                {
                    //当前状态:已取消
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _orderConfirmBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 1)
                {
                    //当前状态:待接单
                    _orderCancelBtn.frame = CGRectMake(20,5, (SCREEN_WIDTH-80)/2, 40);
                    _moreTipsBtn.frame = CGRectMake(60+(SCREEN_WIDTH-80)/2,5, (SCREEN_WIDTH-80)/2, 40);
                    _orderCancelBtn.hidden = NO;
                    _moreTipsBtn.hidden = NO;
                    _chooseBrokerBtn.hidden = YES;
                    _orderConfirmBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 2)
                {
                    //当前状态:已抢单
                    _orderCancelBtn.frame = CGRectMake(20,5, (SCREEN_WIDTH-80)/2, 40);
                    _chooseBrokerBtn.frame = CGRectMake(60+(SCREEN_WIDTH-80)/2,5, (SCREEN_WIDTH-80)/2, 40);
                    _orderCancelBtn.hidden = NO;
                    
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = NO;
                    _orderConfirmBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 3)
                {
                    //当前状态:已接单
                    _orderConfirmBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    [_orderConfirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateNormal];
                    _orderConfirmBtn.enabled = NO;
                    _orderConfirmBtn.alpha = 0.5;
                    _orderConfirmBtn.hidden = NO;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 4)
                {
                    //当前状态:已购买
                    _orderConfirmBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    [_orderConfirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
                    _orderConfirmBtn.enabled = YES;
                    
                    _orderConfirmBtn.hidden = NO;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 5)
                {
                    //当前状态:已取货
                    _orderConfirmBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    [_orderConfirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
                    _orderConfirmBtn.enabled = YES;
                    
                    _orderConfirmBtn.hidden = NO;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 6)
                {
                    //当前状态:已办完
                    _orderConfirmBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    [_orderConfirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
                    _orderConfirmBtn.enabled = YES;
                    
                    _orderConfirmBtn.hidden = NO;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 7)
                {
                    //_当前状态:待付款
                    _payMoneyBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    
                    _payMoneyBtn.hidden = NO;
                    _orderConfirmBtn.hidden = YES;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _commmentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 8)
                {
                    //当前状态:待评价
                    _commmentBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    _commmentBtn.hidden = NO;
                    _orderConfirmBtn.hidden = YES;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                }else
                {
                    //当前状态:交易结束
                    
                    // isEvaluated 0表示未评价，>0表示已评价
                    if (_tempOrderDetail.isEvaluated == 0) {
                        _commmentBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                        _commmentBtn.hidden = NO;
                    }else
                    {
                        _commmentBtn.hidden = YES;
                    }
                    
                    _orderConfirmBtn.hidden = YES;
                    _orderCancelBtn.hidden = YES;
                    _moreTipsBtn.hidden = YES;
                    _chooseBrokerBtn.hidden = YES;
                    _payMoneyBtn.hidden = YES;
                }
                
                if (!_tempOrderDetail||_tempOrderDetail.statusId < 3||_tempOrderDetail.statusId > 7) {
                    return ;
                }else
                {
                    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
                    rightItem.frame = CGRectMake(0, 0, 30, 30);
                    [rightItem setImage:[UIImage imageNamed:@"nav_btn_point"] forState:UIControlStateNormal];
                    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
                }
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


///获取呼单状态
- (void)getOrderDetailStatus
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];

    NSString *hamcString = [[communcation sharedInstance] hmac:_orderId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderDetailStatusModel *outModel = [[communcation sharedInstance] getOrderDetailStatusWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_orderId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _orderStatusArray = outModel.data;
                [_orderTableView reloadData];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

//-----------------------------------------------------------------------------

#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_nowInfoType == OrderInfoType_Detail)
    {
        if (_nowStatus == OrderStatus_WJD)
        {
            // 呼单类型，1：代办，2：代购，3：代送
            if (_tempOrderDetail.orderTypeId == 3) {
                return 4;
            }else
            {
                return 3;
            }
            
        }else
        {
            if (_tempOrderDetail.orderTypeId == 3) {
                return 5;
            }else
            {
                return 4;
            }
        }
    }else
    {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_nowInfoType == OrderInfoType_Detail)
    {
        return 1;
        
    }else
    {
        return [_orderStatusArray count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_nowInfoType == OrderInfoType_Detail)
    {
        if (_nowStatus == OrderStatus_WJD) {
            if (section == 0) {
                return 20;
            }else
            {
                if (_tempOrderDetail.orderTypeId == 3)
                {
                    if (section == 1) {
                        return 0.01;
                    }else if (section == 2)
                    {
                        return 0.01;
                    }else
                    {
                        return 10;
                    }
                }else
                {
                    if (section == 1) {
                        return 0.01;
                    }else
                    {
                        return 10;
                    }
                }
                
            }
        }else
        {
            if (section == 0) {
                return 20;
            }else
            {
                if (_tempOrderDetail.orderTypeId == 3)
                {
                    if (section == 2) {
                        return 0.01;
                    }else if (section == 3)
                    {
                        return 0.01;
                    }else
                    {
                        return 10;
                    }
                }else
                {
                    if (section == 2) {
                        return 0.01;
                    }else
                    {
                        return 10;
                    }
                }
            }
        }

    }else
    {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_nowInfoType == OrderInfoType_Detail)
    {
        if (_nowStatus == OrderStatus_WJD) {
            if (section == 0) {
                _orderNumLabel.text = [NSString stringWithFormat:@"呼单号:%@",_tempOrderDetail.orderNo];
                _orderTimeLabel.text = _tempOrderDetail.createTime;
                return _orderInfoView;
            }else
            {
                return nil;
            }
        }else
        {
            if (section == 0) {
                _orderNumLabel.text = [NSString stringWithFormat:@"呼单号:%@",_tempOrderDetail.orderNo];
                _orderTimeLabel.text = _tempOrderDetail.createTime;
                return _orderInfoView;
            }else
            {
                return nil;
            }
        }

    }else
    {
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nowInfoType == OrderInfoType_Detail)
    {
        if (_nowStatus == OrderStatus_WJD)
        {
            if (_tempOrderDetail.orderTypeId == 3)
            {
                if (indexPath.section == 0)
                {
                    return [BOrderDetailOrderTableViewCell cellHeightWithModel:_tempOrderDetail];
                }else if (indexPath.section == 1)
                {
                    return [BOrderDetailAddressTableViewCell cellHeightWithModel:@"测试"];
                }else if (indexPath.section == 2)
                {
                    return [BOrderDetailAddressTableViewCell cellHeightWithModel:@"测试"];
                }else
                {
                    if (_tempOrderDetail.orderTypeId == 2) {
                        return [COrderDetailPayTableViewCell cellHeightWithModel:@"测试"];;
                    }else
                    {
                        return [COrderDetailPay2TableViewCell cellHeightWithModel:@"测试"];;
                    }
                }
            }else
            {
                if (indexPath.section == 0) {
                    return [BOrderDetailOrderTableViewCell cellHeightWithModel:_tempOrderDetail];
                }else if (indexPath.section == 1)
                {
                    return [BOrderDetailAddressTableViewCell cellHeightWithModel:@"测试"];
                }else
                {
                    if (_tempOrderDetail.orderTypeId == 2) {
                        return [COrderDetailPayTableViewCell cellHeightWithModel:@"测试"];;
                    }else
                    {
                        return [COrderDetailPay2TableViewCell cellHeightWithModel:@"测试"];;
                    }
                }
            }
        }else
        {
            if (_tempOrderDetail.orderTypeId == 3)
            {
                if (indexPath.section == 0) {
                    return 60;
                }else if (indexPath.section == 1)
                {
                    return [BOrderDetailOrderTableViewCell cellHeightWithModel:_tempOrderDetail];
                }else if (indexPath.section == 2)
                {
                    return [BOrderDetailAddressTableViewCell cellHeightWithModel:@"测试"];
                }else if (indexPath.section == 3)
                {
                    return [BOrderDetailAddressTableViewCell cellHeightWithModel:@"测试"];
                }
                else
                {
                    if (_tempOrderDetail.orderTypeId == 2) {
                        return [COrderDetailPayTableViewCell cellHeightWithModel:@"测试"];;
                    }else
                    {
                        return [COrderDetailPay2TableViewCell cellHeightWithModel:@"测试"];;
                    }
                }
            }else
            {
                if (indexPath.section == 0) {
                    return 60;
                }else if (indexPath.section == 1)
                {
                    return [BOrderDetailOrderTableViewCell cellHeightWithModel:_tempOrderDetail];
                }else if (indexPath.section == 2)
                {
                    return [BOrderDetailAddressTableViewCell cellHeightWithModel:@"测试"];
                }
                else
                {
                    if (_tempOrderDetail.orderTypeId == 2) {
                        return [COrderDetailPayTableViewCell cellHeightWithModel:@"测试"];;
                    }else
                    {
                        return [COrderDetailPay2TableViewCell cellHeightWithModel:@"测试"];;
                    }
                    
                }
            }
        }

    }else
    {
        return [COrderDetailStatusTableViewCell cellHeightWithModel:@"测试"];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///设置地址信息 1是代购，2是代办  代送(3是取货 4是送达)
    if (_nowInfoType == OrderInfoType_Detail)//选择展示呼单详情
    {
        if (_nowStatus == OrderStatus_WJD)//当前未接单
        {
            if (_tempOrderDetail.orderTypeId == 3)
            {
                if (indexPath.section == 0)
                {
                    static NSString *cellName = @"BOrderDetailOrderTableViewCell";
                    BOrderDetailOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }else if (indexPath.section == 1)
                {
                    static NSString *cellName = @"BOrderDetailAddressTableViewCell";
                    BOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    [cell setOrderContentWithModel:_tempOrderDetail AndType:3];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else if (indexPath.section == 2)
                {
                    static NSString *cellName = @"BOrderDetailAddressTableViewCell";
                    BOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    [cell setOrderContentWithModel:_tempOrderDetail AndType:4];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    //状态为2时是代购
                    if (_tempOrderDetail.orderTypeId == 2) {
                        static NSString *cellName = @"COrderDetailPayTableViewCell";
                        COrderDetailPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }else
                    {
                        static NSString *cellName = @"COrderDetailPay2TableViewCell";
                        COrderDetailPay2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPay2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }

                }

            }else
            {
                if (indexPath.section == 0)
                {
                    static NSString *cellName = @"BOrderDetailOrderTableViewCell";
                    BOrderDetailOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }else if (indexPath.section == 1)
                {
                    static NSString *cellName = @"BOrderDetailAddressTableViewCell";
                    BOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    if (_tempOrderDetail.orderTypeId == 1)
                    {
                        [cell setOrderContentWithModel:_tempOrderDetail AndType:2];
                    }else
                    {
                        [cell setOrderContentWithModel:_tempOrderDetail AndType:1];
                    }
                        
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    //状态为2时是代购
                    if (_tempOrderDetail.orderTypeId == 2) {
                        static NSString *cellName = @"COrderDetailPayTableViewCell";
                        COrderDetailPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }else
                    {
                        static NSString *cellName = @"COrderDetailPay2TableViewCell";
                        COrderDetailPay2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPay2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                }

            }
        }else//当前已接单
        {
            if (_tempOrderDetail.orderTypeId == 3)
            {
                if (indexPath.section == 0) {
                    static NSString *cellName = @"COrderDetailBrokerTableViewCell";
                    COrderDetailBrokerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[COrderDetailBrokerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail AndType:1];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else if (indexPath.section == 1)
                {
                    static NSString *cellName = @"BOrderDetailOrderTableViewCell";
                    BOrderDetailOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else if (indexPath.section == 2)
                {
                    static NSString *cellName = @"BOrderDetailAddressTableViewCell";
                    BOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    [cell setOrderContentWithModel:_tempOrderDetail AndType:3];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else if (indexPath.section == 3)
                {
                    static NSString *cellName = @"BOrderDetailAddressTableViewCell";
                    BOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    [cell setOrderContentWithModel:_tempOrderDetail AndType:4];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    //状态为2时是代购
                    if (_tempOrderDetail.orderTypeId == 2) {
                        static NSString *cellName = @"COrderDetailPayTableViewCell";
                        COrderDetailPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }else
                    {
                        static NSString *cellName = @"COrderDetailPay2TableViewCell";
                        COrderDetailPay2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPay2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                }

            }else
            {
                if (indexPath.section == 0) {
                    static NSString *cellName = @"COrderDetailBrokerTableViewCell";
                    COrderDetailBrokerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[COrderDetailBrokerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    [cell setOrderContentWithModel:_tempOrderDetail AndType:1];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else if (indexPath.section == 1)
                {
                    static NSString *cellName = @"BOrderDetailOrderTableViewCell";
                    BOrderDetailOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else if (indexPath.section == 2)
                {
                    static NSString *cellName = @"BOrderDetailAddressTableViewCell";
                    BOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    cell.delegate = self;
                    if (_tempOrderDetail.orderTypeId == 1)
                    {
                        [cell setOrderContentWithModel:_tempOrderDetail AndType:2];
                    }else
                    {
                        [cell setOrderContentWithModel:_tempOrderDetail AndType:1];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    //状态为2时是代购
                    if (_tempOrderDetail.orderTypeId == 2) {
                        static NSString *cellName = @"COrderDetailPayTableViewCell";
                        COrderDetailPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }else
                    {
                        static NSString *cellName = @"COrderDetailPay2TableViewCell";
                        COrderDetailPay2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[COrderDetailPay2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                        }
                        [cell setOrderContentWithModel:_tempOrderDetail];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                    }
                }

            }
        }
    }else//当前展示呼单状态
    {
        static NSString *cellName = @"COrderDetailStatusTableViewCell";
        COrderDetailStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderDetailStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        Out_OrderDetailStatusBody *model = [_orderStatusArray objectAtIndex:indexPath.row];
        [cell setOrderContentWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
//-------------------------------------------------------------

//呼单详情
- (void)button1Click
{
    
    [UIView animateWithDuration:0.1 animations:^{
        _orderDealView.frame = CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
        _orderTableView.frame = CGRectMake(0,104, SCREEN_WIDTH, SCREEN_HEIGHT-104-50);
    } completion: ^(BOOL finish){
        _button1.selected = YES;
        _button2.selected = NO;
        _nowInfoType = OrderInfoType_Detail;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_orderTableView reloadData];
    }];


}

//呼单状态
- (void)button2Click
{
    [UIView animateWithDuration:0.1 animations:^{
        _orderDealView.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 50);
        _orderTableView.frame = CGRectMake(0,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    } completion: ^(BOOL finish){
        _button1.selected = NO;
        _button2.selected = YES;
        _nowInfoType = OrderInfoType_Status;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self getOrderDetailStatus];
    }];
}

//-------------------------------------------------------------
//确认呼单
- (void)confirmOrderClick
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString *hamcString = [[communcation sharedInstance] hmac:_tempOrderDetail.orderId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] CustomerConfirmOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已确认订单完成，快去支付吧!"] show];
                [self getOrderDetail];
            
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

//取消呼单
- (void)cancelOrderClick
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"取消呼单中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hamcString = [[communcation sharedInstance] hmac:_tempOrderDetail.orderId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CancelOrderBeforeModel *outModel = [[communcation sharedInstance] cancelOrderBeforeWithWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已取消该呼单!"] show];
                [self leftItemClick];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

//选择经纪人
- (void)chooseBrokerClick
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    ChooseBrokerViewController *chooseBrokerVC = [[ChooseBrokerViewController alloc] init];
    chooseBrokerVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chooseBrokerVC];
    [app.menuViewController presentViewController:nav animated:YES completion:^{
        //获取经纪人列表
        [chooseBrokerVC getBrokerListWithOrderId:_tempOrderDetail.orderId];
    }];
}

///完成选择经纪人代理实现
- (void)completeAndRefresh
{
    [self getOrderDetail];
}

//立即评价
- (void)commentClick
{
    CustomerCommentViewController *commentVC = [[CustomerCommentViewController alloc] init];
    commentVC.type = @"1";
    commentVC.orderId = _tempOrderDetail.orderId;
    [self.navigationController pushViewController:commentVC animated:YES];
    commentVC.delegate = self;
}


#pragma CommentSuccessDelegate 评论成功刷新
- (void)commentSuccessBackRefresh
{
    [self getOrderDetail];
}

//追加小费
- (void)moreTipsClick
{
    [self.view addSubview:_maskView];
    [self.view addSubview:_feesChooseVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _maskView.alpha = 0.7;
        _feesChooseVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-350)/2, SCREEN_WIDTH-40, 350);
        _feesChooseVC.tempOrderId = _tempOrderDetail.orderId;
        
    } completion: ^(BOOL finish){
    }];
}


#pragma OrderFeesChooseDelegate 选择小费事件代理
- (void)cancelFeesChoose
{
    [UIView animateWithDuration:0.3 animations:^{
        _feesChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_feesChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
    }];
}
- (void)chooseFeesWithModel:(OutTipsBody*)model
{
    [UIView animateWithDuration:0.3 animations:^{
        _feesChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_feesChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        //传入选中小费，刷新界面
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"追加小费中...";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        NSArray *dataArray = [[NSArray alloc] initWithObjects:_feesChooseVC.tempOrderId,[NSString stringWithFormat:@"%d",model.tipid], nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AllSameModel *outModel = [[communcation sharedInstance] addMoreTipsWithKey:userInfoModel.userId AndDigest:hmacString AndOrderId:_feesChooseVC.tempOrderId AndTipsId:model.tipid];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已追加小费!"] show];
                    [self getOrderDetail];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
        
        
    }];
}

//立即付款
- (void)payMoneyClick
{
    COrderPayTypeChooseViewController *payTypeChooseVC = [[COrderPayTypeChooseViewController alloc] init];
    [self.navigationController pushViewController:payTypeChooseVC animated:YES];
    payTypeChooseVC.orderId = _tempOrderDetail.orderId;
    payTypeChooseVC.orderType = _tempOrderDetail.orderTypeId;
    [payTypeChooseVC getOrderPayDetail];
    payTypeChooseVC.delegate = self;

}

#pragma PaySuccessBackDelegate 支付完成代理
- (void)paySuccessBackRefresh
{
    [self getOrderDetail];
}

//-------------------------------------------------------------
#pragma DetailOrderContentDelegate 呼单详细内容代理
//图片展示代理实现
- (void)showOrderImgWithModel:(Out_OrderDetailBody *)model AndIndex:(int)index
{
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:model.picpaths AndType:0];
    ib.currentIndex = index;
    [ib show];
}


///播放语音
- (void)playVoiceWithModel:(Out_OrderDetailBody*)model
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

//-------------------------------------------------------------
#pragma DetailOrderBrokerDelegate 呼单经纪人信息代理
///拨打电话代理实现
- (void)callPhoneWithModel:(Out_OrderDetailBody*)model
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.bTelephone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

//-------------------------------------------------------------


#pragma DetailOrderAddressDelegate 呼单地址信息代理
///拨打地址电话代理
- (void)callAddressPhoneWithModel:(Out_OrderDetailBody *)model AndType:(int)type
{
    //type 1是代购，2是代办  代送(3是取货 4是送达)
    if (type == 1) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.toTelephone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }else if (type == 2)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.toTelephone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }else if (type == 3)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.fromTelephone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }else
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.toTelephone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}
//-------------------------------------------------------------
//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate ConfirmOver];
}

- (void)rightItemClick
{
    
    
    _moreDealSheet = [[UIActionSheet alloc]
                      initWithTitle:nil
                      delegate:self
                      cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                      otherButtonTitles: @"取消订单",@"投诉",nil];
    _moreDealSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [_moreDealSheet showInView:self.view];

}
//-------------------------------------------------------------
//右侧按钮弹出框
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (!_tempOrderDetail||_tempOrderDetail.statusId < 3||_tempOrderDetail.statusId > 7) {
            [[iToast makeText:@"当前状态不可取消呼单"] show];
            return;
        }
        _cancelOrderAlert = [[UIAlertView alloc] initWithTitle:@"是否确认取消订单？" message:@"请先与经纪人沟通，待对方同意" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [_cancelOrderAlert show];

    }else if (buttonIndex == 1)
    {
        //投诉
        ComplainOrderViewController *complainVC = [[ComplainOrderViewController alloc] init];
        complainVC.orderId = _tempOrderDetail.orderId;
        [self.navigationController pushViewController:complainVC animated:YES];
    }else if(buttonIndex == 2) {
        
    }else if(buttonIndex == 3) {
        
    }
    
}


//取消订单
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        
    }else
    {
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"取消呼单中";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        NSString *hamcString = [[communcation sharedInstance] hmac:_tempOrderDetail.orderId withKey:userInfoModel.primaryKey];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AllSameModel *outModel = [[communcation sharedInstance]applyCancelOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已发起取消呼单申请，待经纪人同意!"] show];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
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
