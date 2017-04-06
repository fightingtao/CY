//
//  LoginViewController.m
//  HSApp
//
//  Created by 李志明 on 16/11/30.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LoginViewController.h"
#import "LOrderDetailViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextFiled;//账号
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;//密码
@property (weak, nonatomic) IBOutlet UIButton *accontBtn;
@property (weak, nonatomic) IBOutlet UIButton *passwordBtn;
@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    _accountTextFiled.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeno"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    //温馨提示边框
    self.noticeView.layer.borderWidth = 1;
    self.noticeView.layer.borderColor = [UIColor colorWithRed:0.9255 green:0.9255 blue:0.9255 alpha:1.0].CGColor;
    self.noticeView.layer.cornerRadius = 30;
    self.accontBtn.hidden = YES;
    self.passwordBtn.hidden = YES;
    self.passwordTextFiled.secureTextEntry = YES;
    
    //监听键盘的升起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset =   SCREEN_HEIGHT-300-kbHeight;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (offset < 0 ) {
        //将视图上移计算好的偏移
        
        [UIView animateWithDuration:duration animations:^{
            
            self.view.frame = CGRectMake(0.0f,offset, SCREEN_WIDTH, 60);
        }];
    }
}

//键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT);
    }];
}

- (IBAction)valueChange:(UITextField *)sender {
    if (_accountTextFiled.text.length >0) {
         _accontBtn.hidden = NO;
    }
}

- (IBAction)passWordChange:(UITextField *)sender {
    if (_passwordTextFiled.text.length >0) {
         _passwordBtn.hidden = NO;
    }
}

- (IBAction)accountBtnClick:(id)sender {
    _accountTextFiled.text = nil;
    _accontBtn.hidden = YES;
}

- (IBAction)passwordBtnclick:(id)sender {
    _passwordTextFiled.text = nil;
    _passwordBtn.hidden = YES;
}

#pragma mark 登录按钮点击
- (IBAction)loginBtnClick:(id)sender {

  if (_accountTextFiled.text.length == 0) {
        [[iToast makeText:@"请输入您的雏燕账号！！！"] show];
        return;
    }
    if(_passwordTextFiled.text.length == 0){
       [[iToast makeText:@"请输入您的密码！！！"] show];
        return;
    }
    if(_accountTextFiled.text.length == 0 && _passwordTextFiled.text.length == 0){
        [[iToast makeText:@"请输入您的账号和密码！！！"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"登录中...";
    In_LoginModel *inModel = [[In_LoginModel alloc] init];
        inModel.employeeno = _accountTextFiled.text;
        inModel.password = _passwordTextFiled.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LoginModel *outModel = [[communcation sharedInstance] userLoginWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                UserInfoSaveModel *saveModel = [[UserInfoSaveModel alloc] init];
                //                NSLog(@"dianhua %@",saveModel.telephone);
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
               //saveModel.isFirst = @"1";
                saveModel.isSetPayPassword = outModel.data.isSetPayPassword;
                saveModel.isBindWithdrawAccount = outModel.data.isBindWithdrawAccount;
                saveModel.iswork = outModel.data.iswork;
                saveModel.companycode = outModel.data.companycode;
                NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:saveModel];
                [userDefault setObject:setData forKey:UserKey];
                [userDefault synchronize];
                NSSet *set = [[NSSet alloc] initWithObjects:outModel.data.tag, nil];
                [APService setTags:set alias:outModel.data.notifyid callbackSelector:nil object:nil];
                self.navigationController.navigationBar.hidden = NO;
                [self.navigationController popToRootViewControllerAnimated:YES];
                [userDefault setObject:_accountTextFiled.text forKey:@"employeeno"];
            }else{
                
                [[iToast makeText:outModel.message] show];
            }
        });
    });
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

@end
