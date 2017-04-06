//
//  LogisticsPayViewController.m
//  HSApp
//
//  Created by xc on 16/1/27.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LogisticsPayViewController.h"
#import "COrderPayTypeChooseTableViewCell.h"
#import "LQRCodePayViewController.h"

#import "iToast.h"

#import "MBProgressHUD.h"
#import "UserInfoSaveModel.h"
#import "communcation.h"
#import "TiaoMaPayVController.h"//支付宝当面付   条码支付



@interface LogisticsPayViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) NSString *branchname;
@property (nonatomic, strong) UIView *moneyTipView;
@property (nonatomic, strong) UILabel *moneyNumLabel;

@property (nonatomic, strong) UITableView *payTableivew;
@property (nonatomic, strong) UIAlertView *cashPayAlert;//现金反馈
@property (nonatomic, strong) UIAlertView *shopAlert;//商家扫码

//@property (nonatomic,copy)NSString *dataImageString;
@end

@implementation LogisticsPayViewController

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
        _titleLabel.text = @"待付款";
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
    
    if (!_moneyTipView) {
        _moneyTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _moneyTipView.backgroundColor = ViewBgColor;
    }
    
    if (!_moneyNumLabel) {
        _moneyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,50)];
        _moneyNumLabel.backgroundColor = [UIColor clearColor];
        _moneyNumLabel.font = LargeFont;
        _moneyNumLabel.textColor = TextMainCOLOR;
        if ([_tempModel.cwbordertypeid intValue]==1) {
            _moneyNumLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",[_tempModel.cod floatValue]];
            LQRCodePayViewController *QRCodePayVC = [[LQRCodePayViewController alloc] init];
            QRCodePayVC.money=[_tempModel.cod floatValue];
        }
        else if ([_tempModel.cwbordertypeid intValue]==3){
            if (_tempModel.paybackfee <0) {
//                 _moneyNumLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",-_tempModel.cod];
                if (_tempModel.cod==0){
                    _moneyNumLabel.text = @"待收款:%0.00元";
                }
                else{
                    _moneyNumLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",-[_tempModel.cod floatValue]];
                }

                LQRCodePayViewController *QRCodePayVC = [[LQRCodePayViewController alloc] init];
                QRCodePayVC.money=[_tempModel.cod floatValue];
            }
            else if (_tempModel.paybackfee >0) {
                if (_tempModel.cod==0){
                _moneyNumLabel.text = @"待退款:%0.00元";
                }
                else{
                    _moneyNumLabel.text = [NSString stringWithFormat:@"待退款:%0.2f元",-[_tempModel.cod floatValue]];
                }
                LQRCodePayViewController *QRCodePayVC = [[LQRCodePayViewController alloc] init];
                QRCodePayVC.money=[_tempModel.cod floatValue];
            }

        }
        _moneyNumLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _moneyNumLabel.textAlignment = NSTextAlignmentCenter;
        [_moneyTipView addSubview:_moneyNumLabel];
    }
    
    [self inithomeTableView];
    [self.view addSubview:_payTableivew];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化table
