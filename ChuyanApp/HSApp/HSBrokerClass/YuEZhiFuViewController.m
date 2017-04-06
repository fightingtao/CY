//
//  YuEZhiFuViewController.m
//  HSApp
//
//  Created by cbwl on 16/5/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "YuEZhiFuViewController.h"
#import "publicResource.h"
#import "YuEZhiFuTableViewCell.h"
#import "communcation.h"
#import "UserInfoSaveModel.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "AlipaySDK.h"
#import "WXApi.h"

#import "DSTableViewCell.h"
#import "CustomerHomeViewController.h"

@interface YuEZhiFuViewController ()

{
    UIAlertView *AlertViewOne;
    UIAlertView *AlertViewTwo;
    UIAlertView *AlertViewThree;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *payTableView;

@end

@implementation YuEZhiFuViewController

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
        _titleLabel.text = @"混合支付";
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
    
    [self initpublishTableView];
    [self.view addSubview:_payTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)initpublishTableView{
    if (_payTableView != nil) {
        return _payTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.payTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _payTableView.delegate = self;
    _payTableView.dataSource = self;
    _payTableView.backgroundColor = ViewBgColor;
    _payTableView.showsVerticalScrollIndicator = NO;
    return _payTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 200;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        static NSString *cellName = @"DSTableViewCell";
        DSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        
        if (!cell) {
            cell = [[DSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        [cell ReturnDataWithDic:_ReturnDic WithOrderid:_orderid];
        
        return cell;
    }
    else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            static NSString *cellName = @"YuEZhiFuViewController";
            YuEZhiFuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[YuEZhiFuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"支付宝支付";
            cell.imgview.image = [UIImage imageNamed:@"icon_zhifubao"];
            cell.contentLable.text = @"推荐有支付宝账号的用户使用";
            cell.balanceLable.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *cellName = @"YuEZhiFuViewController";
            YuEZhiFuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[YuEZhiFuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"微信支付";
            cell.imgview.image = [UIImage imageNamed:@"icon_weixin"];
            cell.contentLable.text = @"推荐安装微信5.0及以上的版本使用";
            cell.balanceLable.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
 
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (indexPath.row==0) {
        _type = 1;
        ///支付宝支付
        NSArray *array;
        In_OrderPayModel *inModel = [[In_OrderPayModel alloc] init];
        NSString *hmacString;
        if (!_redModel)
        {
            array = [[NSArray alloc] initWithObjects:@"0",@"2" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,@"",nil];
            hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
            inModel.key = userInfoModel.key;
            inModel.digest = hmacString;
            inModel.coupon_type = 0;
            inModel.coupon_id = @"";
            inModel.pay_type = 2;
            inModel.pay_way = 2;
            inModel.order_id = _tempModel.orderId;
            inModel.user_id = userInfoModel.userId;
            
        }else{
            array = [[NSArray alloc] initWithObjects:@"1",_redModel.redid,@"2" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,nil];
            hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
            inModel.key = userInfoModel.key;
            inModel.digest = hmacString;
            inModel.coupon_type = 1;
            inModel.coupon_id = _redModel.redid;
            inModel.pay_type = 2;
            inModel.pay_way = 2;
            inModel.order_id = _tempModel.orderId;
            inModel.user_id = userInfoModel.userId;
        }
        
        [self thirdPartPayWithArray:inModel];
    }
    else if (indexPath.row==1){
        _type = 2;
        ///微信支付
        NSArray *array;
        In_OrderPayModel *inModel = [[In_OrderPayModel alloc] init];
        NSString *hmacString;
        if (!_redModel)
        {
            array = [[NSArray alloc] initWithObjects:@"0",@"4" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,@"",nil];
            hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
            inModel.key = userInfoModel.key;
            inModel.digest = hmacString;
            inModel.coupon_type = 0;
            inModel.coupon_id = @"";
            inModel.pay_type = 4;
            inModel.pay_way = 2;
            inModel.order_id = _tempModel.orderId;
            inModel.user_id = userInfoModel.userId;
            
        }else{
            array = [[NSArray alloc] initWithObjects:@"1",_redModel.redid,@"4" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,nil];
            hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
            inModel.key = userInfoModel.key;
            inModel.digest = hmacString;
            inModel.coupon_type = 1;
            inModel.coupon_id = _redModel.redid;
            inModel.pay_type = 4;
            inModel.pay_way = 2;
            inModel.order_id = _tempModel.orderId;
            inModel.user_id = userInfoModel.userId;
        }
        [self thirdPartPayWithArray:inModel];
    }
}

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
    //        order.productName = @"余额充值";//商品标题
    //        order.productDescription = @"余额充值"; //商品描述
    //    }else
    //    {
    order.productName = @"直接支付(商品订单)";//商品标题
    order.productDescription = @"呼单支付"; //商品描述
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
    NSLog(@"orderSpec = %@",orderSpec);
    
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
             NSLog(@"reslut = %@",resultDic);
             if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000){
                 AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [AlertViewOne show];
             }
             else{
                 AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付失败,是否继续支付" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [AlertViewTwo show];
             }
             
         }];
    }
    
}

- (void)weChatPayAction:(Out_OrderPayModel*)model{
    //判断是否安装了客户端
    if (![WXApi isWXAppInstalled]){
        
        NSLog(@"没有安装微信客户端");
        AlertViewThree = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备未安装微信客户端,不支持微信支付,是否前往下载" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [AlertViewThree show];
        
    }
    
    PayReq *req = [[PayReq alloc]init];
    
    // A
    req.partnerId =  model.data.prepay_map.partnerid;
    // B
    req.prepayId = model.data.prepay_map.prepay_id;
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


- (void)leftItemClick{
    
    UIViewController *VC = self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:VC animated:YES];
    //[self.delegate ConfirmOver];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshData" object:nil userInfo:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == AlertViewOne) {
        if (buttonIndex ==0){
            UIViewController *VC = self.navigationController.viewControllers[0];
            [self.navigationController popToViewController:VC animated:YES];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshData" object:nil userInfo:nil];
        }
    }
    if (alertView == AlertViewTwo) {
        if (alertView == AlertViewTwo) {
            if (buttonIndex ==0) {
                UIViewController *VC = self.navigationController.viewControllers[0];
                [self.navigationController popToViewController:VC animated:YES];
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshData" object:nil userInfo:nil];
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

@end
