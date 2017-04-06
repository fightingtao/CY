//
//  COrderPayTypeChooseViewController.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "COrderPayTypeChooseViewController.h"
#import "COrderMoneyTotalTableViewCell.h"
#import "COrderMoneyTotal2TableViewCell.h"
#import "COrderChooseRedPacketsTableViewCell.h"
#import "COrderPayTypeChooseTableViewCell.h"

#import "MixedPayViewController.h"

#import "InputPwdViewController.h"

#import "WalletPasswordViewController.h"

#import "RedPacketViewController.h"

#import "WXPayView.h"
#import "YuEZhiFuViewController.h"

@interface COrderPayTypeChooseViewController ()<InputPwdDelegate,PayChooseRedDelegate,UIAlertViewDelegate>
{
    Out_ReadyPayDetailBody *_tempModel;
    Out_RedPacketBody *_redModel;
    UIAlertView *AlertViewOne;
    UIAlertView *AlertViewTwo;
    UIAlertView *AlertViewThree;
    UIAlertView *AlertViewFour;
    
    NSDictionary *WReturnDic;
    NSDictionary *CReturnDic;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *payTableView;

@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) InputPwdViewController *inputPwdVC;

@end

@implementation COrderPayTypeChooseViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        _titleLabel.text = @"付款";
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
    
    //提示页面
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    
    if (!_inputPwdVC) {
        _inputPwdVC = [[InputPwdViewController alloc] init];
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 200);
        _inputPwdVC.view.backgroundColor = [UIColor whiteColor];
        _inputPwdVC.delegate = self;
    }
    
    // 微信支付结果的监听者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackVC:) name:@"BackVC" object:nil];
}

-(void)BackVC:(NSNotification*)notification{
    
    if ([[notification.userInfo objectForKey:@"code"] isEqualToString:@"1001"])
    {
        [self.navigationController popViewControllerAnimated:YES];
      
    }
    else if ([[notification.userInfo objectForKey:@"code"] isEqualToString:@"1000"]){
        [self.navigationController popViewControllerAnimated:YES];
        //[self.delegate paySuccessBackRefresh];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"Refresh" object:nil userInfo:nil];
        [self.delegate refreshtableview];
    }
    
    
}

