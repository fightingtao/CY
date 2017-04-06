//
//  RegisterViewController.m
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegistDelegateViewController.h"

@interface RegisterViewController ()

{
    NSString *localCity;
    
    BOOL _protocolYES;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *phoneImg;
@property (nonatomic, strong) UITextField *phoneTxtField;
@property (nonatomic, strong) UIImageView *codeImg;
@property (nonatomic, strong) UITextField *codeTxtField;
@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, strong) UIView *inviteView;
@property (nonatomic, strong) UIImageView *inviteImg;
@property (nonatomic, strong) UITextField *inviteTxtField;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UILabel *delegateLabel;
@property (nonatomic, strong) UIButton *delegateBtn;
@property (nonatomic, strong) UIButton *checkBtn;

@end

@implementation RegisterViewController

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
        _titleLabel.text = @"注册";
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
    
    
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
        _contentView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_contentView];
    }
    
    if (!_phoneImg) {
        _phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12.5, 25, 25)];
        _phoneImg.image = [UIImage imageNamed:@"icon_login_phone"];
        [_contentView addSubview:_phoneImg];
    }
    
    if (!_phoneTxtField) {
        _phoneTxtField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-80, 50)];
        _phoneTxtField.borderStyle = UITextBorderStyleNone;
        _phoneTxtField.placeholder = @"输入手机号";
        _phoneTxtField.backgroundColor = [UIColor clearColor];
        _phoneTxtField.textColor = TextMainCOLOR;
        _phoneTxtField.font = LittleFont;
        _phoneTxtField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTxtField.delegate = self;
        _phoneTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_contentView addSubview:_phoneTxtField];
    }
    
    if (!_codeImg) {
        _codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 62.5, 25, 25)];
        _codeImg.image = [UIImage imageNamed:@"icon_password"];
        [_contentView addSubview:_codeImg];
    }
    
    if (!_codeTxtField) {
        _codeTxtField = [[UITextField alloc] initWithFrame:CGRectMake(60, 50, SCREEN_WIDTH-150, 50)];
        _codeTxtField.borderStyle = UITextBorderStyleNone;
        _codeTxtField.placeholder = @"输入验证码";
        _codeTxtField.backgroundColor = [UIColor clearColor];
        _codeTxtField.textColor = TextMainCOLOR;
        _codeTxtField.font = LittleFont;
        _codeTxtField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_contentView addSubview:_codeTxtField];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [_contentView addSubview:line];
    
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _codeBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _codeBtn.layer.borderWidth = 0.5;
        _codeBtn.layer.cornerRadius = 5;
        [_codeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.frame = CGRectMake(SCREEN_WIDTH-92, 63.5, 72, 23);
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_contentView addSubview:_codeBtn];
    }
    
    if (!_inviteView) {
        _inviteView = [[UIView alloc] initWithFrame:CGRectMake(0, 174, SCREEN_WIDTH, 50)];
        _inviteView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_inviteView];
    }
    
    if (!_inviteImg) {
        _inviteImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12.5, 25, 25)];
        _inviteImg.image = [UIImage imageNamed:@"icon_key"];
        [_inviteView addSubview:_inviteImg];
    }
    
    if (!_inviteTxtField) {
        _inviteTxtField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-80, 50)];
        _inviteTxtField.borderStyle = UITextBorderStyleNone;
        _inviteTxtField.placeholder = @"输入邀请码，没有可跳过此步骤";
        _inviteTxtField.backgroundColor = [UIColor clearColor];
        _inviteTxtField.textColor = TextMainCOLOR;
        _inviteTxtField.font = LittleFont;
        _inviteTxtField.keyboardType = UIKeyboardTypePhonePad;
        _inviteTxtField.delegate = self;
        _inviteTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_inviteView addSubview:_inviteTxtField];
    }
    
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(20,SCREEN_HEIGHT-50, SCREEN_WIDTH-40, 40);
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _registerBtn.layer.borderWidth = 0.5;
        _registerBtn.layer.cornerRadius = 5;
        [_registerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_registerBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_registerBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_registerBtn];
    }
    
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.frame = CGRectMake(20, 230, 20, 20);
        _checkBtn.backgroundColor = [UIColor whiteColor];
        [_checkBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"btn_check_cellect"] forState:UIControlStateSelected];
        [_checkBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_checkBtn];
        _protocolYES = NO;
    }
    
    if (!_delegateLabel) {
        _delegateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,230, 100, 20)];
        _delegateLabel.backgroundColor = [UIColor clearColor];
        _delegateLabel.font = LittleFont;
        _delegateLabel.textColor = TextMainCOLOR;
        _delegateLabel.text = @"我已阅读并同意";
        _delegateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _delegateLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_delegateLabel];
    }
    if (!_delegateBtn) {
        _delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delegateBtn.frame = CGRectMake(140, 230, 100, 20);
        _delegateBtn.backgroundColor = [UIColor clearColor];
        [_delegateBtn setTitle: @"《注册协议》" forState:UIControlStateNormal];
        [_delegateBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _delegateBtn.titleLabel.font = LittleFont;
        [_delegateBtn addTarget:self action:@selector(delegateClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_delegateBtn];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self AddressAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//获取验证码事件处理
- (void)getCodeClick
{
    [_phoneTxtField resignFirstResponder];
    [_codeTxtField resignFirstResponder];
    
    if (_phoneTxtField.text.length == 0) {
        [[iToast makeText:@"请输入手机号"] show];
        return;
    }
    if (![[communcation sharedInstance]checkTel:_phoneTxtField.text]) {
        return;
    }
    [self startCodeTime];
    In_RegisterCodeModel *inModel = [[In_RegisterCodeModel alloc] init];
    inModel.telephone = _phoneTxtField.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_RegisterCodeModel *outModel = [[communcation sharedInstance] getRegisterCodeWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"验证码发送成功!"] show];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
    });

}

