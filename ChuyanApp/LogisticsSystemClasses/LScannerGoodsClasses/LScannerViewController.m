//
//  LScannerViewController.m
//  HSApp
//
//  Created by xc on 16/1/19.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LScannerViewController.h"
#import "ScannerListTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "LScannerFaildViewController.h"
#import "UIView+extension.h"
#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y
#define SHeight 20

#define SWidth (XCenter+30)



@interface LScannerViewController ()<UITableViewDataSource,UITableViewDelegate,ScannerGoodsDelegate,AVAudioPlayerDelegate>
{
    NSMutableArray *_goodsArray;
    AVAudioPlayer * _audioplayer ;
    
    UIImageView * imageView;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *scannerView;
@property (nonatomic, strong) UITableView *goodsTableview;
@property (nonatomic,copy)NSString *orderid;
@property (nonatomic,copy)NSString *orderCheck;

@property(nonatomic,strong)AVAudioPlayer *avAudioPlayer ;
@property (nonatomic,copy)NSString *path;//语音名字
//@property (nonatomic,copy)NSString * orderId;//订单号

@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIButton *InputBtn;
@property(nonatomic,strong)Out_LScanGoodsBody *body;
@end

@implementation LScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    _orderid=@"";
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
        if (_type == 2){//领货
            _titleLabel.text = @"领货出站";
        }
        else{
            _titleLabel.text = @"到货";

        }
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
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [rightBtn setBackgroundColor:[UIColor clearColor]];
//    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = MiddleFont;
//    [rightBtn addTarget:self action:@selector(confirmGoodsClick) forControlEvents:UIControlEventTouchUpInside];
//   
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30,(Height-SWidth)/2/2+60,SCREEN_WIDTH-60,SWidth-50)];
    imageView.image = [UIImage imageNamed:@"scanscanBg.png"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-imageView.width)/2, CGRectGetMinY(imageView.frame)+5,imageView.width,1)];
    _line.image = [UIImage imageNamed:@"qr_scan_line.png"];
    [self.view addSubview:_line];
    
    timer =[NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _goodsArray = [[NSMutableArray alloc] init];
    
    [self setupCamera];
    [self initSubViews];//输入订单号
    [self inithomeTableView];
    [self.view addSubview:_goodsTableview];
    _path = @"success";
    [self playAudio];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_goodsArray removeAllObjects];
    [_goodsTableview reloadData];
    [_session startRunning];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_session stopRunning];
    [self.avAudioPlayer stop];
}



