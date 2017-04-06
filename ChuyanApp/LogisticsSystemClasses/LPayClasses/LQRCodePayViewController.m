//
//  LQRCodePayViewController.m
//  HSApp
//
//  Created by xc on 16/2/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LQRCodePayViewController.h"
#import "QRCodeGenerator.h"
#import "MBProgressHUD.h"
#import "UserInfoSaveModel.h"
#import "iToast.h"

@interface LQRCodePayViewController ()


{
    UIAlertView  *AlertViewOne;
    
    UIAlertView * AlertViewTwo;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题



@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *QRCodeImgView;

@end

@implementation LQRCodePayViewController

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
        _titleLabel.text = @"支付宝付款";
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
    
    [self initView];
    

    
}
#pragma mark-> 生成二维码
-(void)createErWeiMa
{
    
    UIImage *image=[UIImage imageNamed:@""];
    NSString*tempStr;
    if(self.dataImage.length==0)
    {
        DLog(@"%@",_dataImage);
        tempStr=@"没有支付信息";
        
    }
    else
    {
        
        tempStr=self.dataImage;
        
    }
    
    UIImage*tempImage=[QRCodeGenerator qrImageForString:tempStr imageSize:360 Topimg:image withColor:[UIColor blackColor]];
    
    _QRCodeImgView.image=tempImage;
    
}

///初始化界面上各个控件
- (void)initView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74)];
        _contentView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_contentView];
    }
    
    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.font = [UIFont systemFontOfSize:18];
        _moneyLabel.textColor = TextMainCOLOR;
        
        if ([_tempModel.cwbordertypeid intValue]==1) {
             _moneyLabel.text =[NSString stringWithFormat:@"待收款: %.2f元",[_tempModel.cod floatValue]];
        }
        else if ([_tempModel.cwbordertypeid intValue]==3){
             _moneyLabel.text =[NSString stringWithFormat:@"待收款: %.2f元",-[_tempModel.paybackfee floatValue]];
        }
       
        _moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_moneyLabel];
    }
    
    if (!_QRCodeImgView) {
        _QRCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-240)/2, 80, 240, 240)];
        _QRCodeImgView.image = [UIImage imageNamed:@"icon-60"];
        [_contentView addSubview:_QRCodeImgView];
        [self createErWeiMa];
    }
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _QRCodeImgView.frame.origin.y+230, SCREEN_WIDTH, 50)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = TextDetailCOLOR;
        _tipLabel.text = @"支付宝扫码，向我付款";
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_tipLabel];
    }
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = MiddleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}


- (void)rightItemClick{
    
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    mbp.labelText = @"反馈中...";
    NSString *signName;
    
    if ( self.signType==1) {
        signName=_tempModel.consigneename;
    
    }
    else if(self.signType==2){
        signName=self.signName;
        
    }
    else if(self.signType==3){
        signName=@"";

    }
    
    NSDate *NowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *NowTime = [formatter stringFromDate:NowDate];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *KeyArr;
    if ([_tempModel.cwbordertypeid intValue]==1) {
        
       KeyArr  = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",3],[NSString stringWithFormat:@"%f",[_tempModel.cod floatValue]],[NSString stringWithFormat:@"%d",2],signName,NowTime,@"",@"",@"",_tempModel.cwb,_tempModel.cwb,self.signType ,nil];
    }else if ([_tempModel.cwbordertypeid intValue] ==3){
        
       KeyArr = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",3],[NSString stringWithFormat:@"%f",-[_tempModel.paybackfee floatValue]],[NSString stringWithFormat:@"%d",2],signName,NowTime,@"",@"",@"",_tempModel.cwb,_tempModel.cwb,self.signType,nil];
    }
  //  InModel.postrace=_tempModel.cwb;
  //  InModel.traceno=_tempModel.cwb;
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:KeyArr];
 
    NSString* InPutUrl = [NSString stringWithFormat:@"%@/delivery/feedback", LogisticsHOSTURL];
    NSString *str = [InPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    [request setPostValue:userInfoModel.key forKey:@"key"];
    [request setPostValue:hamcString forKey:@"digest"];
    [request setPostValue:_tempModel.cwb forKey:@"cwbs"];
    [request setPostValue:@""  forKey:@"exptioncode"];
    [request setPostValue:@"" forKey:@"nextdispatchtime"];
    [request setPostValue:signName forKey:@"signman"];
    [request setPostValue:NowTime forKey:@"signtime"];
    [request setPostValue:[NSString stringWithFormat:@"%d",2] forKey:@"deliverystate"];
    [request setPostValue:[NSString stringWithFormat:@"%d",3] forKey:@"paywayid"];
    [request setPostValue:[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]] forKey:@"cwbordertypeid"];
    if ([_tempModel.cwbordertypeid intValue]==1) {
        [request setPostValue:[NSString stringWithFormat:@"%f",[_tempModel.cod floatValue]] forKey:@"cash"];

    }
    else if ([_tempModel.cwbordertypeid intValue]==3){
        [request setPostValue:[NSString stringWithFormat:@"%f", -[_tempModel.paybackfee floatValue]] forKey:@"cash"];
    }
    
    [request setPostValue:[NSString stringWithFormat:@"%d",2] forKey:@"terminaltype"];
    
    [request setPostValue:@"" forKey:@"terminalid"];
    [request setPostValue:_tempModel.cwb forKey:@"postrace"];
    [request setPostValue:_tempModel.cwb forKey:@"traceno"];
    [request setPostValue:[NSString stringWithFormat:@"%d",self.signType] forKey:@"signtypeid"];
    request.shouldAttemptPersistentConnection = NO;
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startSynchronous];
    NSError *error = [request error];
    
    NSDictionary *ReturnDic;
    
    if (!error){
        NSData *jsondata = [request responseData];
        NSString *responseString = [[NSString alloc] initWithBytes:[jsondata bytes] length:[jsondata length] encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        ReturnDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        DLog(@"%@",responseString);
    }
    
    if ([[ReturnDic objectForKey:@"code"] intValue]==1000 ) {
        
        if ([[[ReturnDic objectForKey:@"data"] objectForKey:@"faliurecount"] intValue]>0) {
            AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请进行支付" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [AlertViewOne show];
        }
        else if ([[[ReturnDic objectForKey:@"data"] objectForKey:@"successcount"] intValue]==0){
            AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [AlertViewTwo show];

        }
    }
    [[iToast makeText:[ReturnDic objectForKey:@"message"]]show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == AlertViewOne) {
        
    }
    else if (alertView == AlertViewTwo){
        UIViewController *vc = self.navigationController.viewControllers[2];
        [self.navigationController popToViewController:vc animated:YES];

    }

}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
//    UIViewController *vc = self.navigationController.viewControllers[2];
//    [self.navigationController popToViewController:vc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