- (void)BackVC{
    
    [self leftItemClick];
    //[self.delegate paySuccessBackRefresh];
    //[self.delegate refreshtableview];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"Refresh" object:nil userInfo:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化table
-(UITableView *)initpublishTableView
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getOrderPayDetail
{
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        NSString *hamcString = [[communcation sharedInstance] hmac:_orderId withKey:userInfoModel.primaryKey];
    
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_ReadyPayDetailModel *outModel = [[communcation sharedInstance] getReadyPayDetailWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_orderId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    _tempModel = outModel.data;
                    [_payTableView reloadData];
                    
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    

}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 0.01;
    }
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
    if (indexPath.section == 0)
    {
        if (_orderType == 2) {
            return [COrderMoneyTotalTableViewCell cellHeightWithModel:@"测试"];
        }else{
            return [COrderMoneyTotal2TableViewCell cellHeightWithModel:@"测试"];
        }
    }else if (indexPath.section == 1 || indexPath.section == 2)
    {
        return 40;
    }else
    {
        return 60;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (_orderType == 2) {
            static NSString *cellName = @"COrderMoneyTotalTableViewCell";
            COrderMoneyTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[COrderMoneyTotalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            [cell setOrderContentWithModel:_tempModel And:_redModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *cellName = @"COrderMoneyTotalTableViewCell";
            COrderMoneyTotal2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[COrderMoneyTotal2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            [cell setOrderContentWithModel:_tempModel And:_redModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else if (indexPath.section == 1)
    {
        static NSString *cellName = @"COrderChooseRedPacketsTableViewCell";
        COrderChooseRedPacketsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderChooseRedPacketsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (_redModel) {
            cell.contentLable.text = _redModel.red_desc;
        }else
        {
            cell.contentLable.text = @"选择红包";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString *cellName = @"COrderChooseRedPacketsTableViewCell";
        COrderChooseRedPacketsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderChooseRedPacketsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.titleLable.text = @"选择支付方式";
        cell.contentLable.hidden = YES;
        cell.arrowImg.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        if (indexPath.row == 0) {
            static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
            COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.titleLable.text = @"雏燕余额支付";
            cell.imgview.image = [UIImage imageNamed:@"Icon-Small@3x"];
            cell.contentLable.text = @"余额不足使用混合支付";
            cell.balanceLable.text = [NSString stringWithFormat:@"%0.2f元",_tempModel.balance];
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
    
    if (indexPath.section == 1) {
        
        RedPacketViewController *redVC = [[RedPacketViewController alloc] init];
        redVC.type = 1;
        redVC.delegate = self;
        [self.navigationController pushViewController:redVC animated:YES];
        
    }else if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            [self userPacketPay];
//            MixedPayViewController *mixedPayVC = [[MixedPayViewController alloc] init];
//            [self.navigationController pushViewController:mixedPayVC animated:YES];
            
        }else if (indexPath.row == 1)
        {
            _type = 1;
            ///支付宝支付
            NSArray *array;
            In_OrderPayModel *inModel = [[In_OrderPayModel alloc] init];
            NSString *hmacString;
            if (!_redModel)
            {
                array = [[NSArray alloc] initWithObjects:@"0",@"1" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,@"",nil];
                hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
                inModel.key = userInfoModel.key;
                inModel.digest = hmacString;
                inModel.coupon_type = 0;
                inModel.coupon_id = @"";
                inModel.pay_type = 1;
                inModel.pay_way = 2;
                inModel.order_id = _tempModel.orderId;
                inModel.user_id = userInfoModel.userId;
                
            }else{
                array = [[NSArray alloc] initWithObjects:@"1",_redModel.redid,@"1" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,nil];
                hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
                inModel.key = userInfoModel.key;
                inModel.digest = hmacString;
                inModel.coupon_type = 1;
                inModel.coupon_id = _redModel.redid;
                inModel.pay_type = 1;
                inModel.pay_way = 2;
                inModel.order_id = _tempModel.orderId;
                inModel.user_id = userInfoModel.userId;
            }
            
            [self thirdPartPayWithArray:inModel];
        }else
        {
            _type = 2;
            ///微信支付
            NSArray *array;
            In_OrderPayModel *inModel = [[In_OrderPayModel alloc] init];
            NSString *hmacString;
            if (!_redModel)
            {
                array = [[NSArray alloc] initWithObjects:@"0",@"3" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,@"",nil];
                hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
                inModel.key = userInfoModel.key;
                inModel.digest = hmacString;
                inModel.coupon_type = 0;
                inModel.coupon_id = @"";
                inModel.pay_type = 3;
                inModel.pay_way = 2;
                inModel.order_id = _tempModel.orderId;
                inModel.user_id = userInfoModel.userId;
                
            }else{
                array = [[NSArray alloc] initWithObjects:@"1",_redModel.redid,@"3" ,[NSString stringWithFormat:@"%d",2],_tempModel.orderId,userInfoModel.userId,nil];
                hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
                inModel.key = userInfoModel.key;
                inModel.digest = hmacString;
                inModel.coupon_type = 1;
                inModel.coupon_id =  _redModel.redid;
                inModel.pay_type = 3;
                inModel.pay_way = 2;
                inModel.order_id = _tempModel.orderId;
                inModel.user_id = userInfoModel.userId;
            }
            [self thirdPartPayWithArray:inModel];
        }
    }
}

//------------------------------------------------------------------------

- (void)userPacketPay
{
    [self.view addSubview:_maskView];
    [self.view addSubview:_inputPwdVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.7;
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT-400, SCREEN_WIDTH, 400);
    } completion: ^(BOOL finish)
    {
        [[iToast makeText:@"输入您的钱包支付密码！"] show];
    }];
    


}

//------------------------------------------------------------------------
- (void)passwordInputWithPWd:(NSString *)pwd
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (!_redModel) {
        NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_tempModel.orderId,[[communcation sharedInstance] getmd5:pwd],@"", nil];
        NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        In_UserPacketPayModel *inModel = [[In_UserPacketPayModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hamcString;
        inModel.user_id = userInfoModel.userId;
        inModel.orderid = _tempModel.orderId;
        inModel.redid = @"";
        inModel.password = [[communcation sharedInstance] getmd5:pwd];

        NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/balance/pay", HOSTURL];
        
        NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:str];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        request.defaultResponseEncoding = NSUTF8StringEncoding;
        [request setPostValue:inModel.key forKey:@"key"];
        [request setPostValue:hamcString forKey:@"digest"];
        [request setPostValue:inModel.orderid forKey:@"orderid"];
        [request setPostValue:inModel.user_id forKey:@"user_id"];
        [request setPostValue:inModel.redid forKey:@"redid"];
        [request setPostValue:inModel.password forKey:@"password"];
        request.shouldAttemptPersistentConnection = NO;
        request.timeOutSeconds = TIMEOUTSECONDS;
        [request startSynchronous];
        NSError *error = [request error];
        if (!error)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSData *jsondata = [request responseData];
            NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
            WReturnDic = ReturnDic;
//            NSLog(@"支付信息>>>>>>>%@",responseString);
            if ([[ReturnDic objectForKey:@"code"] intValue] == 1000) {
                [[iToast makeText:@"您已完成支付,快去评价吧!"] show];
                [self leftItemClick];
                //支付成功回调刷新
                [self.delegate paySuccessBackRefresh];
            }
            else if ([[ReturnDic objectForKey:@"code"] intValue] ==1018){
                
                 [[iToast makeText:[ReturnDic objectForKey:@"message"]] show];
                 [_inputPwdVC pwdWrong];
            }
            else if ([[ReturnDic objectForKey:@"code"] intValue] ==1020){
                 AlertViewFour = [[UIAlertView alloc]initWithTitle:@"提示" message:@"余额不足,是否选择余额支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
                 [AlertViewFour show];
            }

        }

    }else
    {
        NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_tempModel.orderId,[[communcation sharedInstance] getmd5:pwd],_redModel.redid, nil];
        NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        In_UserPacketPayModel *inModel = [[In_UserPacketPayModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hamcString;
        inModel.user_id = userInfoModel.userId;
        inModel.orderid = _tempModel.orderId;
        inModel.redid = _redModel.redid;
        inModel.password = [[communcation sharedInstance] getmd5:pwd];
    
        NSString* InPutUrl = [NSString stringWithFormat:@"%@/order/balance/pay", HOSTURL];
        
        NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:str];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        request.defaultResponseEncoding = NSUTF8StringEncoding;
        [request setPostValue:inModel.key forKey:@"key"];
        [request setPostValue:hamcString forKey:@"digest"];
        [request setPostValue:inModel.orderid forKey:@"orderid"];
        [request setPostValue:inModel.user_id forKey:@"user_id"];
        [request setPostValue:inModel.redid forKey:@"redid"];
        [request setPostValue:inModel.password forKey:@"password"];
        request.shouldAttemptPersistentConnection = NO;
        request.timeOutSeconds = TIMEOUTSECONDS;
        [request startSynchronous];
        NSError *error = [request error];
        if (!error)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSData *jsondata = [request responseData];
            NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
            CReturnDic = ReturnDic;
//            NSLog(@"支付信息>>>>>>>%@",responseString);
            if ([[ReturnDic objectForKey:@"code"] intValue] == 1000) {
                [[iToast makeText:@"您已完成支付,快去评价吧!"] show];
                [self leftItemClick];
                //支付成功回调刷新
                [self.delegate paySuccessBackRefresh];
            }
            else if ([[ReturnDic objectForKey:@"code"] intValue] ==1018){
                
                [[iToast makeText:[ReturnDic objectForKey:@"message"]] show];
                [_inputPwdVC pwdWrong];
            }
            else if ([[ReturnDic objectForKey:@"code"] intValue] ==1020){
                AlertViewFour = [[UIAlertView alloc]initWithTitle:@"提示" message:@"余额不足,是否选择余额支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
                [AlertViewFour show];
            }
            
        }

    }
    
}

///取消输入密码支付
- (void)cancelInputPwd
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.0;
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    } completion: ^(BOOL finish){
        [_maskView removeFromSuperview];
        [_inputPwdVC.view removeFromSuperview];
    }];
}

///忘记密码
- (void)forgetPassword
{
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.0;
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    } completion: ^(BOOL finish){
        [_maskView removeFromSuperview];
        [_inputPwdVC.view removeFromSuperview];
        WalletPasswordViewController *walletPwdVC = [[WalletPasswordViewController alloc] init];
        [self.navigationController pushViewController:walletPwdVC animated:YES];
    }];

}
//------------------------------------------------------------------------

