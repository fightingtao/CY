//
//  LOtherSignViewController.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LOtherSignViewController.h"
#import "MBProgressHUD.h"
#import "iToast.h"
#import "publicResource.h"
#import "UserInfoSaveModel.h"
#import "communcation.h"
#import "LSendGoodsViewController.h"
#import "LogisticsPayViewController.h"


@interface LOtherSignViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIButton *rightBtn ;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UIView *textFileBG;//标题view

@property (nonatomic, strong) UITextField *nameTxtField;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray *kindAry;
@end

@implementation LOtherSignViewController
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    self.kindAry=@[@"家人",@"前台",@"门卫",@"邻居"];
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
        _titleLabel.text = @"他人签收";
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
    if (!_textFileBG) {
        _textFileBG=[[UIView alloc]init];
        _textFileBG.backgroundColor=[UIColor whiteColor];
        _textFileBG.frame=CGRectMake(0,84,SCREEN_WIDTH,50);
        [self.view addSubview:_textFileBG];
    }
    if (!_nameTxtField) {
        _nameTxtField = [[UITextField alloc] initWithFrame:CGRectMake(40,0,SCREEN_WIDTH-40,50)];
        _nameTxtField.borderStyle = UITextBorderStyleNone;
        _nameTxtField.placeholder = @"     输入代签收人姓名";
        _nameTxtField.backgroundColor = [UIColor clearColor];
        _nameTxtField.textColor = TextMainCOLOR;
        _nameTxtField.font = MiddleFont;
        _nameTxtField.returnKeyType = UIReturnKeyDone;
        _nameTxtField.backgroundColor = WhiteBgColor;
        [_textFileBG addSubview:_nameTxtField];
    }
    //生成顶部右侧按钮
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 44)];
   rightBtn= [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 50, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = MiddleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self.view addSubview:[self initpersonTableView]];
    
}

- (void)rightItemClick
{
    if (_nameTxtField.text.length == 0) {
        [[iToast makeText:@"请输入签收人姓名！"] show];
        return;
    }
    
    if (_nameTxtField.text.length >50) {
        [[iToast makeText:@"长度不能超过五十个字"] show];
        return;
    }
    
    if ([_nameTxtField.text isEqualToString:@" "]) {
        [[iToast makeText:@"不能输入空格"] show];
        return;
    }
    else if ([_nameTxtField.text isEqualToString:@"  "]) {
         [[iToast makeText:@"不能输入空格"] show];
        return;
    }
    else if ([_nameTxtField.text isEqualToString:@"   "]) {
        [[iToast makeText:@"不能输入空格"] show];
        return;
    }
    else if ([_nameTxtField.text isEqualToString:@"    "]) {
        [[iToast makeText:@"不能输入空格"] show];
        return;
    }
    else if ([_nameTxtField.text isEqualToString:@"     "]) {
        [[iToast makeText:@"不能输入空格"] show];
        return;
    }
    
    if ([_tempModel.cwbordertypeid intValue] ==1) {
        if ([_tempModel.cod floatValue] ==0.00) {
            [self FeedbackOrderidWithModel];
        }
        else{
            LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
            payVC.tempModel = _tempModel;
            payVC.signmanOther=_nameTxtField.text;
            payVC.signType=2;

            [self.navigationController pushViewController:payVC animated:YES];
        }
    }
    else if ([_tempModel.cwbordertypeid  intValue]==2) {
        [self FeedbackOrderidWithModel];
    }
    else if ([_tempModel.cwbordertypeid intValue] ==3) {
       
        if ([_tempModel.paybackfee floatValue]==0.00) {
            [self FeedbackOrderidWithModel];
        }
      else  if (_tempModel.paybackfee > 0) {
            [self FeedbackOrderidWithModel];
        }
      else  if (_tempModel.paybackfee <0) {
            LogisticsPayViewController *payVC = [[LogisticsPayViewController alloc] init];
            payVC.tempModel = _tempModel;
            payVC.signmanOther=_nameTxtField.text;
          payVC.signType=2;
            [self.navigationController pushViewController:payVC animated:YES];
        }
    }
}

- (void)FeedbackOrderidWithModel{
    
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    mbp.labelText = @"反馈中...";
    
    NSDate *NowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *NowTime = [formatter stringFromDate:NowDate];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *KeyArr = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",[_tempModel.payway intValue]],[NSString stringWithFormat:@"%f",[_tempModel.cod floatValue]],_nameTxtField.text,NowTime,[NSString stringWithFormat:@"%d",2],@"",@"",[NSString stringWithFormat:@"%d",2],_tempModel.cwb,_tempModel.cwb,nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr];
    
    In_FeedbackOrderidWithModel *InModel = [[In_FeedbackOrderidWithModel alloc]init];
    InModel.key = userInfoModel.key;
//          NSLog(@"key>>>>>>>>>>>%@", InModel.key);
    InModel.digest = hamcString;
//          NSLog(@"digest>>>>>>>>>>>%@", InModel.digest);
    InModel.cwbs = _tempModel.cwb;
//          NSLog(@"cwbs>>>>>>>>>>>%@", InModel.cwbs);
    InModel.cwbordertypeid = [_tempModel.cwbordertypeid intValue];
    InModel.deliverystate = 2;
    InModel.paywayid = [_tempModel.payway intValue];
        InModel.cash = [_tempModel.paybackfee floatValue];

    InModel.signman = _nameTxtField.text;
          NSLog(@"signman>>>>>>>>>>>%@", InModel.signman);
    InModel.signtime = NowTime;
    InModel.exptioncode = @"";
    InModel.nextdispatchtime = @"";
    InModel.terminaltype = 2;
    InModel.signtypeid=2;
    InModel.postrace =_tempModel.cwb;
    InModel.traceno =_tempModel.cwb;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_FeedbackOrderidWithModel *outModel = [[communcation sharedInstance] getFeedBackWithModel:InModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                rightBtn.enabled=NO;
                AlertViewOne = [[UIAlertView alloc]initWithTitle:@"用户提示" message:@"反馈成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [AlertViewOne show];
                 LSendGoodsViewController *send = self.navigationController.viewControllers[2];
                [self.navigationController popToViewController:send animated:YES];
//                [self leftItemClick];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
            
        });
        
    });
    
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView==AlertViewOne){
//        LSendGoodsViewController *send=[[LSendGoodsViewController alloc]init];
//        
//        [self.navigationController popToViewController:send animated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableView 初始化下单table
-(UITableView *)initpersonTableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 154;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT-154;
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ViewBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _tableView;
}
#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _kindAry.count;
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
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"PersonOtherInfoTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",_kindAry[indexPath.section]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
    _nameTxtField.text=cell.textLabel.text;
}
@end
