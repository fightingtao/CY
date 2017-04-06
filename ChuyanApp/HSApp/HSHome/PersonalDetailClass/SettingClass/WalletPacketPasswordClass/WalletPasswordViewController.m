//
//  WalletPasswordViewController.m
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WalletPasswordViewController.h"

@interface WalletPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *accountTipLabel;
@property (nonatomic, strong) UITextField *accountTxtField;
@property (nonatomic, strong) UILabel *nameTipLabel;
@property (nonatomic, strong) UITextField *nameTxtField;
@property (nonatomic, strong) UILabel *codeTipLabel;
@property (nonatomic, strong) UITextField *codeTxtField;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *bindingBtn;

@end

@implementation WalletPasswordViewController

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
        _titleLabel.text = @"设置钱包密码";
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 44)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 50, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
        _contentView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_contentView];
    }
    
    
    
    if (!_accountTipLabel) {
        _accountTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,125,50)];
        _accountTipLabel.textAlignment = NSTextAlignmentLeft;
        [_accountTipLabel setTextColor:TextMainCOLOR];
        [_accountTipLabel setFont:LittleFont];
        _accountTipLabel.text = @"    输入密码";
        [_contentView addSubview:_accountTipLabel];
    }
    
    if (!_accountTxtField) {
        _accountTxtField = [[UITextField alloc] initWithFrame:CGRectMake(125, 0, SCREEN_WIDTH-125, 50)];
        _accountTxtField.borderStyle = UITextBorderStyleNone;
        _accountTxtField.placeholder = @"输入钱包密码";
        _accountTxtField.backgroundColor = [UIColor clearColor];
        _accountTxtField.textColor = TextMainCOLOR;
        _accountTxtField.font = LittleFont;
        _accountTxtField.secureTextEntry = YES;
        _accountTxtField.keyboardType = UIKeyboardTypeNumberPad;
        _accountTxtField.delegate = self;
        [_contentView addSubview:_accountTxtField];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineColor;
    [_contentView addSubview:line];
    
    
    if (!_nameTipLabel) {
        _nameTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,50,125,50)];
        _nameTipLabel.textAlignment = NSTextAlignmentLeft;
        [_nameTipLabel setTextColor:TextMainCOLOR];
        [_nameTipLabel setFont:LittleFont];
        _nameTipLabel.text = @"    确认密码";
        [_contentView addSubview:_nameTipLabel];
    }
    
    if (!_nameTxtField) {
        _nameTxtField = [[UITextField alloc] initWithFrame:CGRectMake(125, 50, SCREEN_WIDTH-125, 50)];
        _nameTxtField.borderStyle = UITextBorderStyleNone;
        _nameTxtField.placeholder = @"确认钱包密码";
        _nameTxtField.backgroundColor = [UIColor clearColor];
        _nameTxtField.textColor = TextMainCOLOR;
        _nameTxtField.font = LittleFont;
        _nameTxtField.secureTextEntry = YES;
        _nameTxtField.keyboardType = UIKeyboardTypeNumberPad;
        _nameTxtField.delegate = self;
        [_contentView addSubview:_nameTxtField];
    }
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 1)];
    line2.backgroundColor = LineColor;
    [_contentView addSubview:line2];
    
    
    if (!_codeTipLabel) {
        _codeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,100,125,50)];
        _codeTipLabel.textAlignment = NSTextAlignmentLeft;
        [_codeTipLabel setTextColor:TextMainCOLOR];
        [_codeTipLabel setFont:LittleFont];
        _codeTipLabel.text = @"    验证码";
        [_contentView addSubview:_codeTipLabel];
    }
    
    if (!_codeTxtField) {
        _codeTxtField = [[UITextField alloc] initWithFrame:CGRectMake(125, 100, 125, 50)];
        _codeTxtField.borderStyle = UITextBorderStyleNone;
        _codeTxtField.placeholder = @"输入验证码";
        _codeTxtField.backgroundColor = [UIColor clearColor];
        _codeTxtField.textColor = TextMainCOLOR;
        _codeTxtField.font = LittleFont;
        _codeTxtField.keyboardType = UIKeyboardTypeNumberPad;
        [_contentView addSubview:_codeTxtField];
    }
    
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _codeBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _codeBtn.layer.borderWidth = 0.5;
        _codeBtn.layer.cornerRadius = 5;
        [_codeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.frame = CGRectMake(SCREEN_WIDTH-92, 113, 72, 23);
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_contentView addSubview:_codeBtn];
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        if (userInfoModel.isSetPayPassword == 0) {
            _titleLabel.text = @"设置钱包密码";

        }
        else if (userInfoModel.isSetPayPassword == 1)
        {
            _titleLabel.text = @"修改钱包密码";

        }
    }else
    {
        [[iToast makeText:@"请先登录!"] show];
        [self leftItemClick];
    }

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];

    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        if (userInfoModel.isSetPayPassword == 0) {
            _titleLabel.text = @"设置钱包密码";
            
        }
        else if (userInfoModel.isSetPayPassword == 1)
        {
            _titleLabel.text = @"修改钱包密码";
            
        }
    }else
    {
        [[iToast makeText:@"请先登录!"] show];
        [self leftItemClick];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_accountTxtField resignFirstResponder];
    [_nameTxtField resignFirstResponder];
    [_codeTxtField resignFirstResponder];
    
    if (_accountTxtField.text.length == 0) {
        [[iToast makeText:@"请输入钱包密码!"] show];
        return;
    }
    if (_nameTxtField.text.length == 0) {
        [[iToast makeText:@"请确认钱包密码!"] show];
        return;
    }
    if (![_accountTxtField.text isEqualToString:_nameTxtField.text]) {
        [[iToast makeText:@"请确认两次输入的钱包密码一致!"] show];
        return;
    }
    
    [self startCodeTime];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hmacString = [[communcation sharedInstance] hmac:userInfoModel.telephone withKey:userInfoModel.primaryKey];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_MoneyCodeModel *outModel = [[communcation sharedInstance] getMoneyCodeWithPhone:userInfoModel.telephone AndKey:userInfoModel.userId AndDigest:hmacString];
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