//获取红包回调
- (void)getTheRedWithModel:(Out_RedPacketBody *)model
{
    _redModel = model;
    [_payTableView reloadData];
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
                [self AliPayActionWith:outModel];

                [[iToast makeText:outModel.message] show];
    
            }
        });
        
    });

}
//- (void)AliPayActionWith:(Out_OrderPayModel*)model
//{
//    NSLog(@"3237654234765434444444444");
//
//
////    [request setPostValue:@"2014072300007148" forKey:@"app_id"];
////    [request setPostValue:@"alipay.trade.query" forKey:@"method"];
////    [request setPostValue:@"JSON" forKey:@"format"];
////    [request setPostValue:@"gbk,gb2312等	utf-8" forKey:@"charset"];
//    
////    [request setPostValue:@"RSA" forKey:@"sign_type"];
//    NSString *partner = @"2088301670725526";
//    NSString *seller = @"admin@163.com";
//    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMc/RzV5FyfodVnb4Lwle3SlZ/UhNq8B4tST2vcX2et1NXQp2pnxvbH3q3FOx5BgOEMAP5tJqYtPu6C7tv6FPRy9cI7+T8HudaFvZc+tZ6X7CAzWIKVZIj8+JFnHez3zZ7Cp3gUO81Aq8SOkjhVbWtVCMB+xxL84VdnydzQkY479AgMBAAECgYEApIitnguzwoHkvmKjT9tH+ohIs5VM2fIdxVufmyJ4E0dD7/xMB4ooEtmqGrRqed/rNfDzlaGbv24FS/MXZ1DRp/1tunly2Fs7Pnp8GQsdsB0BiV2LAXPi4ZyYllXR3soMrW76AMQMez6VT9IO91dKH03zsVFquGyYjt65hDUul6ECQQD+NG+eQvHSOAw+Q4UCltgGyKCQhTZfRCZWgyBhWoGPM+6A9voNsTFRXoNy8q+ni1xneDttYRDX2O/+H0PkjWFFAkEAyKd8rNS+00vWKzkafiEuU4cGI6a0s5Bj2E6uNlFNzT3LO/HX8N8NVoRG3CjbAh+U+JSxLeCryuuO+sxuqyKmWQJAHUfy93rkmf9kwaNLZfH0Lkvb2unNSonyFJMEHtKrC9DCj05jnUIk2SeW4p27yAPQgAakacP9ia9ubYoyatgyNQJAKV0NgHti0yABCGv/IB0q9aESDOtiuNl9G6wskZn1Feg1KyhRwZ/ZmgouqVfqvedQyGWumKyF/ZDNqrnV3oWIEQJAfCxrL0BqChITmpM7vRNm+Ia1KJnaOFKvx3VMyrexiPK8nATqs6mvYUqClT7Fh9f1vC2Y4KAKVtMrid09TekgLw==";
//    
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:@"2016042001316341" forKey:@"app_id"];
//    [dic setObject:@"alipay.trade.pay" forKey:@"method"];
//    [dic setObject:@"JSON" forKey:@"format"];
//    [dic setObject:@"utf-8" forKey:@"charset"];
//    [dic setObject:@"RSA" forKey:@"sign_type"];
//    [dic setObject:@"2014-07-24 03:07:50" forKey:@"timestamp"];
//    [dic setObject:@"1.0" forKey:@"version"];
//    [dic setObject:@"http://api.test.alipay.net/atinterface/receive_notify.htm" forKey:@"notify_url"];
////    [dic setObject:diccc forKey:@"biz_content"];
//    NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
//
//    [dic2 setObject:@"20150320010101001" forKey:@"out_trade_no"];
//    [dic2 setObject:@"bar_code" forKey:@"scene"];
//    
//    [dic2 setObject:@"28763443825664394" forKey:@"auth_code"];
//    
//    [dic2 setObject:@"Iphone6 16G" forKey:@"subject"];
//    
//    [dic2 setObject:@"0.01" forKey:@"total_amount"];
//    
//
//    NSDictionary *biz_contentDic=@{@"20150320010101001":@"out_trade_no"};
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [dic2 description];
//    NSLog(@"orderSpec = %@",orderSpec);
//
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    NSString* InPutUrl = [NSString stringWithFormat:@"https://openapi.alipay.com/gateway.do?timestamp=2013-01-01 08:08:08&method=alipay.trade.query&app_id=2016042001316341&sign_type=RSA&sign=%@&version=1.0@biz_content=%@",signedString,biz_contentDic];
//    
//    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL *url = [NSURL URLWithString:str];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    request.defaultResponseEncoding = NSUTF8StringEncoding;
////    [request setPostValue:signedString forKey:@"sign"];
////    [request setPostValue:@"2014-07-24 03:07:50" forKey:@"timestamp"];
////    [request setPostValue:@"1.0" forKey:@"version"];
////    NSDictionary *dic=@{@"20150320010101001":@"trade_no"};
//    [request setPostValue:@"20150320010101001" forKey:@"out_trade_no"];
//    [request setPostValue:@"bar_code" forKey:@"scene"];
//
//    [request setPostValue:@"28763443825664394" forKey:@"auth_code"];
//
//    [request setPostValue:@"Iphone6 16G" forKey:@"subject"];
//
//    [request setPostValue:@"0.01" forKey:@"total_amount"];
//
//    
////
//
//    
////    [request setPostValue:@"<#string#>" forKey:@"version"];
////    [request setPostValue:@"<#string#>" forKey:@"version"];
//
//    request.shouldAttemptPersistentConnection = NO;
//    request.timeOutSeconds = TIMEOUTSECONDS;
//    [request startSynchronous];
//    NSError *error = [request error];
//
//    NSData *jsondata = [request responseData];
//        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
//        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
//        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        NSDictionary *ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
//        NSLog(@"ReturnDicReturnDic%@",ReturnDic);
//
//        if (ReturnDic) {
//            Out_OrderPayModel *outModel = [[Out_OrderPayModel alloc] initWithDictionary:ReturnDic error:nil];
//        }else{
//
//        }
//        
//    
//    }

