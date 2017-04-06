//
//  BalanceDetailViewController.m
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BalanceDetailViewController.h"
#import "PersonOtherInfoTableViewCell.h"
#import "COrderPayTypeChooseTableViewCell.h"

#import "BillsListViewController.h"
#import "RechargePacketViewController.h"

#import "WXPayView.h"
#import "WXApi.h"

@interface BalanceDetailViewController ()<RechargeChooseDelegate>

{
    Out_MoneyBody *_moneyModel;
    Out_RechargeMoneyBody *_rechargeModel;
    
    UIAlertView *AlertViewOne;
    UIAlertView *AlertViewTwo;
    UIAlertView *AlertViewThree;
    
}


@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *balanceTableView;

@property (nonatomic, strong) UIView *showMoneyView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *moneyLabel;


@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) RechargePacketViewController *rechargeChooseVC;

@end

@implementation BalanceDetailViewController

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
        _titleLabel.text = @"余额";
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
    [rightBtn setTitle:@"账单" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    if (!_showMoneyView) {
        _showMoneyView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 150)];
        _showMoneyView.backgroundColor = WhiteBgColor;
    }
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,15,SCREEN_WIDTH,15)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_tipLabel setTextColor:TextMainCOLOR];
        [_tipLabel setFont:LittleFont];
        _tipLabel.text = @"可用余额：";
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        [_showMoneyView addSubview:_tipLabel];
    }
    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,50,SCREEN_WIDTH,50)];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [_moneyLabel setTextColor:[UIColor redColor]];
        [_moneyLabel setFont:[UIFont systemFontOfSize:32.0]];
        _moneyLabel.text = @"￥--";
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
        [_showMoneyView addSubview:_moneyLabel];
    }
    
    [self initpersonTableView];
    [self.view addSubview:_balanceTableView];
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    if (!_rechargeChooseVC) {
        _rechargeChooseVC = [[RechargePacketViewController alloc] init];
        _rechargeChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _rechargeChooseVC.delegate = self;
    }

    [self getWalletInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackVC) name:@"ChongZhiVC" object:nil];
}

- (void)BackVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_balanceTableView != nil) {
        return _balanceTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.balanceTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _balanceTableView.delegate = self;
    _balanceTableView.dataSource = self;
    _balanceTableView.backgroundColor = ViewBgColor;
    _balanceTableView.showsVerticalScrollIndicator = NO;
    _balanceTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _balanceTableView;
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
                _moneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",_moneyModel.recharge_amount];
                [_balanceTableView reloadData];
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
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 170;
    }
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        view.backgroundColor = ViewBgColor;
        [view addSubview:_showMoneyView];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }else
    {
        if (indexPath.row == 0) {
            return 40;
        }
        return 60;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellName = @"PersonOtherInfoTableViewCell";
        PersonOtherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonOtherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.titleLable.text = @"选择充值金额";
        cell.contentLable.textColor = [UIColor redColor];
        if (_rechargeModel) {
            cell.contentLable.text = [NSString stringWithFormat:@"%0.2f元",_rechargeModel.amount];
        }else
        {
            cell.contentLable.text = @"请选择";
        }
        
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
            cell.titleLable.text = @"选择充值方式";
            cell.contentLable.hidden = YES;
            cell.arrowImg.hidden = YES;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1)
        {
            static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
            COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"支付宝支付";
            cell.imgview.image = [UIImage imageNamed:@"icon_zhifubao"];
            cell.contentLable.text = @"推荐有支付宝账号的用户使用";
            cell.balanceLable.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
            COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"微信支付";
            cell.imgview.image = [UIImage imageNamed:@"icon_weixin"];
            cell.contentLable.text = @"推荐安装微信5.0及以上的版本使用";
            cell.balanceLable.hidden = YES;
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
        [self.view addSubview:_maskView];
        [self.view addSubview:_rechargeChooseVC.view];
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.alpha = 0.7;
            _rechargeChooseVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-250)/2, SCREEN_WIDTH-40, 250);
        } completion: ^(BOOL finish){
        }];
    }else
    {
        if (!_rechargeModel) {
            [[iToast makeText:@"请选择充值金额!"]show];
            return;
        }
        
        NSArray *array;
        In_OrderPayModel *inModel = [[In_OrderPayModel alloc] init];
        NSString *hmacString;
        if (indexPath.row == 1)
        {
            ///支付宝支付
            _type = 1;
            array = [[NSArray alloc] initWithObjects:@"0",@"1" ,[NSString stringWithFormat:@"%d",1],_rechargeModel.rechargeid,userInfoModel.userId,@"",nil];
            hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
            inModel.key = userInfoModel.key;
            inModel.digest = hmacString;
            inModel.coupon_type = 0;
            inModel.coupon_id = @"";
            inModel.pay_type = 1;
            inModel.pay_way = 1;
            inModel.order_id = _rechargeModel.rechargeid;
            inModel.user_id = userInfoModel.userId;
        }
        
        if (indexPath.row == 2)
        {
            _type = 2;
            array = [[NSArray alloc] initWithObjects:@"0",@"3" ,[NSString stringWithFormat:@"%d",1],_rechargeModel.rechargeid,userInfoModel.userId,@"",nil];
            hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
            inModel.key = userInfoModel.key;
            inModel.digest = hmacString;
            inModel.coupon_type = 0;
            inModel.coupon_id = @"";
            inModel.pay_type = 3;
            inModel.pay_way = 1;
            inModel.order_id = _rechargeModel.rechargeid;
            inModel.user_id = userInfoModel.userId;
        }
        [self thirdPartPayWithArray:inModel];
    }
}

