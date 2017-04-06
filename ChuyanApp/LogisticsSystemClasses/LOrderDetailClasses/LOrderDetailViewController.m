//
//  LOrderDetailViewController.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LOrderDetailViewController.h"
#import "LOrderDetailTableViewCell.h"
#import "LoginViewController.h"
#import "LSendGoodsViewController.h"
#import "LOtherSignViewController.h"
#import "LogisticsPayViewController.h"
#import "LOrderProblemListViewController.h"
#import "LSendMsgViewController.h"
#import "MapRoaldVController.h"


@interface LOrderDetailViewController ()<LOrderSignProblemDelegate,LOtherSignDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
    Out_LOrderDetailBody *_tempModel;
    int signType;//1 本人签收  2 他人签收  3 自提柜
    UIAlertView *AlertViewOne;
    NSString * _name;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UITableView *goodsTableview;
@property (nonatomic, strong)  BMKLocationService *locService ;
@property (nonatomic, strong) UIView *orderDealView;
@property (nonatomic, strong) UIButton *callPhoneBtn;
@property (nonatomic, strong) UIButton *sendMsgBtn;
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UIButton *problemBtn;
@property (nonatomic, strong) UIButton *signOrderBtn;

@property (nonatomic, strong) UIAlertView *signAntherAlert;

@property (nonatomic, strong) UIAlertView *signAlertView;
@property (nonatomic, strong) UIAlertView *problemAlertView;
@property (nonatomic, strong) BMKGeoCodeSearch *searchAdress;

@end