//发送验证码倒计时
- (void)startCodeTime
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_codeBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
                _codeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_codeBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                [_codeBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
                _codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}



//注册
- (void)registerClick
{
    if (_phoneTxtField.text.length == 0) {
        [[iToast makeText:@"请输入手机号"] show];
        return;
    }
    if (_codeTxtField.text.length == 0) {
        [[iToast makeText:@"请输入验证码"] show];
        return;
    }
    if (!localCity ||[localCity isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"定位失败，请检查是否打开定位服务!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];

         [[iToast makeText:@"定位失败，请检查是否打开定位服务!"] show];
        return;
    }
    if (!_protocolYES) {
        [[iToast makeText:@"请确认并同意《注册协议》!"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"注册中";
    In_RegisterModel *inModel = [[In_RegisterModel alloc] init];
    inModel.telephone = _phoneTxtField.text;
    inModel.cityname = localCity;
    inModel.code = _codeTxtField.text;
    inModel.inviteCode = _inviteTxtField.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_RegisterModel *outModel = [[communcation sharedInstance] registerAccountWithModel:inModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                UserInfoSaveModel *saveModel = [[UserInfoSaveModel alloc] init];
                saveModel.primaryKey = outModel.data.primaryKey;
                saveModel.key = outModel.data.key;
                saveModel.userId = outModel.data.userId;
                saveModel.username = outModel.data.username;
                saveModel.type = outModel.data.type;
                saveModel.status = outModel.data.status;
                saveModel.isdelete = outModel.data.isdelete;
                saveModel.header = outModel.data.header;
                saveModel.telephone = outModel.data.telephone;
                saveModel.gender = outModel.data.gender;
                saveModel.notifyid = outModel.data.notifyid;
                saveModel.level = outModel.data.level;
                saveModel.point = outModel.data.point;
                saveModel.istested = outModel.data.istested;
                saveModel.istrained = outModel.data.istrained;
                saveModel.cityName = outModel.data.cityName;
                saveModel.tag = outModel.data.tag;
                saveModel.positiveIdPath = outModel.data.positiveIdPath;
                saveModel.negativeIdPath = outModel.data.negativeIdPath;
                saveModel.handIdPath = outModel.data.handIdPath;
                saveModel.authenTelephone = outModel.data.authenTelephone;
                saveModel.realName = outModel.data.realName;
                saveModel.idNum = outModel.data.idNum;
                saveModel.brokerStatus = outModel.data.brokerStatus;
                saveModel.isbroker = outModel.data.isbroker;
                saveModel.declaration = outModel.data.declaration;
                saveModel.birthday = outModel.data.birthday;
                saveModel.isauthen = outModel.data.isauthen;
                saveModel.stars = outModel.data.stars;
                saveModel.title = outModel.data.title;
                saveModel.isFirst = @"1";
                saveModel.isSetPayPassword = outModel.data.isSetPayPassword;
                saveModel.isBindWithdrawAccount = outModel.data.isBindWithdrawAccount;
                saveModel.iswork = outModel.data.iswork;
                NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:saveModel];
                [userDefault setObject:setData forKey:UserKey];
                NSSet *set = [[NSSet alloc] initWithObjects:outModel.data.tag, nil];
                [APService setTags:set alias:outModel.data.notifyid callbackSelector:nil object:nil];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
    });

}



//定位地址
- (void)AddressAction
{
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@",userLocation.heading);
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [_locService stopUserLocationService];
    
    BMKGeoCodeSearch *bmGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    bmGeoCodeSearch.delegate = self;
    
    BMKReverseGeoCodeOption *bmOp = [[BMKReverseGeoCodeOption alloc] init];
    bmOp.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL geoCodeOk = [bmGeoCodeSearch reverseGeoCode:bmOp];
    if (geoCodeOk) {
        NSLog(@"ok");
    }
}

///选择协议
- (void)selectClick:(id)sender{
    _checkBtn.selected = !_checkBtn.selected;
    if (_checkBtn.selected)
    {
        _protocolYES = YES;
    }else{
        _protocolYES = NO;
    }
    
}

///查看协议
- (void)delegateClick{

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RegistDelegateViewController *registDelegate = [[RegistDelegateViewController alloc]init];
    [app.menuViewController pushToNewViewController:registDelegate animation:YES];
}


- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    BMKAddressComponent *tempAddress = result.addressDetail;
    localCity = tempAddress.city;
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
     [[iToast makeText:@"定位失败，请检查是否打开定位服务!"] show];
}


//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        [textField resignFirstResponder];
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_phoneTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于11则弹出警告
            textField.text = [toBeString substringToIndex:10];
        }
    }
    return YES;
}


@end