-(UITableView *)inithomeTableView
{
    if (_payTableivew != nil) {
        return _payTableivew;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.payTableivew = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _payTableivew.delegate = self;
    _payTableivew.dataSource = self;
    _payTableivew.backgroundColor = ViewBgColor;
    _payTableivew.showsVerticalScrollIndicator = NO;
    return _payTableivew;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if ([userInfoModel.companycode isEqualToString:@"chuyan"]){
    return 4;
    }
    else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return _moneyTipView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (indexPath.row == 0) {
        static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
        COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.titleLable.text = @"支付宝支付";
        cell.imgview.image = [UIImage imageNamed:@"licon_zhifubao"];
        cell.contentLable.text = @"推荐有支付宝账号的用户使用";
        cell.balanceLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
        COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.titleLable.text = @"现金支付";
        cell.imgview.image = [UIImage imageNamed:@"licon_cash"];
        cell.contentLable.text = @"支持现金支付";
        cell.balanceLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 2 && [userInfoModel.companycode isEqualToString:@"chuyan"])
    {
        static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
        COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.titleLable.text = @"商家扫码";
        cell.imgview.image = [UIImage imageNamed:@"shoperScape"];
        cell.contentLable.text = @"仅限面单扫码支付签收";
        cell.balanceLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        static NSString *cellName = @"COrderPayTypeChooseTableViewCell";
        COrderPayTypeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[COrderPayTypeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.titleLable.text = @"银行卡支付";
        cell.imgview.image = [UIImage imageNamed:@"licon_Bank"];
        cell.contentLable.text = @"仅支持储蓄卡支付";
        cell.balanceLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    

    if (indexPath.row == 0) {
//        [self getPersonInfo];
        
        [self goDingDang];


    }else if (indexPath.row == 1)
    {
        NSString *codstr = nil;
        if ([_tempModel.cwbordertypeid intValue]==1) {
            
            codstr = [NSString stringWithFormat:@"待收金额：%0.2f元",[_tempModel.cod floatValue]];

            
        }
        else if ([_tempModel.cwbordertypeid intValue]==3){
             codstr = [NSString stringWithFormat:@"待收金额：%0.2f元",-[_tempModel.cod floatValue]];
        


        }
        _cashPayAlert = [[UIAlertView alloc] initWithTitle:codstr message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"否",@"是", nil];
        [_cashPayAlert show];
    }else if (indexPath.row == 2 && [userInfoModel.companycode isEqualToString:@"chuyan"])
    {
        
        _shopAlert = [[UIAlertView alloc] initWithTitle:@"商家扫码" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"否",@"是", nil];
        [_shopAlert show];

    }
    else
    {
        [[iToast makeText:@"功能开发中,敬请期待"] show];
    }
}
#pragma mark 生成二维码信息
-(void)goDingDang{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    
    NSString *hamcString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LPersonInfoModel *outModel = [[communcation sharedInstance] getPersonInfoWith:userInfoModel.userId andDigest:hamcString];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                
                _branchname= outModel.data.branchname;
                
                [self getPersonInfo];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

    
    /***************************************/
  


}
- (void)getPersonInfo
{
//    LQRCodePayViewController *QRCodePayVC = [[LQRCodePayViewController alloc] init];
    TiaoMaPayVController *QRCodePayVC = [[TiaoMaPayVController alloc] init];

    NSString *personInfo=[NSString stringWithFormat:@"电商名字-%@-站点名称-%@-小件员姓名-%@",_tempModel.dssnname, _branchname ,_tempModel.realname];
    NSUserDefaults *userDefault2 = [NSUserDefaults standardUserDefaults];
    NSData *userData2 = [userDefault2 objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel2 = [NSKeyedUnarchiver unarchiveObjectWithData:userData2];
    
    NSArray *KeyArr2 = [[NSArray alloc]initWithObjects:_tempModel.cwb,personInfo,nil];
    NSString *hamcString2 = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr2];
    
    In_ScanModel *inModel2 = [[In_ScanModel alloc] init];
    
    inModel2.key = userInfoModel2.key;
    inModel2.digest = hamcString2;
    inModel2.trade_no = _tempModel.cwb;
    
    inModel2.subjectName =personInfo;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        out_ScanModel *outModel2 = [[communcation sharedInstance]scanErWeiMaWithInModel:inModel2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel2)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                return ;
                
            }
            else if (outModel2.code ==1000)
            {
                QRCodePayVC.dataImage=outModel2.data;
                QRCodePayVC.money=[_tempModel.cod floatValue];
                QRCodePayVC.signName=self.signmanOther;
                QRCodePayVC.tempModel = _tempModel;
                QRCodePayVC.signType=self.signType;
                [self.navigationController pushViewController:QRCodePayVC animated:YES];
            }
            else{
                [[iToast makeText:outModel2.message] show];
                
            }
        });
        
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==_cashPayAlert){
    if (buttonIndex == 0) {

    }
    
    if (buttonIndex == 1) {
        
        [self FeedbackOrderidWithModel:1];
    }
    }
    else if (alertView==_shopAlert){
        if (buttonIndex == 1) {
            
            [self FeedbackOrderidWithModel:6];
        }

    }
}

- (void)FeedbackOrderidWithModel:(int)payWay{
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"反馈中...";
    In_FeedbackOrderidWithModel *InModel = [[In_FeedbackOrderidWithModel alloc]init];

    NSDate *NowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *NowTime = [formatter stringFromDate:NowDate];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *KeyArr =nil;
    
    if (![self.signmanOther isEqualToString:@""  ]&(self.signmanOther.length>0)) {
        KeyArr  = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",payWay],[NSString stringWithFormat:@"%f",[_tempModel.cod floatValue]],self.signmanOther,NowTime,@"",@"",[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",2],_tempModel.cwb,nil];

        InModel.signman=self.signmanOther;
        InModel.signtypeid=2;
    }
    else{
        KeyArr  = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",payWay],[NSString stringWithFormat:@"%f",[_tempModel.cod floatValue]],_tempModel.consigneename,NowTime,@"",@"",[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",1],_tempModel.cwb,nil];

        InModel.signman = _tempModel.consigneename;
        InModel.signtypeid=1;


    }
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr];

    InModel.key = userInfoModel.key;
    InModel.digest = hamcString;
    InModel.cwbs = _tempModel.cwb;
    InModel.cwbordertypeid = [_tempModel.cwbordertypeid intValue];
    InModel.deliverystate = 2;
    InModel.paywayid = payWay;
    InModel.cash = [_tempModel.cod floatValue];
    InModel.signtime = NowTime;
    InModel.exptioncode = @"";
    InModel.nextdispatchtime = @"";
    InModel.terminaltype = 2;
    InModel.postrace=_tempModel.cwb;
    InModel.traceno=_tempModel.cwb;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_FeedbackOrderidWithModel *outModel = [[communcation sharedInstance] getFeedBackWithModel:InModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                
                AlertViewOne = [[UIAlertView alloc]initWithTitle:@"用户提示" message:@"反馈成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [AlertViewOne show];
                
                [self leftItemClick];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
            
        });
        
    });
    
}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    
    UIViewController *vc = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:vc animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}

@end
