//
//  bOrderDetailViewController.m
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "bOrderDetailViewController.h"

//此处用户信息雇主端的代码(内容相同)
#import "COrderDetailBrokerTableViewCell.h"

#import "BOrderDetailOrderTableViewCell.h"
#import "BOrderDetailAddressTableViewCell.h"
#import "BOrderDetailMoneyTableViewCell.h"
#import "BOrderDetailMoney2TableViewCell.h"

#import "CustomerCommentViewController.h"

#import "ComplainOrderViewController.h"

@interface bOrderDetailViewController ()<AlertShowDelegate,DetailOrderContentDelegate,DetailOrderAddressDelegate,DetailOrderBrokerDelegate,CommentSuccessDelegate>
{
    BOOL isHaveDian;
    Out_OrderDetailBody *_tempOrderDetail;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *orderTableView;
@property (nonatomic, strong) UIActionSheet *moreDealSheet;

@property (nonatomic, strong) UIView *orderInfoView;//展示订单号和时间
@property (nonatomic, strong) UILabel *orderNumLabel;//订单号
@property (nonatomic, strong) UILabel *orderTimeLabel;//订单时间

@property (nonatomic, strong) UIView *orderDealView;//订单处理浮动view
@property (nonatomic, strong) UIButton *confirmBtn;//确认完成
@property (nonatomic, strong) UIButton *commentBtn;//评价

@property (nonatomic, strong) UIView *moneyInputView;//输入金额view
@property (nonatomic, strong) UITextField *moneyInputTxt;//输入金额


@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) HSAlertShowViewController *alertShowVC;

@property (strong, nonatomic)   AVAudioPlayer    *player;

@end

