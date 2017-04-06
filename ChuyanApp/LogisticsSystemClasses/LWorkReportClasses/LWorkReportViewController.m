//
//  LWorkReportViewController.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LWorkReportViewController.h"
#import "LOrderReportTableViewCell.h"
#import "LMoneyReportTableViewCell.h"
#import "AlreadyAndNeedTableViewCell.h"
#import "DataModels.h"
#import "LoginViewController.h"
#import "PayRreportVController.h"//缴款单

@interface LWorkReportViewController () 
{
    NSString  *_currentDateStr;
    NSString  *_yestadayDateStr;
    NSString  *_beforeYestadayDateStr;
    NSString *_tradeNOddh;//订单号
    NSString *_notify_url;//支付宝回调地址
    
    Out_LWorkReportBody *_tempModel;
    
    NSArray *HeightArr ;
    
    UIAlertView *AlertViewOne;
    UIAlertView *AlertViewTwo;
    CYNSObject *_outModel;
    UIButton *RightNowBtn;
    
    NSDictionary *Dic;
    
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *beforeYesterdayBtn;
@property (nonatomic, strong) UIButton *yesterdayBtn;
@property (nonatomic, strong) UIButton *todayBtn;


@property (nonatomic, strong) UITableView *reportTableview;

@end

@implementation LWorkReportViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
       // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    
    Dic = [[NSDictionary alloc]init];
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
        _titleLabel.text = @"工作汇总";
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
    
    
    NSTimeInterval  oneDay = 24*60*60*1;
    //用[NSDate date]可以获取系统当前时间
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];

    NSDate *beforeYesterdayDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*2 ];
    
    NSDate *yesterdayDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*1 ];
    
    _currentDateStr = [dateFormatter stringFromDate:nowDate];
    _yestadayDateStr = [dateFormatter stringFromDate:yesterdayDate];
    _beforeYestadayDateStr = [dateFormatter stringFromDate:beforeYesterdayDate];
