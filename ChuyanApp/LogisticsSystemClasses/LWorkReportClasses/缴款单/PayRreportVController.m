//
//  PayRreportVController.m
//  HSApp
//
//  Created by cbwl on 16/10/30.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "PayRreportVController.h"
#import "payReportTableVCell.h"
#import "IQKeyboardManager.h"
#import "iToast.h"
@interface PayRreportVController ()
<UITableViewDelegate,UITableViewDataSource,payReportDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *footbtn;
@property (nonatomic,strong)  Out_jiaoKuanModel *outModel;
@property (nonatomic,strong)NSString *payKindTitle;//支付方式
@property (nonatomic,strong)NSString *payKind;//支付方式
@property (nonatomic,strong)NSString *payMoney;//缴款金额
@property (nonatomic,strong)NSString *payId;//交易号
@property (nonatomic,strong)NSString *remark;//备注
@property (nonatomic,strong)NSString *yingjiao;//应缴金额
@property (nonatomic,strong)NSString *yijiao;//应交金额
@property (nonatomic,strong)UIAlertView *payKindAlert;
@property (nonatomic,strong)UIAlertView *cancelAlert;

@end

@implementation PayRreportVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaveView];
    [self.view addSubview: [self initpersonTableView]];
    _payKindTitle=@"支付宝";
    _payKind=@"alipay";
    [self createJiaoKuanClick];
}
-(void)initNaveView{
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
      if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 64, 150, 36)];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = LargeFont;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"缴款单";
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
    
    
}

-(void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableView 初始化下单table
-(UITableView *)initpersonTableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height =SCREEN_HEIGHT;
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ViewBgColor;
//    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _tableView;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    return 100;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *viewFoot = [[UIView alloc]init];
    viewFoot.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    _footbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _footbtn.frame = CGRectMake(30, 40, SCREEN_WIDTH-60, 40);
    NSString *title=[NSString stringWithFormat:@"缴款"];
    [_footbtn setTitle:title forState:UIControlStateNormal];
    [_footbtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    //            RightNowBtn.layer.borderColor = MAINCOLOR.CGColor;
    _footbtn.layer.borderWidth = 0.5;
    _footbtn.layer.cornerRadius = 10;
    _footbtn.clipsToBounds = YES;
    [_footbtn addTarget:self action:@selector(PayMenoyGetTran) forControlEvents:UIControlEventTouchUpInside];
    [viewFoot addSubview:_footbtn];
    return viewFoot;
    
}
-(void)PayMenoyGetTran{
    DLog( @"缴款被点击");
    [self sendJiaoKuanClick];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 450;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellName = @"payReportTableVCell";
    payReportTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"payReportTableVCell" owner:self options:nil] objectAtIndex:0];
    }
    [cell.payKindbtn setTitle:_payKindTitle forState:UIControlStateNormal];
    //    _outModel.data.yingjiaokuan=@"20";
    cell.allmoney.text=[NSString stringWithFormat:@"%.2f元",[_outModel.data.yingjiaokuan floatValue]];
    cell.alreadyMoney.text=[NSString stringWithFormat:@"%.2f元",[_outModel.data.yijiaokuan floatValue]];
    cell.willPay.text=_payMoney;
    cell.payOrderId.text=_payId;
    cell.remark.text=_remark;
    cell.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.name.text=_model.realname;
    return cell;
    
}
-(void)payWayKindClick:(UIButton *)btn;{
    _payKindAlert=[[UIAlertView alloc]initWithTitle:@"结算账户" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"银行卡",@"支付宝",@"浦发交现",nil];
    [_payKindAlert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    if (_payKindAlert==alertView) {
        if (buttonIndex==0){
            _payKindTitle=@"银行卡";
            
            _payKind=@"bank";
            
        }
        else if(buttonIndex==1){
            
            _payKindTitle=@"支付宝";
            
            _payKind=@"alipay";
            
        }
        else if (buttonIndex==2){
            _payKindTitle=@"浦发交现";
            
            _payKind=@"bank";
        }
        
        [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation: UITableViewRowAnimationFade];
        
    }else if(alertView==_cancelAlert){
        if (buttonIndex==0) {
            
            [self leftItemClick];
        }
    }
}
#pragma mark 获取缴款信息
-(void)createJiaoKuanClick{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    
    NSString *hamcString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _outModel = [[communcation sharedInstance]creacteJiaoKuanWith:userInfoModel.userId andDigest:hamcString];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!_outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }
            else if (_outModel.code ==1000)
            {
                DLog(@"huq获取缴款单信息%@",_outModel);
                if ([_outModel.data.yingjiaokuan floatValue]-[_outModel.data.yijiaokuan floatValue]>0) {
                    _payMoney=[NSString stringWithFormat:@"%.2f",[_outModel.data.yingjiaokuan floatValue]-[_outModel.data.yijiaokuan floatValue]];

                }
                else{
                    _payMoney=@"0.00";

                }
                [_tableView reloadData];
            }else{
                [[iToast makeText:_outModel.message] show];
            }
        });
        
    });
    
}
#pragma mark 缴款金额输入代理
-(void)diEndTextInPut:(NSString *)text kind:(int)kind;
{
    if (kind==1){
        if ([text floatValue]>0) {
            _payMoney=[NSString stringWithFormat:@"%.2f",[text floatValue]];

        }
        else{
            _payMoney=@"0.00";
        }
    }
    else if (kind==2){
        _payId=text;
    }
    else if (kind==3){
        _remark=text;
    }
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation: UITableViewRowAnimationFade];

}


#pragma mark 去缴款 baocun保存缴款单
-(void)sendJiaoKuanClick{
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    payReportTableVCell *cell=[_tableView cellForRowAtIndexPath:index];
    _payMoney=[NSString stringWithFormat:@"%.2f",[cell.willPay.text floatValue]];
    _payId=cell.payOrderId.text;
    _remark=cell.remark.text;
    if (!_payMoney||_payMoney.length==0||[_payMoney floatValue]<=0) {
        [[iToast makeText:@"请输入缴款金额"]show];
        return;
    }
    if (!_payId||_payId.length==0) {
//        [[iToast makeText:@"交易流水号不能为空"]show];
//        return;
        _payId=@"";
    }
    if (!_remark||_remark.length==0) {
        _remark=@"";
    }
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *array=[[NSArray alloc]initWithObjects:_payId,_remark,_payKind,_payMoney,[NSString stringWithFormat:@"%@",_outModel.data.yingjiaokuan ],nil];
    
    NSString *hamcString = [[communcation sharedInstance]ArrayCompareAndHMac:array];
    In_BalanceModel *inModel=[[In_BalanceModel alloc]init];
    inModel.key=userInfoModel.key;
    inModel.digest=hamcString;
    inModel.jsfs=_payKind;
    inModel.jkje=_payMoney;
    inModel.jyh=_payId;
    inModel.remark=_remark;
    inModel.yjze=[NSString stringWithFormat:@"%@",_outModel.data.yingjiaokuan ];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *   outDic = [[communcation sharedInstance]saveJiaoKuanWith:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            int code=[outDic[@"code" ] intValue] ;
            DLog(@"huq获取缴款单信息%@",outDic);

            if (!outDic)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
            }
            else if (code ==1000)
            {
                _cancelAlert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"缴款单提交成功!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [_cancelAlert show];
                
            }else{
                [[iToast makeText:outDic[@"message"]] show];
            }
        });
        
    });
    
}

@end