//导航栏左右侧按钮点击

- (void)rightItemClick
{
    [_accountTxtField resignFirstResponder];
    [_nameTxtField resignFirstResponder];
    [_codeTxtField resignFirstResponder];
    if (_accountTxtField.text.length == 0) {
        [[iToast makeText:@"请输入钱包密码!"] show];
        return;
    }
    if (_nameTxtField.text.length == 0) {
        [[iToast makeText:@"请确认钱包密码!"] show];
        return;
    }
    if (![_accountTxtField.text isEqualToString:_nameTxtField.text]) {
        [[iToast makeText:@"请确认两次输入的钱包密码一致!"] show];
        return;
    }
    if (_codeTxtField.text.length == 0) {
        [[iToast makeText:@"请输入验证码!"] show];
        return;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"修改中";
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[[communcation sharedInstance] getmd5:_accountTxtField.text],_codeTxtField.text, nil];
    NSString *hmacString = [[communcation sharedInstance]  ArrayCompareAndHMac:dataArray];
    In_SetMoneyPwdModel *inModel = [[In_SetMoneyPwdModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hmacString;
    inModel.user_id = userInfoModel.userId;
    inModel.password = [[communcation sharedInstance] getmd5:_accountTxtField.text];
    inModel.code = _codeTxtField.text;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_SetMoneyPwdModel *outModel = [[communcation sharedInstance] setMoneyPwdWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
               [[iToast makeText:@"密码设置成功!"] show];
                [self leftItemClick];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
    });

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_accountTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 6) { //如果输入框内容大于11则弹出警告
            textField.text = [toBeString substringToIndex:5];
        }
    }
    
    if (_nameTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 6) { //如果输入框内容大于11则弹出警告
            textField.text = [toBeString substringToIndex:5];
        }
    }
    return YES;
}


- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