//初始化table
-(UITableView *)inithomeTableView
{
    if (_goodsTableview != nil) {
        return _goodsTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 360.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-360;
    
    self.goodsTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _goodsTableview.delegate = self;
    _goodsTableview.dataSource = self;
    _goodsTableview.backgroundColor = WhiteBgColor;
    _goodsTableview.showsVerticalScrollIndicator = NO;
    _goodsTableview .separatorStyle = UITableViewCellSeparatorStyleNone;
    return _goodsTableview;
}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_goodsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identCell = @"ScannerListTableViewCell";
    ScannerListTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
    
    if (cell == nil) {
        cell = [[ScannerListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",(long)indexPath.row+1,[_goodsArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.cancelOrderBtn.tag = indexPath.row;
    return cell;
    
}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  确认领货
- (void)confirmGoodsClick
{
    //    if ([_orderCheck isEqualToString: _orderid]) {
    //         [[iToast makeText:@"领货失败!"] show];
    //        return;
    //    }
    //    _orderCheck=_orderid;
    
    if (_orderid.length == 0||[_orderid isEqualToString:@""]) {
        [[iToast makeText:@"请先扫描订单!"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"领货中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *allOrderString = @"";
    for (int i = 0; i < _goodsArray.count; i++)
    {
        NSString *tempString = [_goodsArray objectAtIndex:i];
        if (allOrderString.length == 0)
        {
            allOrderString = tempString;
        }else
        {
            allOrderString = [NSString stringWithFormat:@"%@,%@",allOrderString,tempString];
        }
        
    }
    In_LScanGoodsModel *inModel = [[In_LScanGoodsModel alloc] init];
    
    NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",2 ],_orderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
    
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.cwbs = _orderid;
    inModel.terminaltype=2;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LScanGoodsModel *outModel = [[communcation sharedInstance] scanAndGetGoodsWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _body = [[Out_LScanGoodsBody alloc] init];
            _body = outModel.data;
            DLog(@"领货结果的字典%@",outModel);
            
            if (!outModel){
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }
            else if (outModel.code ==1000)
            {
                
                [[iToast makeText:@"领货成功，继续领货!"] show];
                _path=@"success";
                [self playAudio];
                
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                
                _orderCheck=_orderid;
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
            else if (outModel.code ==1001)
            {
                
                [[iToast makeText:outModel.message] show];
                NSLog(@"领货失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                
                _orderCheck=_orderid;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
            else{
                _orderCheck=_orderid;
                
                DLog(@"领货不知道原因失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                
                [[iToast makeText:outModel.message] show];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
        });
        
    });
    
}


#pragma mark  确认到货
- (void)getGoodsClick
{
   if ([_orderCheck isEqualToString: _orderid]) {
       
       return;
   }
    
    if (_orderid.length == 0||[_orderid isEqualToString:@""]) {
        [[iToast makeText:@"请先扫描订单!"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"到货中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    In_LScanGoodsModel *inModel = [[In_LScanGoodsModel alloc] init];
    
    //    NSString *hamcString = [[communcation sharedInstance] hmac:allOrderString withKey:userInfoModel.primaryKey];
    NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",2 ],_orderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
    
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.cwbs = _orderid;
    inModel.terminaltype=2;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LScanGoodsModel *outModel = [[communcation sharedInstance]scanAndDaoGoodsWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _body = [[Out_LScanGoodsBody alloc] init];
            _body = outModel.data;
            NSLog(@"到货结果的字典%@",inModel);
            if (!outModel){
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
            }
            else if (outModel.code ==1000)
            {
                DLog(@"@@@@@@@@@@@@@@@@@@@@%d",_body.successcount);
                [[iToast makeText:@"到货成功，继续扫描!"] show];
                
                _path=@"success";
                [self playAudio];
                
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                
                _orderCheck=_orderid;
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
            else if (outModel.code ==1001)
            {
                
                [[iToast makeText:outModel.message] show];
                NSLog(@"到货失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                
                _orderCheck=_orderid;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
            else{
                _orderCheck=_orderid;
                
                DLog(@"到货不知道原因失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                
                [[iToast makeText:outModel.message] show];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }
        });
        
    });
    
}


//取消单号
- (void)cancelOrderWithIndex:(NSInteger)index;
{
    [_goodsArray removeObjectAtIndex:index];
    [_goodsTableview reloadData];
}



-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((SCREEN_WIDTH-imageView.width)/2, CGRectGetMinY(imageView.frame)+5+1.5*num, imageView.width,1);
        
        if (num ==(int)(( SWidth-10)/2)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame =CGRectMake((SCREEN_WIDTH-imageView.width)/2, CGRectGetMinY(imageView.frame)+5+1.5*num,imageView.width,1);
        
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
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
    // 1.获取屏幕的frame
    CGRect viewRect = self.view.frame;
    
    // 2.获取扫描容器的frame
    CGRect containerRect = imageView.frame;
    
    CGFloat x = containerRect.origin.y / viewRect.size.height;
    CGFloat y = containerRect.origin.x / viewRect.size.width;
    
    CGFloat width = containerRect.size.height / viewRect.size.height;
    
    CGFloat height = containerRect.size.width / viewRect.size.width;
    
    _output.rectOfInterest = CGRectMake(x, y, width, height);
    
//    _output.rectOfInterest =[self rectOfInterestByScanViewRect:imageView.frame];//CGRectMake(0.1, 0, 0.9, 1);//
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
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    
    // Preview
    AVCaptureVideoPreviewLayer *preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    preview.videoGravity = AVLayerVideoGravityResize;
    preview.frame = self.view.bounds;
    [self.view.layer insertSublayer:preview atIndex:0];
    
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
    if (!stringValue || [stringValue isEqualToString:@""]) {
        return;
    }
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
//
//    _orderId=stringValue;
//    BOOL isHaving = NO;
//    for (int i = 0; i < [_goodsArray count]; i++) {
//        NSString *temp = [_goodsArray objectAtIndex:i];
//        if (!isHaving) {
//            if ([temp isEqualToString:stringValue]) {
//                isHaving = YES;
//            }else
//            {
//                isHaving = NO;
//            }
//        }
//        
//    }
    //    if (_goodsArray.count>19) {
    //        [[iToast makeText:@"一次最多可扫描20单!"] show];
    //        return;
    //    }
//    if (isHaving) {
//        [[iToast makeText:@"该单已扫入成功,不可重复扫描!"] show];
//        return;
//    }else
//    {
//        [_goodsArray addObject:stringValue];
        _orderid = stringValue;
    
        
//    }
//    [_goodsTableview reloadData];
    
    //[_session stopRunning];
    if (_type == 2){
    [self confirmGoodsClick ];//领货
    }else if (_type==4){
        [self getGoodsClick];//到货
    }
//    [[iToast makeText:@"扫描成功!"] show];
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
    CGFloat height = 360;
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
    CGFloat alpha = 0.7;
    UIColor *backColor = [UIColor blackColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}

#pragma mark 语音播放
-(void)playAudio{
    NSString *string = [[NSBundle mainBundle] pathForResource:_path ofType:@"wav"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    self.avAudioPlayer.delegate = self;
    
    //设置初始音量大小
    self.avAudioPlayer.volume = 1;
    
    //设置音乐播放次数  -1为一直循环
    self.avAudioPlayer.numberOfLoops = 0;
    
    //预播放
    [self.avAudioPlayer prepareToPlay];
    
    if ([self.avAudioPlayer isPlaying]==YES) {
        
        NSLog(@"播放了");
    }
    
}

-(void)initSubViews{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 10)];
        [self.view addSubview:_lineLabel];
        _lineLabel.backgroundColor = [UIColor colorWithRed:0.8784 green:0.8706 blue:0.8784 alpha:1.0];
        
    }
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _lineLabel.y +_lineLabel.height, SCREEN_WIDTH, 60)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bgView];
    }
    if (!_InputBtn) {
        _InputBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10,80 , 40)];
        _InputBtn.backgroundColor = [UIColor colorWithRed:0.9137 green:0.3843 blue:0.2588 alpha:1.0];
        [_InputBtn setTitle:@"输入" forState:UIControlStateNormal];
        [_InputBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _InputBtn.layer.cornerRadius = 10;
        [_InputBtn addTarget:self action:@selector(InputBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_bgView addSubview:_InputBtn];
    }
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-50-_InputBtn.width, 40)];

        _textField.placeholder = @"    请输入订单号";
        _textField.backgroundColor = [UIColor colorWithRed:0.8980 green:0.8980 blue:0.8980 alpha:1.0];
        _textField.layer.cornerRadius = 10;
        _textField.keyboardType =  UIKeyboardTypeNumbersAndPunctuation;
        [_bgView addSubview:_textField];
    }
    
    UILabel * labIntroudction = [[UILabel alloc]initWithFrame:CGRectMake(0, _bgView.y+_bgView.height, SCREEN_WIDTH, 20)];
    [labIntroudction setText:@"将条形码放入框内，即可自动扫描"];
    labIntroudction.font = [UIFont systemFontOfSize:12];
    [labIntroudction setTextColor:[UIColor whiteColor]];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labIntroudction];
    
}

-(void)InputBtnClick{
    
    if(_textField.text.length == 0){
        [[iToast makeText:@"请输入订单号！"] show];
        return;
    }
    if (_textField.text.length > 50) {
        [[iToast makeText:@"订单号不能超过50个字符！"] show];
        return;
    }
    if ([_textField.text containsString:@"/"] || [_textField.text containsString:@"@"] || [_textField.text containsString:@"&"] || [_textField.text containsString:@"!"] || [_textField.text containsString:@"?"] || [_textField.text containsString:@"."] || [_textField.text containsString:@"("] || [_textField.text containsString:@")"] || [_textField.text containsString:@"="] || [_textField.text containsString:@":"] || [_textField.text containsString:@";"] || [_textField.text containsString:@"$"] || [_textField.text containsString:@","] || [_textField.text containsString:@"'"] ) {
        [[iToast makeText:@"订单不存在"] show];
        return;
    }
    
    switch (_type) {
        case 2://领货
        [self getGoods];
        break;
        
        case 4://到货
        [self arrivalOfGood];
        break;
            
        default:
        break;
    }
}

-(void)getGoods{//领货
   
    if ([_orderCheck isEqualToString: _textField.text]) {
        [[iToast makeText:@"订单已扫描"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"领货中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];

    In_LScanGoodsModel *inModel = [[In_LScanGoodsModel alloc] init];
    
    NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",2 ],_textField.text, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
    
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.cwbs = _textField.text;
    inModel.terminaltype = 2;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LScanGoodsModel *outModel = [[communcation sharedInstance] scanAndGetGoodsWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"领货结果的字典%@",inModel);
            _body = [[Out_LScanGoodsBody alloc] init];
            _body = outModel.data;
            if (!outModel){
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }
            else if (outModel.code ==1000)
            {
                
                [[iToast makeText:@"领货成功，继续领货!"] show];
                _path=@"success";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                _orderCheck = _textField.text;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
            else if (outModel.code ==1001)
            {
                [[iToast makeText:outModel.message] show];
                NSLog(@"领货失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                _orderCheck = nil;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }else{
        
                DLog(@"领货不知道原因失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                _orderCheck = nil;
                [[iToast makeText:outModel.message] show];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        });
    });
}

-(void)arrivalOfGood{//到货
    
    if ([_orderCheck isEqualToString: _textField.text]) {
        [[iToast makeText:@"订单已扫描"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"到货中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    In_LScanGoodsModel *inModel = [[In_LScanGoodsModel alloc] init];

    NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",2 ],_textField.text, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
    
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.cwbs = _textField.text;
    inModel.terminaltype = 2;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LScanGoodsModel *outModel = [[communcation sharedInstance] scanAndDaoGoodsWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _body = [[Out_LScanGoodsBody alloc] init];
            _body = outModel.data;
            NSLog(@"到货结果的字典%@",inModel);
            if (!outModel){
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
            }
            else if (outModel.code ==1000)
            {
                [[iToast makeText:@"到货成功，继续扫描!"] show];
                _path=@"success";
                [self playAudio];
                [self.avAudioPlayer play];
                _orderCheck = _textField.text;
                [_goodsTableview reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }else if (outModel.code ==1001){
                
                [[iToast makeText:outModel.message] show];
                NSLog(@"到货失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                _orderCheck = nil;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }else{
                DLog(@"到货不知道原因失败--%@",outModel.message);
                _path=@"fail";
                [self playAudio];
                [self.avAudioPlayer play];
                [_goodsTableview reloadData];
                _orderCheck = nil;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[iToast makeText:outModel.message] show];
            }
        });
    });
}

@end