@implementation LOrderDetailViewController

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
        _titleLabel.text = @"订单详情";
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
    
    if (!_orderDealView) {
        _orderDealView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148)];
        _orderDealView.backgroundColor = ViewBgColor;
        _orderDealView.userInteractionEnabled = YES;
    }
    
    
    if (!_callPhoneBtn) {
        _callPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _callPhoneBtn.frame = CGRectMake(20, 20,85, 44);
        _callPhoneBtn.backgroundColor = WhiteBgColor;
        [_callPhoneBtn setImage:[UIImage imageNamed:@"btn_phone"] forState:UIControlStateNormal];
        _callPhoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-15,0,0);
        [_callPhoneBtn setTitle:@"电话" forState:UIControlStateNormal];
        _callPhoneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _callPhoneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_callPhoneBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _callPhoneBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _callPhoneBtn.layer.borderWidth = 0.5;
        _callPhoneBtn.layer.cornerRadius = 5;
        _callPhoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_callPhoneBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];//
        _callPhoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_callPhoneBtn addTarget:self action:@selector(callPhoneClick) forControlEvents:UIControlEventTouchUpInside];
        [_orderDealView addSubview:_callPhoneBtn];
    }
    
    if (!_sendMsgBtn) {
        _sendMsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendMsgBtn.frame = CGRectMake((SCREEN_WIDTH-40-85*3)/2+20+85, 20,85, 44);
        _sendMsgBtn.backgroundColor = WhiteBgColor;
        [_sendMsgBtn setImage:[UIImage imageNamed:@"licon_message"] forState:UIControlStateNormal];
        _sendMsgBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-15,0,0);
        [_sendMsgBtn setTitle:@"短信" forState:UIControlStateNormal];
        _sendMsgBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _sendMsgBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_sendMsgBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _sendMsgBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _sendMsgBtn.layer.borderWidth = 0.5;
        _sendMsgBtn.layer.cornerRadius = 5;
        _sendMsgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_sendMsgBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];//
        _sendMsgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_sendMsgBtn addTarget:self action:@selector(sendMsgClick) forControlEvents:UIControlEventTouchUpInside];
        [_orderDealView addSubview:_sendMsgBtn];
    }
    
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake((SCREEN_WIDTH-40-85*3)/2*2+20+85*2, 20,85, 44);
        _locationBtn.backgroundColor = WhiteBgColor;
        [_locationBtn setImage:[UIImage imageNamed:@"btn_location"] forState:UIControlStateNormal];
        _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-15,0,0);
        [_locationBtn setTitle:@"导航" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _locationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_locationBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _locationBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _locationBtn.layer.borderWidth = 0.5;
        _locationBtn.layer.cornerRadius = 5;
        _locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_locationBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];//
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
        [_orderDealView addSubview:_locationBtn];
    }
    
    
    
    if (!_problemBtn) {
        _problemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _problemBtn.frame = CGRectMake(20, 84,85, 44);
        [_problemBtn setTitle:@"异常" forState:UIControlStateNormal];
        [_problemBtn addTarget:self action:@selector(problemClick) forControlEvents:UIControlEventTouchUpInside];
        _problemBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _problemBtn.layer.borderWidth = 0.5;
        _problemBtn.layer.cornerRadius = 5;
        [_problemBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _problemBtn.backgroundColor = WhiteBgColor;
        _problemBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_orderDealView addSubview:_problemBtn];
    }
    
    if (!_signOrderBtn) {
        _signOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _signOrderBtn.frame = CGRectMake(SCREEN_WIDTH-105, 84,85, 44);
        [_signOrderBtn setTitle:@"签收" forState:UIControlStateNormal];
        [_signOrderBtn addTarget:self action:@selector(signOrderClick) forControlEvents:UIControlEventTouchUpInside];
        _signOrderBtn.layer.borderColor = MAINCOLOR.CGColor;
        _signOrderBtn.layer.borderWidth = 0.5;
        _signOrderBtn.layer.cornerRadius = 5;
        [_signOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _signOrderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _signOrderBtn.backgroundColor = WhiteBgColor;
        [_orderDealView addSubview:_signOrderBtn];
    }
    
    [self inithomeTableView];
    [self.view addSubview:_goodsTableview];
    signType=1;//默认本人签收
    
    [self getOrderDetail];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

//初始化table
-(UITableView *)inithomeTableView
{
    if (_goodsTableview != nil) {
        return _goodsTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.goodsTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _goodsTableview.delegate = self;
    _goodsTableview.dataSource = self;
    _goodsTableview.backgroundColor = ViewBgColor;
    _goodsTableview.showsVerticalScrollIndicator = NO;
    return _goodsTableview;
}
#pragma  mark 获取订单详情数据

- (void)getOrderDetail
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    
    NSString *hamcString = [[communcation sharedInstance] hmac:_orderId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LOrderDetailModel *outModel = [[communcation sharedInstance] getLOrderDetailWith:userInfoModel.userId andDigest:hamcString andOrder:_orderId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            DLog(@"*********%@",outModel);
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }
            
            //            int codee=[outModel.code intValue];
            else if ([[NSString stringWithFormat:@"%d",outModel.code] isEqualToString:@"1000"])
            {
                _tempModel = outModel.data;
                DLog(@"*//*/*/*//性情%@",outModel
                      );
                DLog(@"*//*/*/*//性情%lu",(unsigned long)_tempModel.exptmsg.length);
                //                NSLog(@"5.29上门退%@",outModel.data);
                //                NSLog(@"5.29上门退_tempmodel%@",_tempModel);
                //订单状态 （-1失效订单 0导入数据 1领货 2配送成功 3滞留 4拒收）
                if ([_tempModel.state intValue]!= 1 ||_tempModel.exptmsg.length!=0) {
                    _problemBtn.backgroundColor = ButtonBGCOLOR;
                    _signOrderBtn.backgroundColor = ButtonBGCOLOR;
                    _problemBtn.enabled = NO;
                    _signOrderBtn.enabled = NO;
                }else
                {
                    _problemBtn.backgroundColor = WhiteBgColor;
                    _signOrderBtn.backgroundColor = WhiteBgColor;
                    _problemBtn.enabled = YES;
                    _signOrderBtn.enabled = YES;
                }
                [_goodsTableview reloadData];
                
                if ([_tempModel.cwbordertypeid  intValue]==1) {
                    [_signOrderBtn setTitle:@"签收" forState:UIControlStateNormal];
                }
                if ([_tempModel.cwbordertypeid intValue]==2) {
                    [_signOrderBtn setTitle:@"上门退" forState:UIControlStateNormal];
                }
                if ([_tempModel.cwbordertypeid intValue]==3) {
                    [_signOrderBtn setTitle:@"上门换" forState:UIControlStateNormal];
                }
                
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
}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LOrderDetailTableViewCell *cell = [[LOrderDetailTableViewCell alloc] init];

    return [cell CellHeight:_tempModel];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 148;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return _orderDealView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identCell = @"LOrderDetailTableViewCell";
    LOrderDetailTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
    
    if (cell == nil) {
        cell = [[LOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
    }

    cell.KindType = _KindType;
    
    [cell setModel:_tempModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)callPhoneClick
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_tempModel.consigneemobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)sendMsgClick
{
    LSendMsgViewController *sendMsgVC = [[LSendMsgViewController alloc] init];
    sendMsgVC.mobileStr = _tempModel.consigneemobile;
    sendMsgVC.nameStr = _tempModel.consigneename;
    [self.navigationController pushViewController:sendMsgVC animated:YES];
    
}
#pragma mark    ------导航按钮点击------ 传入地址--
- (void)locationClick
{
    MBProgressHUD *hud=[[MBProgressHUD alloc]init];
    hud.labelText=@"导航中...";
    _searchAdress =[[BMKGeoCodeSearch alloc]init];
    _searchAdress.delegate = self;
    BMKGeoCodeSearchOption *geoCodeOption = [[BMKGeoCodeSearchOption alloc]init];
    
    if ([_tempModel.consigneeaddress rangeOfString:[_name substringToIndex:_name.length - 1]].location != NSNotFound) {
      geoCodeOption.address = _tempModel.consigneeaddress;
    }else{
       NSString *string = [_name stringByAppendingString:_tempModel.consigneeaddress];
        geoCodeOption.address = string;
    }
    BOOL flagAdd = [_searchAdress geoCode:geoCodeOption];
    if(flagAdd)
    {
        DLog(@"geo检索发送成功");
    }else{
        DLog(@"geo检索发送失败");
    }
}

#pragma mark 定位
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        
        item.title = result.address;
        MapRoaldVController*map =[[MapRoaldVController alloc]init];
        if ([_tempModel.consigneeaddress rangeOfString:[_name substringToIndex:_name.length - 1]].location != NSNotFound) {
            map.address = _tempModel.consigneeaddress;
        }else{
            NSString *string = [_name stringByAppendingString:_tempModel.consigneeaddress];
            map.address = string;
        }
        map. templatitude = item.coordinate.latitude;
        map.templongitude = item.coordinate.longitude;
        
        self.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController presentViewController:map animated:YES completion:nil];
//        [self.navigationController pushViewController:map animated:YES];
    }
}

- (void)problemClick
{
    NSString *str;
    if ([_tempModel.cwbordertypeid  intValue]==1) {
        str = @"拒收";
    }
    if ([_tempModel.cwbordertypeid intValue]==2) {
        str = @"拒退";
    }
    
    if ([_tempModel.cwbordertypeid intValue] ==3) {
        str = @"拒换";
    }
    _problemAlertView = [[UIAlertView alloc] initWithTitle:@"异常原因?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:str,@"滞留",@"取消", nil];
    [_problemAlertView show];
    
}

- (void)signOrderClick
{
    
    if ([_tempModel.cod floatValue]==0.00){
    
    _signAntherAlert  = [[UIAlertView alloc] initWithTitle:@"是否本人签收?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"他人签收",@"本人签收",@"自提柜",@"取消签收", nil];
        [_signAntherAlert show];
    }
    else{
        _signAlertView  = [[UIAlertView alloc] initWithTitle:@"是否本人签收?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"他人签收",@"本人签收",@"取消签收", nil];
        [_signAlertView show];
  
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    // 异常件
    if (alertView == _problemAlertView) {
        if (buttonIndex == 0) {
            if ([_tempModel.cwbordertypeid  intValue] == 1) {
                LOrderProblemListViewController *problemVC = [[LOrderProblemListViewController alloc] init];
                problemVC.tempModel = _tempModel;
                problemVC.TypeStr = @"拒收";
                [self.navigationController pushViewController:problemVC animated:YES];
                [problemVC getExptReasonWithType:1];
            }
            else if ([_tempModel.cwbordertypeid intValue] == 2){
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                NSData *userData = [userDefault objectForKey:UserKey];
                UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
                if ([userInfoModel.companycode isEqualToString:@"chuyan"]) {
                    LOrderProblemListViewController *problemVC = [[LOrderProblemListViewController alloc] init];
                    problemVC.tempModel = _tempModel;
                    problemVC.TypeStr = @"拒收";
                    [self.navigationController pushViewController:problemVC animated:YES];
                    [problemVC getExptReasonWithType:1];
                    
                }else{
                    [self FeedbackOrderidWithModelWithST];                }
            }else if ([_tempModel.cwbordertypeid intValue] ==3){
                LOrderProblemListViewController *problemVC = [[LOrderProblemListViewController alloc] init];
                problemVC.tempModel = _tempModel;
                problemVC.TypeStr = @"拒收";
                [self.navigationController pushViewController:problemVC animated:YES];
                [problemVC getExptReasonWithType:1];
            }
        }
        
        if (buttonIndex == 1) { // 滞留
            LOrderProblemListViewController *problemVC = [[LOrderProblemListViewController alloc] init];
            problemVC.tempModel = _tempModel;
            problemVC.TypeStr = @"滞留";
            [self.navigationController pushViewController:problemVC animated:YES];
            [problemVC getExptReasonWithType:2];
        }
        
    }
    else if (alertView == _signAlertView) // 签收
    {
        if (buttonIndex == 0) { // 他人
            LOtherSignViewController *otherSignVC = [[LOtherSignViewController alloc] init];
            otherSignVC.tempModel = _tempModel;
            [self.navigationController pushViewController:otherSignVC animated:YES];
        }
        
      else  if (buttonIndex == 1) { // 本人
            //          1  配送   2上门退  3上门换
            if ([_tempModel.cwbordertypeid intValue] ==1) {
                if ([_tempModel.cod floatValue] ==0.00) {
                    signType=1;
                    [self FeedbackOrderidWithModel];
                }
                else{
                    LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
                    payVC.tempModel = _tempModel;
                    payVC.signType=1;
                    payVC.signmanOther=_tempModel.consigneename;
                    [self.navigationController pushViewController:payVC animated:YES];
                }
            }
            else if ([_tempModel.cwbordertypeid  intValue]==2) {
                signType=1;

                [self FeedbackOrderidWithModel];
            }
            else   if ([_tempModel.cwbordertypeid intValue] ==3) {
                
                if ([_tempModel.paybackfee floatValue]==0.00) {
                    signType=1;

                    [self FeedbackOrderidWithModel];
                }
                else if (_tempModel.paybackfee > 0) {
                    signType=1;

                    [self FeedbackOrderidWithModel];
                }
                else if (_tempModel.paybackfee <0) {
                    LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
                    payVC.tempModel = _tempModel;
                    payVC.signType=1;
                    payVC.signmanOther=_tempModel.consigneename;

                    [self.navigationController pushViewController:payVC animated:YES];
                }
            }
            
        }

        
    }
    else if (alertView == _signAntherAlert) // 自提柜签收{
    {
        if (buttonIndex == 0) { // 他人
            LOtherSignViewController *otherSignVC = [[LOtherSignViewController alloc] init];
            otherSignVC.tempModel = _tempModel;
            [self.navigationController pushViewController:otherSignVC animated:YES];
        }
        
        else  if (buttonIndex == 1) { // 本人
            //          1  配送   2上门退  3上门换
            if ([_tempModel.cwbordertypeid intValue] ==1) {
                if ([_tempModel.cod floatValue] ==0.00) {
                    signType=1;
                    [self FeedbackOrderidWithModel];
                }
                else{
                    LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
                    payVC.tempModel = _tempModel;
                    payVC.signType=1;
                    payVC.signmanOther=_tempModel.consigneename;

                    [self.navigationController pushViewController:payVC animated:YES];
                }
            }
            else if ([_tempModel.cwbordertypeid  intValue]==2) {
                signType=1;
                
                [self FeedbackOrderidWithModel];
            }
            else   if ([_tempModel.cwbordertypeid intValue] ==3) {
                
                if ([_tempModel.paybackfee floatValue]==0.00) {
                    signType=1;
                    
                    [self FeedbackOrderidWithModel];
                }
                else if (_tempModel.paybackfee > 0) {
                    signType=1;
                    
                    [self FeedbackOrderidWithModel];
                }
                else if (_tempModel.paybackfee <0) {
                    LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
                    payVC.tempModel = _tempModel;
                    payVC.signType=1;
                    payVC.signmanOther=_tempModel.consigneename;

                    [self.navigationController pushViewController:payVC animated:YES];
                }
            }
            
        }
        else if (buttonIndex==2){//zitigu自提柜
            //            配送   2上门退  3上门换
            if ([_tempModel.cwbordertypeid intValue] ==1) {
                if ([_tempModel.cod floatValue] ==0.00) {
                    signType=3;

                    [self FeedbackOrderidWithModel];
                }
                else{
                    LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
                    payVC.tempModel = _tempModel;
                    payVC.signType=3;
                    [self.navigationController pushViewController:payVC animated:YES];
                }
            }
            else if ([_tempModel.cwbordertypeid  intValue]==2) {
                signType=3;

                [self FeedbackOrderidWithModel];
            }
            else   if ([_tempModel.cwbordertypeid intValue] ==3) {
                
                if ([_tempModel.paybackfee floatValue]==0.00) {
                    signType=3;

                    [self FeedbackOrderidWithModel];
                }
                else if (_tempModel.paybackfee > 0) {
                    signType=3;

                    [self FeedbackOrderidWithModel];
                }
                else if (_tempModel.paybackfee <0) {
                    LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
                    payVC.tempModel = _tempModel;
                    payVC.signType=3;
                    [self.navigationController pushViewController:payVC animated:YES];
                }
            }
        }
    }

    if (alertView == AlertViewOne) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (alertView.tag==200) {
        if (buttonIndex==1) {
            if (alertView.tag==200){
                if (buttonIndex==1) {
                    LoginViewController *login=[[LoginViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                    
                }
                
                
            }
        }
    }
    
}

- (void)FeedbackOrderidWithModel{
    
    //    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    mbp.labelText = @"反馈中...";
    ///***签收名字
    NSString *signName;
    if ( signType==1) {
        signName=_tempModel.consigneename;
    }
    else if(signType==3){
        signName=@"自提柜";
    }
    
    NSDate *NowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *NowTime = [formatter stringFromDate:NowDate];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *KeyArr = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%@",_tempModel.cwbordertypeid],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%@",_tempModel.payway],[NSString stringWithFormat:@"%@",_tempModel.cod],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",signType],signName,NowTime,@"",@"",_tempModel.cwb,_tempModel.cwb,nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr];
    
    In_FeedbackOrderidWithModel *InModel = [[In_FeedbackOrderidWithModel alloc]init];
    InModel.key = userInfoModel.key;
    InModel.digest = hamcString;
    InModel.cwbs = _tempModel.cwb;
    InModel.cwbordertypeid = [_tempModel.cwbordertypeid intValue];
    InModel.deliverystate = 2;
    InModel.paywayid = [_tempModel.payway intValue];
    InModel.cash = [_tempModel.paybackfee floatValue];
    InModel.signman = signName;
    InModel.signtime = NowTime;
    InModel.exptioncode = @"";
    InModel.nextdispatchtime = @"";
    InModel.terminaltype = 2;
    InModel.postrace =_tempModel.cwb;
    InModel.traceno =_tempModel.cwb;
    InModel.signtypeid=signType;
    // postrace
    // traceno
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_FeedbackOrderidWithModel *outModel = [[communcation sharedInstance] getFeedBackWithModel:InModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
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

- (void)FeedbackOrderidWithModelWithST{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *KeyArr = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%@",_tempModel.cwbordertypeid],[NSString stringWithFormat:@"%d",4],[NSString stringWithFormat:@"%d",0],[NSString stringWithFormat:@"%d",0],@"",@"",@"",@"",[NSString stringWithFormat:@"%d",2],_tempModel.cwb,_tempModel.cwb,nil];
    
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr];
    
    In_FeedbackOrderidWithModel *InModel = [[In_FeedbackOrderidWithModel alloc]init];
    
    InModel.key = userInfoModel.key;
    //          NSLog(@"key>>>>>>>>>>>%@", InModel.key);
    InModel.digest = hamcString;
    //          NSLog(@"digest>>>>>>>>>>>%@", InModel.digest);
    InModel.cwbs = _tempModel.cwb;
    
    InModel.cwbordertypeid = [_tempModel.cwbordertypeid intValue];
    
    InModel.deliverystate = 4;
    
    InModel.paywayid = 0;
    
    InModel.cash = 0;
    
    
    InModel.signman = @"";
    InModel.signtime = @"";
    
    InModel.exptioncode = @"";
    InModel.nextdispatchtime = @"";
    
    InModel.terminaltype = 2;
    InModel.postrace =_tempModel.cwb;
    InModel.traceno =_tempModel.cwb;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_FeedbackOrderidWithModel *outModel = [[communcation sharedInstance] getFeedBackWithModel:InModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                AlertViewOne = [[UIAlertView alloc]initWithTitle:@"用户提示" message:@"反馈成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                AlertViewOne.tag=100;
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
    //    LSendGoodsViewController *sendGoods=[[LSendGoodsViewController alloc]init];
    //    sendGoods.kindType=self.KindType;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{

     [_locService stopUserLocationService];
    
    BMKGeoCodeSearch *bmGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    bmGeoCodeSearch.delegate = self;
    
    BMKReverseGeoCodeOption *bmOp = [[BMKReverseGeoCodeOption alloc] init];
    bmOp.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL geoCodeOk = [bmGeoCodeSearch reverseGeoCode:bmOp];
    if (geoCodeOk) {
        DLog(@"ok");
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    BMKAddressComponent *city = result.addressDetail;
    _name = [NSString stringWithFormat:@"%@",city.city];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    [[iToast makeText:@"定位失败，请检查是否打开定位服务!"]show];
    
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    DLog(@"heading is %@",userLocation.heading);
}

@end