- (void)AliPayActionWith:(Out_OrderPayModel*)model
{
  
 NSString *partner = @"2088401564739629";
    NSString *seller = @"cbwlyx@163.com";
NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMc/RzV5FyfodVnb4Lwle3SlZ/UhNq8B4tST2vcX2et1NXQp2pnxvbH3q3FOx5BgOEMAP5tJqYtPu6C7tv6FPRy9cI7+T8HudaFvZc+tZ6X7CAzWIKVZIj8+JFnHez3zZ7Cp3gUO81Aq8SOkjhVbWtVCMB+xxL84VdnydzQkY479AgMBAAECgYEApIitnguzwoHkvmKjT9tH+ohIs5VM2fIdxVufmyJ4E0dD7/xMB4ooEtmqGrRqed/rNfDzlaGbv24FS/MXZ1DRp/1tunly2Fs7Pnp8GQsdsB0BiV2LAXPi4ZyYllXR3soMrW76AMQMez6VT9IO91dKH03zsVFquGyYjt65hDUul6ECQQD+NG+eQvHSOAw+Q4UCltgGyKCQhTZfRCZWgyBhWoGPM+6A9voNsTFRXoNy8q+ni1xneDttYRDX2O/+H0PkjWFFAkEAyKd8rNS+00vWKzkafiEuU4cGI6a0s5Bj2E6uNlFNzT3LO/HX8N8NVoRG3CjbAh+U+JSxLeCryuuO+sxuqyKmWQJAHUfy93rkmf9kwaNLZfH0Lkvb2unNSonyFJMEHtKrC9DCj05jnUIk2SeW4p27yAPQgAakacP9ia9ubYoyatgyNQJAKV0NgHti0yABCGv/IB0q9aESDOtiuNl9G6wskZn1Feg1KyhRwZ/ZmgouqVfqvedQyGWumKyF/ZDNqrnV3oWIEQJAfCxrL0BqChITmpM7vRNm+Ia1KJnaOFKvx3VMyrexiPK8nATqs6mvYUqClT7Fh9f1vC2Y4KAKVtMrid09TekgLw==";
    
    
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
        order.amount = [NSString stringWithFormat:@"0.01"];//test
//    order.amount = [NSString stringWithFormat:@"%.2f",model.data.payOrder.amount]; //商品价格
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
//             NSLog(@"reslut是 = %@",resultDic);
             if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000){
                 AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [AlertViewOne show];
             }
             else{
                 AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付失败,是否继续支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
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

//导航栏左右侧按钮点击
- (void)leftItemClick{
    
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == AlertViewOne) {
        if (buttonIndex ==0){
            [self leftItemClick];
            [self.delegate paySuccessBackRefresh];
        }
    }
    if (alertView == AlertViewTwo) {
        if (alertView == AlertViewTwo) {
            if (buttonIndex ==0) {
                [self leftItemClick];
                [self.delegate paySuccessBackRefresh];
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
    if (alertView == AlertViewFour) {
        if (buttonIndex ==0) {
            [self cancelInputPwd];
        }else
        {
            [self cancelInputPwd];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            YuEZhiFuViewController *YuE = [[YuEZhiFuViewController alloc]init];
            YuE.orderid = _orderId;
            if (!_redModel) {
                YuE.ReturnDic = WReturnDic;
                
            }
            else{
                YuE.ReturnDic = CReturnDic;
                YuE.redModel = _redModel;
            }
            [app.menuViewController pushToNewViewController:YuE animation:YES];
        }
        
    }
}

@end
