//
//  TiaoMaPayVController.m
//  HSApp
//
//  Created by cbwl on 16/10/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "TiaoMaPayVController.h"
#import "ScanningViewController.h"

#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y

#define SHeight 20

#define SWidth (XCenter+30)


@interface TiaoMaPayVController ()
{
    UIImageView * imageView;
}
@property (nonatomic,copy) NSString *payString;
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic,copy) NSString *branchname;//站点名称
@property (nonatomic,copy) NSString * realName;//小件员名字

@end

@implementation TiaoMaPayVController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteBgColor;
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
        _titleLabel.text = @"条码支付";
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
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0,100, SCREEN_WIDTH, 20)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=1;
    labIntroudction.textColor=MAINCOLOR;
    labIntroudction.text=@"将条码二维码放入框中就能自动扫描";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labIntroudction];
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((Width-SWidth)/2,(Height-SWidth)/2,SWidth,SWidth)];
    imageView.image = [UIImage imageNamed:@"scanscanBg.png"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5, SWidth-10,1)];
    _line.image = [UIImage imageNamed:@"scanLine@3x.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setupCamera];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num ==(int)(( SWidth-10)/2)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame =CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //设置扫描二维码的相机灵敏度
    if ([_device lockForConfiguration:nil]) {
        //自动闪光灯
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
        }
        //自动对焦
        if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            [_device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }
        //自动曝光
        if ([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
            [_device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        }
        [_device unlockForConfiguration];
    }

    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _output.rectOfInterest =[self rectOfInterestByScanViewRect:imageView.frame];//CGRectMake(0.1, 0, 0.9, 1);//
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame =self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.view bringSubviewToFront:imageView];
    
    [self setOverView];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        /**
         *  获取扫描结果
         */
        stringValue = metadataObject.stringValue;
    }
    
    _payString=stringValue;
    [_session stopRunning];

    [self getbranchName];

    
    
    
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(imageView.frame);
    CGFloat y = CGRectGetMinY(imageView.frame);
    CGFloat w = CGRectGetWidth(imageView.frame);
    CGFloat h = CGRectGetHeight(imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.5;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 * 用户付款码（当面付：条码支付）
 private int auth_code;

 */

/**
 * 收款金额（当面付：条码支付）
 private BigDecimal total_amount;

 */
-(void)AlipayTiaoMa{
    
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
        signName=@"自提柜";
        
    }
    
    NSDate *NowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *NowTime = [formatter stringFromDate:NowDate];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    //小件员名称信息
    NSString *personInfo=[NSString stringWithFormat:@"%@_站点名称：%@_小件员姓名：%@",_tempModel.dssnname,_branchname,_tempModel.realname];//

    NSArray *KeyArr;
    if ([_tempModel.cwbordertypeid intValue]==1) {
        
        KeyArr  = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",3],[NSString stringWithFormat:@"%f",[_tempModel.cod floatValue]],[NSString stringWithFormat:@"%d",2],signName,NowTime,@"",@"",@"",_tempModel.cwb,_tempModel.cwb,[NSString stringWithFormat:@"%d",self.signType],[NSString stringWithFormat:@"%.2f",self.money],_payString,personInfo,nil];
    }else if ([_tempModel.cwbordertypeid intValue] ==3){
        
        KeyArr = [[NSArray alloc]initWithObjects:_tempModel.cwb,[NSString stringWithFormat:@"%d",[_tempModel.cwbordertypeid intValue]],[NSString stringWithFormat:@"%d",2],[NSString stringWithFormat:@"%d",3],[NSString stringWithFormat:@"%f",-[_tempModel.paybackfee floatValue]],[NSString stringWithFormat:@"%d",2],signName,NowTime,@"",@"",@"",_tempModel.cwb,_tempModel.cwb,[NSString stringWithFormat:@"%d",self.signType],[NSString stringWithFormat:@"%.2f",self.money],_payString,personInfo,nil];
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
    ///当面付信息
    [request setPostValue:[NSString stringWithFormat:@"%.2f",self.money] forKey:@"total_amount"];
    [request setPostValue:_payString forKey:@"auth_code"];

    [request setPostValue:personInfo forKey:@"subject"];

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
    }
    DLog(@"%@",ReturnDic);

    if ([[ReturnDic objectForKey:@"code"] intValue]==1000 ) {
        
        if ([[[ReturnDic objectForKey:@"data"] objectForKey:@"faliurecount"] intValue]>0) {
         UIAlertView *   AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付宝支付失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [AlertViewOne show];
        }
        else if ([[[ReturnDic objectForKey:@"data"] objectForKey:@"successcount"] intValue]==0){
              UIAlertView *  AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [AlertViewTwo show];
            
        }
    }
    [[iToast makeText:[ReturnDic objectForKey:@"message"]] show];


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
      UIViewController *sendVC=self.navigationController.viewControllers  [2];
        [self .navigationController popToViewController:sendVC animated:YES];

    }
}
#pragma mark 获取站点名称
-(void)getbranchName{
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
                [self AlipayTiaoMa];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
    
    /***************************************/
    
    
    
}
@end