//    NSLog(@"今天%@昨天%@前天%@",_currentDateStr,_yestadayDateStr,_beforeYestadayDateStr);
    
    //加载头部选择功能
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headView];
    }
    
    if (!_beforeYesterdayBtn) {
        _beforeYesterdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beforeYesterdayBtn setTitle:_beforeYestadayDateStr forState:UIControlStateNormal];
        [_beforeYesterdayBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_beforeYesterdayBtn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_beforeYesterdayBtn addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        _beforeYesterdayBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 40);
        _beforeYesterdayBtn.titleLabel.font = LittleFont;
        _beforeYesterdayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_beforeYesterdayBtn];
    }
    
    if (!_yesterdayBtn) {
        _yesterdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yesterdayBtn setTitle:_yestadayDateStr forState:UIControlStateNormal];
        [_yesterdayBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_yesterdayBtn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_yesterdayBtn addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        _yesterdayBtn.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40);
        _yesterdayBtn.titleLabel.font = LittleFont;
        _yesterdayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_yesterdayBtn];
    }
    
    
    if (!_todayBtn) {
        _todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_todayBtn setTitle:_currentDateStr forState:UIControlStateNormal];
        [_todayBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_todayBtn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_todayBtn addTarget:self action:@selector(button3Click) forControlEvents:UIControlEventTouchUpInside];
        _todayBtn.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 40);
        _todayBtn.titleLabel.font = LittleFont;
        _todayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _todayBtn.selected = YES;
        [_headView addSubview:_todayBtn];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    
    
    [self inithomeTableView];

    [self.view addSubview:_reportTableview];

    [self getWorkReportWithTime:_currentDateStr];

    HeightArr = [[NSArray alloc]initWithObjects:@"100", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化table
-(UITableView *)inithomeTableView
{
    if (_reportTableview != nil) {
        return _reportTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104.0;
    
    self.reportTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _reportTableview.delegate = self;
    _reportTableview.dataSource = self;
    _reportTableview.backgroundColor = ViewBgColor;
    _reportTableview.showsVerticalScrollIndicator = NO;
            UIView *viewFoot = [[UIView alloc]init];
            viewFoot.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
           RightNowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
            RightNowBtn.frame = CGRectMake((SCREEN_WIDTH - 200)/2, 0, 200, 40);
            NSString *title=[NSString stringWithFormat:@"缴款"];
            [RightNowBtn setTitle:title forState:UIControlStateNormal];
  
    [RightNowBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
//            RightNowBtn.layer.borderColor = MAINCOLOR.CGColor;
            RightNowBtn.layer.borderWidth = 0.5;
            RightNowBtn.layer.cornerRadius = 10;
            RightNowBtn.clipsToBounds = YES;
            [RightNowBtn addTarget:self action:@selector(RightNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [viewFoot addSubview:RightNowBtn];
    _reportTableview.tableFooterView=viewFoot;
//            return view;

    
    
    return _reportTableview;
}


#pragma mark 获取工作汇总数据
- (void)getWorkReportWithTime:(NSString*)time
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中...";

    _reportTableview.hidden = YES;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hamcString = [[communcation sharedInstance] hmac:time withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       _outModel = [[communcation sharedInstance] getWrokReportWith:userInfoModel.userId andDigest:hamcString andTime:time];
        NSLog(@"工作汇总 %@",_outModel);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!_outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (_outModel.code ==1000)
            {

//                if (_outModel.data.payfee>0){
////                    RightNowBtn.enabled=YES;
////                    RightNowBtn.backgroundColor=WhiteBgColor;
////                    RightNowBtn.layer.borderColor =[UIColor redColor].CGColor;
////                    [RightNowBtn setTitleColor:(__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([[UIColor redColor]colorWithAlphaComponent:0.7])) forState:UIControlStateNormal];
//                }
//                else{
//                    RightNowBtn.enabled=NO;
//                    RightNowBtn.backgroundColor=ButtonBGCOLOR;
//                    RightNowBtn.layer.borderColor = OrderTextCOLOR.CGColor;
//                    [RightNowBtn setTitleColor:TextDetailCOLOR forState:UIControlStateNormal];
//                
//                }
//                [RightNowBtn setTitle:[NSString stringWithFormat:@"缴款(%.2f元)",_outModel.data.payfee] forState:UIControlStateNormal];
                [_reportTableview reloadData];
                
                _reportTableview.hidden = NO;
                
            }else{
                
                [[iToast makeText:_outModel.message] show];
                if ([@"请登录" isEqualToString:_outModel.message]){
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                alert.tag=200;
                [alert show];
            }
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    else if (indexPath.section ==1){
        return [[HeightArr objectAtIndex:0] floatValue];
    }
    else{
        return 100;
    }
    return 0;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 50;
    }
    return 0.01;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identCell = @"LOrderReportTableViewCell";
        LOrderReportTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
        //订单总数
        if (cell == nil) {
            cell = [[LOrderReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataWithModel:_outModel];
        return cell;
    }else if(indexPath.section ==1)
    {
        static NSString *identCell = @"LMoneyReportTableViewCell";
        LMoneyReportTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
//        当日应收金额
        if (cell == nil) {
            cell = [[LMoneyReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setDataWithModl:_outModel];
        return cell;
        
    }else if (indexPath.section==2)
    {
        static NSString *identCell = @"AlreadyAndNeedTableViewCell";
              AlreadyAndNeedTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
//        已付退款
        if (cell == nil) {
            cell = [[AlreadyAndNeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.delegate = self;
        [cell setDataWithMode:_outModel];

        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark 动态绑定方法
- (void)button1Click
{
    _beforeYesterdayBtn.selected = YES;
    _yesterdayBtn.selected = NO;
    _todayBtn.selected = NO;
    [self getWorkReportWithTime:_beforeYestadayDateStr];
    _tempModel = nil;
}

#pragma mark 通知绑定方法
- (void)button2Click
{
    _beforeYesterdayBtn.selected = NO;
    _yesterdayBtn.selected = YES;
    _todayBtn.selected = NO;
    [self getWorkReportWithTime:_yestadayDateStr];
    _tempModel = nil;
}

- (void)button3Click
{
    _beforeYesterdayBtn.selected = NO;
    _yesterdayBtn.selected = NO;;
    _todayBtn.selected = YES;
    [self getWorkReportWithTime:_currentDateStr];
    _tempModel = nil;
}

- (void)CellHeightWithState:(BOOL)state
{
    
    if (state == YES) {
        HeightArr = [[NSArray alloc]initWithObjects:@"300", nil];
    }else
    {
        HeightArr = [[NSArray alloc]initWithObjects:@"100", nil];
    }
    [_reportTableview reloadData];
}

//#pragma mark 支付之前


//- (void)beforPayMenoyGetTran
//{
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//                NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
//                [dateFormatte setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//                NSString *dateString = [dateFormatte stringFromDate:currentDate];
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSData *userData = [userDefault objectForKey:UserKey];
//    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//    
//    NSArray *keyArr = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%f",_outModel.data.payfee],@"",dateString,[NSString stringWithFormat:@"%d",1],[NSString stringWithFormat:@"%d",2], nil];
//
//    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:keyArr];
//    
//    In_WorkPayBefore *InModel = [[In_WorkPayBefore alloc]init];
//    InModel.key = userInfoModel.key;
//    InModel.digest = hamcString;
//    InModel.payamount = _outModel.data.payfee;
//    InModel.terminalno = @"";
//    InModel.summarytime = dateString;
//    InModel.paytype = 1;
//    InModel.terminaltype=2;
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        NSDictionary *outModel = [[communcation sharedInstance]WorkPayBeforeWithModel:InModel];
////        NSLog(@"zidian 字典%@",outModel);
//        /*
//         {
//         code = 1000;
//         data =     {
//         "notify_url" = "http://yangjiahua195732.xicp.net:22331/hs-deliveryconsumer/pay/alipay/notify";
//         "pay_order_no" = 201605201603464;
//         };
//         message = "\U4fdd\U5b58\U7f34\U6b3e\U6210\U529f";
//         }
//*/
//        NSString *message=[outModel objectForKey:@"message"];
//
//        int code=[[outModel objectForKey:@"code"] intValue];
//              dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            if (!outModel)
//            {
//                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
//                
//            }else if (code ==1000)
//            {
//                
//                NSDictionary *data=[outModel objectForKey:@"data"];
//                _tradeNOddh=[data objectForKey:@"pay_order_no"];
//                
//                _notify_url=[data objectForKey:@"notify_url"];
//                
//                [self RightNowBtnClick];
//                
//                
////                NSLog(@"成功%@",_tradeNOddh);
//            }else{
//                [[iToast makeText:message] show];
////                 NSLog(@"失败");
//            }
//        });
////
//    });
//    
//}

#pragma mark 去缴款单
-(void)RightNowBtnClick{
//    PayRreportVController *VC=[[PayRreportVController alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
}
//- (void)RightNowBtnClick{
//    /******************** 支付宝 *************************/
//    // 商户PID
////    public static final String WORK_PARTNER = "2088401564739629";
////    // 商户收款账号
////    public static final String WORK_SELLER = "cbwlyx@163.com";
////    // 商户私钥，pkcs8格式
////    public static final String WORK_RSA_PRIVATE = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMc/RzV5FyfodVnb4Lwle3SlZ/UhNq8B4tST2vcX2et1NXQp2pnxvbH3q3FOx5BgOEMAP5tJqYtPu6C7tv6FPRy9cI7+T8HudaFvZc+tZ6X7CAzWIKVZIj8+JFnHez3zZ7Cp3gUO81Aq8SOkjhVbWtVCMB+xxL84VdnydzQkY479AgMBAAECgYEApIitnguzwoHkvmKjT9tH+ohIs5VM2fIdxVufmyJ4E0dD7/xMB4ooEtmqGrRqed/rNfDzlaGbv24FS/MXZ1DRp/1tunly2Fs7Pnp8GQsdsB0BiV2LAXPi4ZyYllXR3soMrW76AMQMez6VT9IO91dKH03zsVFquGyYjt65hDUul6ECQQD+NG+eQvHSOAw+Q4UCltgGyKCQhTZfRCZWgyBhWoGPM+6A9voNsTFRXoNy8q+ni1xneDttYRDX2O/+H0PkjWFFAkEAyKd8rNS+00vWKzkafiEuU4cGI6a0s5Bj2E6uNlFNzT3LO/HX8N8NVoRG3CjbAh+U+JSxLeCryuuO+sxuqyKmWQJAHUfy93rkmf9kwaNLZfH0Lkvb2unNSonyFJMEHtKrC9DCj05jnUIk2SeW4p27yAPQgAakacP9ia9ubYoyatgyNQJAKV0NgHti0yABCGv/IB0q9aESDOtiuNl9G6wskZn1Feg1KyhRwZ/ZmgouqVfqvedQyGWumKyF/ZDNqrnV3oWIEQJAfCxrL0BqChITmpM7vRNm+Ia1KJnaOFKvx3VMyrexiPK8nATqs6mvYUqClT7Fh9f1vC2Y4KAKVtMrid09TekgLw==";
//    /******************** 支付宝end *************************/
////    /*
////     *商户的唯一的parnter和seller。
////     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
////     */
////    
////    /*============================================================================*/
////    /*=======================需要填写商户app申请的===================================*/
////    /*============================================================================*/
////    NSString *partner = @"2088911958006740";
////    NSString *seller = @"yihusong@163.com";
////    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAM9qzoVrKGMqbkE4WyEV8PD3jkDCReb/dttO2vQ+uPlumD/A1AEazojI9g8jhgQZBpt4eZjXCL/Gx4+/21JTuE7dRECoJ5bpCBXT/KVfek0UDDxLi8Nkgyu6nZgnKDaLxdi6B31aBNKY2wAr35UHyvOGUfn5gOLaCqApSRDxR2WbAgMBAAECgYBJAfNHivxgS2MbmdaZwrtYVgrASKGKOYmAkDUJm7pIMeFtL1ZwPRtNkk7p7TsS3iwxNSq33Zi6yCEePA3a4JUSqvPclTjHX5wCYW8K8+ADJa79vjrrffss/+DAFeHyWF7JaeWjC8r9dKRMuoaYR2Z1vJPZ9RIp/M0hRstq+pj0oQJBAPE6VfNmYDxiqObeaS1VlFGMV8FUD68UVd6Qt7zxD9LEH874r3UYXlzE7zYLDt0vKr7f5yYPIfABVH6daSlO9W8CQQDcHm4tv4UnCaMcbC45kXHkyioWFa4ESQanvSbVWf7KN7nMZQAKJQm++WtO1zNmgVv9GJk66tEg0vBEedRfCDSVAkEAuo+QO68YjHsM/4hRNYNzMuJkWBtoCdKjWn736wNQZoPRyeMg52GSURLpohVJSJya5YYKoa+gYprUuxuIYi8ztwJAM4W77GFj3VtYHpMDzt3IdvELINg6Py6IrEKOEGpcRSD+EGWjuLwqp9Th1TZyBZBJ49gaJbxI7xHww1Zw6z2UcQJAQPlXON26u66izB3ELBHi+wbNwrF294zVUlLWFmW2NVkB9lCa6ubj8l5jGHVVvkz+M+9Zb6oAnZkSG9mpoKlcBQ==";
////    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//    
//    NSString *partner = @"2088401564739629";
//        NSString *seller = @"cbwlyx@163.com";
//        NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMc/RzV5FyfodVnb4Lwle3SlZ/UhNq8B4tST2vcX2et1NXQp2pnxvbH3q3FOx5BgOEMAP5tJqYtPu6C7tv6FPRy9cI7+T8HudaFvZc+tZ6X7CAzWIKVZIj8+JFnHez3zZ7Cp3gUO81Aq8SOkjhVbWtVCMB+xxL84VdnydzQkY479AgMBAAECgYEApIitnguzwoHkvmKjT9tH+ohIs5VM2fIdxVufmyJ4E0dD7/xMB4ooEtmqGrRqed/rNfDzlaGbv24FS/MXZ1DRp/1tunly2Fs7Pnp8GQsdsB0BiV2LAXPi4ZyYllXR3soMrW76AMQMez6VT9IO91dKH03zsVFquGyYjt65hDUul6ECQQD+NG+eQvHSOAw+Q4UCltgGyKCQhTZfRCZWgyBhWoGPM+6A9voNsTFRXoNy8q+ni1xneDttYRDX2O/+H0PkjWFFAkEAyKd8rNS+00vWKzkafiEuU4cGI6a0s5Bj2E6uNlFNzT3LO/HX8N8NVoRG3CjbAh+U+JSxLeCryuuO+sxuqyKmWQJAHUfy93rkmf9kwaNLZfH0Lkvb2unNSonyFJMEHtKrC9DCj05jnUIk2SeW4p27yAPQgAakacP9ia9ubYoyatgyNQJAKV0NgHti0yABCGv/IB0q9aESDOtiuNl9G6wskZn1Feg1KyhRwZ/ZmgouqVfqvedQyGWumKyF/ZDNqrnV3oWIEQJAfCxrL0BqChITmpM7vRNm+Ia1KJnaOFKvx3VMyrexiPK8nATqs6mvYUqClT7Fh9f1vC2Y4KAKVtMrid09TekgLw==";
//    
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = _tradeNOddh; //订单ID（由商家自行制定）
////    _tradeNOddh=order.tradeNO;
//    //    if (_payType == 1) {
//    //        order.productName = @"余额充值";//商品标题
//    //        order.productDescription = @"余额充值"; //商品描述
//    //    }else
//    //    {
//    order.productName = @"直接支付(商品订单)";//商品标题
//    order.productDescription = @"小件员缴款"; //商品描述   
//    //    }
//    //        order.amount = [NSString stringWithFormat:@"1"];//test
//    order.amount = [NSString stringWithFormat:@"%.2f",_outModel.data.payfee]; //商品价格
////    order.notifyURL = @"http://www.baidu.com"; //回调URL
//    order.notifyURL=_notify_url;
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"HSApp";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
//         {
//             
//             Dic = resultDic;
//             
//             if ([[resultDic objectForKey:@"resultStatus"] intValue] == 9000){
//                 AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                 AlertViewOne.tag=100;
//                 [AlertViewOne show];
//                 
//             }
//             else{
//                 AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付失败,是否继续支付" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                 AlertViewTwo.tag=300;
//                 [AlertViewTwo show];
//             }
//         }];
//    }
//    
//}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    
    return resultStr;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == AlertViewOne) {
        if (buttonIndex ==0){
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            NSDateFormatter *dateFormatte = [[NSDateFormatter alloc] init];
            [dateFormatte setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
            NSString *dateString = [dateFormatte stringFromDate:currentDate];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSData *userData = [userDefault objectForKey:UserKey];
            UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
            
            NSArray *keyArry = nil;
//            if ([[Dic objectForKey:@"resultStatus"] intValue] == 9000) {
                keyArry = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",1],_tradeNOddh,@"",@"",[NSString stringWithFormat:@"%d",1],dateString,@"",@"",[NSString stringWithFormat:@"%d",2], nil];

            NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:keyArry];
            
            In_WorkPayLater *InModel = [[In_WorkPayLater alloc]init];
            InModel.key = userInfoModel.key;
            InModel.digest = hamcString;
            InModel.paystatus =[NSString stringWithFormat:@"%d",1];
            InModel.payorderno = _tradeNOddh;
            InModel.postrace = @"";
            InModel.traceno = @"";
            InModel.paytype = 1;
            InModel.finishtime=dateString;
            InModel.terminalno=@"";
            InModel. aplipayaccount=@"";
            InModel.terminaltype=2;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                Out_WorkPayLater *outModel = [[communcation sharedInstance]WorkPayOverWithModel:InModel];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (!outModel)
                    {
                        [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                        
                    }else if (outModel.code ==1000)
                    {
//                        [self getWorkReportWithTime:_currentDateStr];
                        
//                        if (_outModel.data.payfee>0){
//                            RightNowBtn.enabled=YES;
//                            RightNowBtn.backgroundColor=WhiteBgColor;
//                            RightNowBtn.layer.borderColor =[UIColor redColor].CGColor;
//                            [RightNowBtn setTitleColor:(__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([[UIColor redColor]colorWithAlphaComponent:0.7])) forState:UIControlStateNormal];
//                        }
//                        else{
//                RightNowBtn.enabled=NO;
//                RightNowBtn.backgroundColor=ButtonBGCOLOR;
//                RightNowBtn.layer.borderColor = OrderTextCOLOR.CGColor;
//                [RightNowBtn setTitleColor:TextDetailCOLOR forState:UIControlStateNormal];
//                            
////                        }
//              [RightNowBtn setTitle:@"缴款:0.00元" forState:UIControlStateNormal];
                [self getWorkReportWithTime:_currentDateStr];

                       
                    }else{
                        [[iToast makeText:outModel.message] show];
                        NSLog(@"失败%@",outModel.message);
                    }
                });
                
            });
        }
    }
    
   else if (alertView == AlertViewTwo) {
       
            if (buttonIndex ==0) {
                //UIViewController *VC = self.navigationController.viewControllers[2];
                //[self.navigationController pushViewController:VC animated:YES];
            }else{
                
            }
       
    }
   else if (alertView.tag==200){
       if (buttonIndex==1) {
           LoginViewController *login=[[LoginViewController alloc]init];
           [self.navigationController pushViewController:login animated:YES];
           

       }
       
   
   }

}


//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