@implementation bOrderDetailViewController

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
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 30, 30);
    [rightItem setImage:[UIImage imageNamed:@"nav_btn_point"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
    //呼单信息
    if (!_orderInfoView) {
        _orderInfoView = [[UIView alloc] initWithFrame:CGRectMake(20.0, SCREEN_HEIGHT, SCREEN_WIDTH-40, 170)];
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
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    if (!_alertShowVC) {
        _alertShowVC = [[HSAlertShowViewController alloc] init];
        _alertShowVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _alertShowVC.view.backgroundColor = WhiteBgColor;
        [_alertShowVC setDataWithTitle:@"是否已与雇主沟通价格" andDetail:@"商品价格一定要先沟通清楚哦" andConfirmBtnTitle:@"已沟通" andCancelBtnTitle:@"未沟通"];
        _alertShowVC.delegate = self;
    }

    
    if (!_moneyInputView) {
        _moneyInputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _moneyInputView.backgroundColor = ViewBgColor;
        
    }
    
    if (!_moneyInputTxt) {
        _moneyInputTxt = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 40, 200, 100)];
        _moneyInputTxt.borderStyle = UITextBorderStyleNone;
        _moneyInputTxt.placeholder = @"输入代购金额";
        _moneyInputTxt.backgroundColor = WhiteBgColor;
        _moneyInputTxt.textColor = TextMainCOLOR;
        _moneyInputTxt.font = [UIFont systemFontOfSize:20];
        _moneyInputTxt.layer.cornerRadius = 5.0f;
        _moneyInputTxt.layer.borderWidth = 0.5;
        _moneyInputTxt.layer.borderColor = LineColor.CGColor;
        _moneyInputTxt.textAlignment = NSTextAlignmentCenter;
        _moneyInputTxt.delegate = self;
        [_moneyInputView addSubview:_moneyInputTxt];
    }
    
    if (!_orderDealView) {
        _orderDealView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _orderDealView.backgroundColor = ViewBgColor;
        [self.view addSubview:_orderDealView];
    }
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认完成" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(orderConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _confirmBtn.layer.borderWidth = 0.5;
        _confirmBtn.layer.cornerRadius = 5;
        [_confirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_confirmBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_confirmBtn];
    }
    
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.frame = CGRectZero;
        [_commentBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(orderCommentClick) forControlEvents:UIControlEventTouchUpInside];
        _commentBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _commentBtn.layer.borderWidth = 0.5;
        _commentBtn.layer.cornerRadius = 5;
        [_commentBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_commentBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_commentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = LittleFont;
        [_orderDealView addSubview:_commentBtn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_moneyInputTxt];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//初始化table
-(UITableView *)initpublishTableView
{
    if (_orderTableView != nil) {
        return _orderTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-50;
    
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
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *dataArray = [[NSArray alloc] initWithObjects:_orderId,@"1", nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderDetailModel *outModel = [[communcation sharedInstance] getOrderDetailWithKey:userInfoModel.key AndDigest:hamcString AndOrderId:_orderId AndType:@"1"];
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

                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 1)
                {
                    //当前状态:待接单
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 2)
                {
                    //当前状态:已抢单
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 3)
                {
                    //当前状态:已接单
                    _confirmBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    _confirmBtn.hidden = NO;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 4)
                {
                    //当前状态:已购买
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 5)
                {
                    //当前状态:已取货
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 6)
                {
                    //当前状态:已办完
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 7)
                {
                    //_当前状态:待付款
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = YES;
                }else if (_tempOrderDetail.statusId == 8)
                {
                    //当前状态:待评价
                    _confirmBtn.hidden = YES;
                    _commentBtn.hidden = NO;
                    _commentBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                }else
                {
                    //当前状态:交易结束
                    
                    // isEvaluated 0表示未评价，>0表示已评价
                    if (_tempOrderDetail.isEvaluated == 0) {
                        _commentBtn.hidden = NO;
                        _commentBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
                    }else
                    {
                        _commentBtn.hidden = YES;
                    }
                    _confirmBtn.hidden = YES;
                }
                
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
}




#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
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

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_nowStatus == OrderStatus_WJD)
    {
        if (_tempOrderDetail.orderTypeId == 3)
        {
            return 0.01;
        }else
        {
            if (_tempOrderDetail.orderTypeId == 1) {
                return 0.01;
            }else
            {
                if (_tempOrderDetail.statusId == 3) {
                    if (section == 2)
                    {
                        return 180;
                    }else{
                        return 0.01;
                    }
                }else
                {
                    return 0.01;
                }
                
            }
        }

    }else
    {
        if (_tempOrderDetail.orderTypeId == 3)
        {
            return 0.01;
        }else
        {
            if (_tempOrderDetail.orderTypeId == 1) {
                return 0.01;
            }else
            {
                if (_tempOrderDetail.statusId == 3) {
                    if (section == 3)
                    {
                        return 180;
                    }else{
                        return 0.01;
                    }
                }else
                {
                    return 0.01;
                }
                
            }

        }
       
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
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
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_nowStatus == OrderStatus_WJD)
    {
        if (_tempOrderDetail.orderTypeId == 3)
        {
            return nil;
        }else
        {
            if (_tempOrderDetail.orderTypeId == 1) {
                return nil;
            }else
            {
                if (_tempOrderDetail.statusId == 3) {
                    if (section == 2)
                    {
                        return _moneyInputView;
                    }else{
                        return nil;
                    }
                }else
                {
                    return nil;
                }
                
            }
        }
        
    }else
    {
        if (_tempOrderDetail.orderTypeId == 3)
        {
            return nil;
        }else
        {
            if (_tempOrderDetail.orderTypeId == 1) {
                return nil;
            }else
            {
                if (_tempOrderDetail.statusId == 3) {
                    if (section == 3)
                    {
                        return _moneyInputView;
                    }else{
                        return nil;
                    }
                }else
                {
                    return nil;
                }
                
            }
            
        }
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
                    return [BOrderDetailMoneyTableViewCell cellHeightWithModel:@"测试"];;
                }else
                {
                    return [BOrderDetailMoney2TableViewCell cellHeightWithModel:@"测试"];;
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
                    return [BOrderDetailMoneyTableViewCell cellHeightWithModel:@"测试"];;
                }else
                {
                    return [BOrderDetailMoney2TableViewCell cellHeightWithModel:@"测试"];;
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
                    return [BOrderDetailMoneyTableViewCell cellHeightWithModel:@"测试"];;
                }else
                {
                    return [BOrderDetailMoney2TableViewCell cellHeightWithModel:@"测试"];;
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
                    return [BOrderDetailMoneyTableViewCell cellHeightWithModel:@"测试"];;
                }else
                {
                    return [BOrderDetailMoney2TableViewCell cellHeightWithModel:@"测试"];;
                }
                
            }
        }
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
                    static NSString *cellName = @"BOrderDetailMoneyTableViewCell";
                    BOrderDetailMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    static NSString *cellName = @"BOrderDetailMoney2TableViewCell";
                    BOrderDetailMoney2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoney2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
                    BOrderDetailMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    static NSString *cellName = @"BOrderDetailMoney2TableViewCell";
                    BOrderDetailMoney2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoney2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
                [cell setOrderContentWithModel:_tempOrderDetail AndType:0];
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
                    static NSString *cellName = @"BOrderDetailMoneyTableViewCell";
                    BOrderDetailMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    static NSString *cellName = @"BOrderDetailMoney2TableViewCell";
                    BOrderDetailMoney2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoney2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
                [cell setOrderContentWithModel:_tempOrderDetail AndType:0];
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
                    static NSString *cellName = @"BOrderDetailMoneyTableViewCell";
                    BOrderDetailMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else
                {
                    static NSString *cellName = @"BOrderDetailMoney2TableViewCell";
                    BOrderDetailMoney2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[BOrderDetailMoney2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    }
                    [cell setOrderContentWithModel:_tempOrderDetail];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
            
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


//订单确认完成
- (void)orderConfirmClick
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    //呼单类型，1：代办，2：代购，3：代送
    if (_tempOrderDetail.orderTypeId == 1) {
        
        NSString *hamcString = [[communcation sharedInstance] hmac:_tempOrderDetail.orderId withKey:userInfoModel.primaryKey];
        
        dispatch_async(dispatch_get_global_queue(0, 0),
                       ^{
            Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] brokerConfirmDBOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"订单完成，等待雇主支付!"] show];
                    [self getOrderDetail];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
        
    }else if (_tempOrderDetail.orderTypeId == 2)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (_moneyInputTxt.text.length == 0) {
            [[iToast makeText:@"请输入商品金额!"] show];
            return;
        }
        [self.view addSubview:_maskView];
        [self.view addSubview:_alertShowVC.view];
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.alpha = 0.7;
            _alertShowVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-170)/2, SCREEN_WIDTH-40, 170);
        } completion: ^(BOOL finish){
        }];
        
    }else
    {
        NSString *hamcString = [[communcation sharedInstance] hmac:_tempOrderDetail.orderId withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] brokerConfirmDSOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"订单完成，等待雇主支付!"] show];
                    [self getOrderDetail];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
        
    }
}