- (void)cancelTypeChoose
{
    [UIView animateWithDuration:0.3 animations:^{
        _rechargeChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_rechargeChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _rechargeChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
    }];
}

- (void)chooseTypeWithModel:(Out_RechargeMoneyBody*)model
{
    [UIView animateWithDuration:0.3 animations:^{
        _rechargeChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_rechargeChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _rechargeChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _rechargeModel = model;
        [_balanceTableView reloadData];
    }];
}

//------------------------------------------------------------------------


///第三方支付 （目前包含：支付宝，微信）
- (void)thirdPartPayWithArray:(In_OrderPayModel*)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderPayModel *outModel = [[communcation sharedInstance] OrderPayWithModel:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"请求出错,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if (_type == 1) {
                    [self AliPayActionWith:outModel];
                    
                }else
                {
                    [self weChatPayAction:outModel];
                }
            }else{
                [[iToast makeText:outModel.message] show];
                
            }
        });
        
    });
    
}

- (void)AliPayActionWith:(Out_OrderPayModel*)model
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911958006740";
    NSString *seller = @"yihusong@163.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAM9qzoVrKGMqbkE4WyEV8PD3jkDCReb/dttO2vQ+uPlumD/A1AEazojI9g8jhgQZBpt4eZjXCL/Gx4+/21JTuE7dRECoJ5bpCBXT/KVfek0UDDxLi8Nkgyu6nZgnKDaLxdi6B31aBNKY2wAr35UHyvOGUfn5gOLaCqApSRDxR2WbAgMBAAECgYBJAfNHivxgS2MbmdaZwrtYVgrASKGKOYmAkDUJm7pIMeFtL1ZwPRtNkk7p7TsS3iwxNSq33Zi6yCEePA3a4JUSqvPclTjHX5wCYW8K8+ADJa79vjrrffss/+DAFeHyWF7JaeWjC8r9dKRMuoaYR2Z1vJPZ9RIp/M0hRstq+pj0oQJBAPE6VfNmYDxiqObeaS1VlFGMV8FUD68UVd6Qt7zxD9LEH874r3UYXlzE7zYLDt0vKr7f5yYPIfABVH6daSlO9W8CQQDcHm4tv4UnCaMcbC45kXHkyioWFa4ESQanvSbVWf7KN7nMZQAKJQm++WtO1zNmgVv9GJk66tEg0vBEedRfCDSVAkEAuo+QO68YjHsM/4hRNYNzMuJkWBtoCdKjWn736wNQZoPRyeMg52GSURLpohVJSJya5YYKoa+gYprUuxuIYi8ztwJAM4W77GFj3VtYHpMDzt3IdvELINg6Py6IrEKOEGpcRSD+EGWjuLwqp9Th1TZyBZBJ49gaJbxI7xHww1Zw6z2UcQJAQPlXON26u66izB3ELBHi+wbNwrF294zVUlLWFmW2NVkB9lCa6ubj8l5jGHVVvkz+M+9Zb6oAnZkSG9mpoKlcBQ==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = model.data.payOrder.pay_order_no ; //订单ID（由商家自行制定）
    //    if (_payType == 1) {
            order.productName = @"余额充值";//商品标题
            order.productDescription = @"余额充值"; //商品描述
    //    }else
    //    {
//    order.productName = @"直接支付(商品订单)";//商品标题
//    order.productDescription = @"呼单支付"; //商品描述
    //    }
    //        order.amount = [NSString stringWithFormat:@"1"];//test
    order.amount = [NSString stringWithFormat:@"%.2f",model.data.payOrder.amount]; //商品价格
    order.notifyURL = model.data.notify_url; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"HSApp";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
         {
             if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000){
                 AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝充值成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [AlertViewOne show];
             }
             else{
                 AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝充值失败,是否继续支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                 [AlertViewTwo show];
             }

         }];
    }
    
}

- (void)weChatPayAction:(Out_OrderPayModel*)model
{
    //判断是否安装了客户端
    if (![WXApi isWXAppInstalled]){
        
        AlertViewThree = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备未安装微信客户端,不支持微信支付,是否前往下载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [AlertViewThree show];
    }
    
    PayReq *req = [[PayReq alloc]init];
    
    // A
    req.partnerId =  model.data.prepay_map.partnerid;
    // B
    req.prepayId = model.data.prepay_map.prepay_id;//预支付订单号
    // C
    req.nonceStr = model.data.prepay_map.nonce_str;
    // D
    req.timeStamp = [model.data.prepay_map.timestamp intValue];
    // E
    req.package = @"Sign=WXPay";
    // F
    req.sign = model.data.prepay_map.sign;
    
    [WXApi sendReq:req];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == AlertViewOne) {
        if (buttonIndex ==0){
            [self leftItemClick];
        }
    }
    if (alertView == AlertViewTwo) {
        if (alertView == AlertViewTwo) {
            if (buttonIndex ==0) {
                [self leftItemClick];
            }else{
                
            }
        }
    }
    if (alertView == AlertViewThree) {
        if (buttonIndex ==0) {
            
        }else
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }
        
    }

}

//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


//导航栏左右侧按钮点击

- (void)rightItemClick
{
    BillsListViewController *billsVC = [[BillsListViewController alloc] init];
    [self.navigationController pushViewController:billsVC animated:YES];
}


@end