//订单立即评价
- (void)orderCommentClick
{
    CustomerCommentViewController *commentVC = [[CustomerCommentViewController alloc] init];
    commentVC.type = @"0";
    commentVC.orderId = _tempOrderDetail.orderId;
    [self.navigationController pushViewController:commentVC animated:YES];
    commentVC.delegate = self;
}


#pragma CommentSuccessDelegate 评论成功刷新
- (void)commentSuccessBackRefresh
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
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.uTelephone];
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

#pragma AlertShowDelegate 弹出提示框代理
- (void)confirmBtnClick
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:_tempOrderDetail.orderId,_moneyInputTxt.text, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] brokerConfirmDGOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId AndFee:_moneyInputTxt.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"订单完成，等待雇主支付!"] show];
                [self cancelBtnClick];
                [self getOrderDetail];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

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

- (void)rightItemClick
{
    _moreDealSheet = [[UIActionSheet alloc]
                      initWithTitle:nil
                      delegate:self
                      cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                      otherButtonTitles: @"同意取消",@"投诉",nil];
    _moreDealSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [_moreDealSheet showInView:self.view];
    
}

//右侧按钮弹出框
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {

        if (!_tempOrderDetail||_tempOrderDetail.statusId < 3||_tempOrderDetail.statusId > 7) {
            [[iToast makeText:@"当前状态不可取消呼单"] show];
            return;
        }
        
        if (_tempOrderDetail.needCancel == 0) {
            [[iToast makeText:@"需要雇主发起取消申请"] show];
            return;
        }
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"取消呼单中";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        NSString *hamcString = [[communcation sharedInstance] hmac:_tempOrderDetail.orderId withKey:userInfoModel.primaryKey];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AllSameModel *outModel = [[communcation sharedInstance]allowCancelOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_tempOrderDetail.orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已同意取消该呼单!"] show];
                    [self leftItemClick];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }else if (buttonIndex == 1)
    {
        ComplainOrderViewController *complainVC = [[ComplainOrderViewController alloc] init];
        complainVC.orderId = _tempOrderDetail.orderId;
        [self.navigationController pushViewController:complainVC animated:YES];
        
    }else if(buttonIndex == 2) {
        
    }else if(buttonIndex == 3) {
        
    }
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_moneyInputTxt.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([_moneyInputTxt.text length]==0){
                if(single == '.'){
                    [_moneyInputTxt resignFirstResponder];
                    [[iToast makeText:@"第一个数字不能为小数点!"] show];
                    [_moneyInputTxt.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                if (single == '0') {
                    [_moneyInputTxt resignFirstResponder];
                    [[iToast makeText:@"第一个数字不能为0!"] show];
                    [_moneyInputTxt.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [_moneyInputTxt resignFirstResponder];
                    [[iToast makeText:@"您已经输入过小数点了!"] show];
                    [_moneyInputTxt.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[_moneyInputTxt.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        [_moneyInputTxt resignFirstResponder];
                        [[iToast makeText:@"您最多输入两位小数!"] show];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [_moneyInputTxt resignFirstResponder];
            [[iToast makeText:@"您输入的格式不正确，只可输入数字!"] show];
            [_moneyInputTxt.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}


-(void)textFieldChanged:(NSNotification *)notification
{
    if ([_moneyInputTxt.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([_moneyInputTxt.text length]>0)
    {
        unichar single=[_moneyInputTxt.text characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([_moneyInputTxt.text length]==0){
                if(single == '.'){
                    [_moneyInputTxt resignFirstResponder];
                    [[iToast makeText:@"第一个数字不能为小数点!"] show];
                    _moneyInputTxt.text = @"";
                    return;
                    
                }
                if (single == '0') {
                    [_moneyInputTxt resignFirstResponder];
                    [[iToast makeText:@"第一个数字不能为0!"] show];
                    _moneyInputTxt.text = @"";
                    return;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return;
                }else
                {
                    [_moneyInputTxt resignFirstResponder];
                    [[iToast makeText:@"您已经输入过小数点了!"] show];
                    _moneyInputTxt.text = @"";
                    return;
                }
            }
            else
            {
                
            }
        }else{//输入的数据格式不正确
            [_moneyInputTxt resignFirstResponder];
            [[iToast makeText:@"您输入的格式不正确，只可输入数字!"] show];
            _moneyInputTxt.text = @"";
            return;
        }
    }
    else
    {
        return;
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
