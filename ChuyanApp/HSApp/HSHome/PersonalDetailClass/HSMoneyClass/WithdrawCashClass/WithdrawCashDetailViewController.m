//
//  WithdrawCashDetailViewController.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WithdrawCashDetailViewController.h"


#import "InputPwdViewController.h"
#import "WalletPasswordViewController.h"

@interface WithdrawCashDetailViewController ()<InputPwdDelegate>
{
    BOOL isHaveDian;
    NSArray *_accountArray;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *accountTipLabel;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UILabel *cashTipLabel;
@property (nonatomic, strong) UITextField *cashTxtField;

@property (nonatomic, strong) UILabel *enableMoneyLabel;
@property (nonatomic,strong) UITextView *textView;

@property (nonatomic, strong) UIButton *withdrawBtn;

@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) InputPwdViewController *inputPwdVC;

@end

@implementation WithdrawCashDetailViewController

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
        _titleLabel.text = @"申请提现";
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
    
    if (!_accountTipLabel) {
        _accountTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,125,50)];
        _accountTipLabel.textAlignment = NSTextAlignmentCenter;
        [_accountTipLabel setTextColor:TextMainCOLOR];
        [_accountTipLabel setFont:LittleFont];
        _accountTipLabel.text = @"支付宝账号";
        [_contentView addSubview:_accountTipLabel];
    }
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(125,0,SCREEN_WIDTH- 125,50)];
        _accountLabel.textAlignment = NSTextAlignmentLeft;
        [_accountLabel setTextColor:TextMainCOLOR];
        [_accountLabel setFont:LittleFont];
        _accountLabel.text = @"";
        [_contentView addSubview:_accountLabel];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineColor;
    [_contentView addSubview:line];
    
    if (!_cashTipLabel) {
        _cashTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,50,125,50)];
        _cashTipLabel.textAlignment = NSTextAlignmentCenter;
        [_cashTipLabel setTextColor:TextMainCOLOR];
        [_cashTipLabel setFont:LittleFont];
        _cashTipLabel.text = @"提现金额";
        [_contentView addSubview:_cashTipLabel];
    }
    
    if (!_cashTxtField) {
        _cashTxtField = [[UITextField alloc] initWithFrame:CGRectMake(125, 50, SCREEN_WIDTH-125, 50)];
        _cashTxtField.borderStyle = UITextBorderStyleNone;
        _cashTxtField.placeholder = @"输入提现金额";
        _cashTxtField.backgroundColor = [UIColor clearColor];
        _cashTxtField.textColor = TextMainCOLOR;
        _cashTxtField.font = [UIFont systemFontOfSize:15];
        _cashTxtField.delegate = self;
        [_contentView addSubview:_cashTxtField];
    }
    
    
    if (!_textView) {
        _textView= [[UITextView alloc] initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH-40, SCREEN_HEIGHT-210)]; //初始化大小并自动释放
        
        _textView.textColor = TextDetailCOLOR;//设置textview里面的字体颜色
        
        _textView.font = [UIFont fontWithName:@"Arial" size:12.0];//设置字体名字和字体大小
        
        _textView.backgroundColor = ViewBgColor;//设置它的背景颜色
        
        _textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
        
        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _textView.editable = NO;
        _textView.scrollEnabled = YES;//是否可以拖动
        
        NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:@"备注：\n\n1.提现金额不限，但每次提现只是收取小费的10%技术服务费，最低收取5元手续费，建议小费满50元再申请提\n\n2.提现打款周期：\na.当日中午12点前申请提现的，若如无异常订单，将在后天内进行打款（T+2)；如遇到国家节假日将顺延。（例如周三中午11点申请提现的，将在周五进行打款；周四中午11点申请提现的，将在下周一进行打款）\nb.目前仅支持使用支付宝提现，打款后最快1天既能到账"];
        
        //设置的是字的颜色
        [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(19, 10)];
        [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 19)];
        [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(29, attributedTextString.length-29)];
        _textView.attributedText = attributedTextString;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_textView];
    }
    
    
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _withdrawBtn.frame = CGRectMake(20,SCREEN_HEIGHT-50, SCREEN_WIDTH-40, 40);
        [_withdrawBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        [_withdrawBtn addTarget:self action:@selector(withdrawCashClick) forControlEvents:UIControlEventTouchUpInside];
        _withdrawBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _withdrawBtn.layer.borderWidth = 0.5;
        _withdrawBtn.layer.cornerRadius = 5;
        [_withdrawBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_withdrawBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_withdrawBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_withdrawBtn];
    }
    
    
    if (!_enableMoneyLabel) {
        _enableMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 174, SCREEN_WIDTH-80, 20)];
        _enableMoneyLabel.textColor =  TextMainCOLOR;
        _enableMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _enableMoneyLabel.font = LittleFont;
        NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最多可转出余额:--"]];
        [tipStr addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 8)];
        [tipStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, 2)];
        _enableMoneyLabel.attributedText = tipStr;
        [self.view addSubview:_enableMoneyLabel];
    }
    
    //提示页面
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    
    if (!_inputPwdVC) {
        _inputPwdVC = [[InputPwdViewController alloc] init];
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 200);
        _inputPwdVC.view.backgroundColor = [UIColor whiteColor];
        _inputPwdVC.delegate = self;
    }
    
    [self getWithdrawAccount];
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
- (void)getWithdrawAccount
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *hmacString = [[communcation sharedInstance] hmac:userInfoModel.userId withKey:userInfoModel.primaryKey];
        Out_WithdrawBindingModel *outModel = [[communcation sharedInstance] getWithdrawBindingAccountWithKey:userInfoModel.userId AndDigest:hmacString AndUserId:userInfoModel.userId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _accountArray = outModel.data;
                if ([_accountArray count] != 0) {
                    Out_WithdrawBindingBody *model = [_accountArray objectAtIndex:0];
                    _accountLabel.text = model.account_no;
                    NSString *string = [NSString stringWithFormat:@"最多可转出余额:￥%0.2f",_enableMoney];
                    NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc] initWithString:string];
                    [tipStr addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 8)];
                    [tipStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, string.length -8)];
                    _enableMoneyLabel.attributedText = tipStr;
                }else
                {
                    [[iToast makeText:@"绑定支付宝账号出错,请重新绑定!"] show];
                }
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


- (void)withdrawCashClick
{
    if (_cashTxtField.text.length == 0) {
        [[iToast makeText:@"输入您的提现金额！"] show];
        return;
    }
    [self.view addSubview:_maskView];
    [self.view addSubview:_inputPwdVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.7;
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT-400, SCREEN_WIDTH, 400);
    } completion: ^(BOOL finish)
     {
         [[iToast makeText:@"输入您的钱包密码！"] show];
     }];
}



- (void)passwordInputWithPWd:(NSString *)pwd
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"提交中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if ([_accountArray count] != 0) {
        Out_WithdrawBindingBody *model = [_accountArray objectAtIndex:0];
        
        NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,model.bindid,[NSString stringWithFormat:@"%0.2f",[_cashTxtField.text doubleValue]],[[communcation sharedInstance] getmd5:pwd], nil];
        NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        In_WithdrawCashModel *inModel = [[In_WithdrawCashModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hamcString;
        inModel.user_id = userInfoModel.userId;
        inModel.bindaccountid = model.bindid;
        inModel.amount = [_cashTxtField.text doubleValue];
        inModel.password = [[communcation sharedInstance] getmd5:pwd];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AllSameModel *outModel = [[communcation sharedInstance]withdrawCashWithModel:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"请求出错,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已申请提现,请耐心等待!"] show];
                    [self leftItemClick];
                }else{
                    [[iToast makeText:outModel.message] show];
                    [_inputPwdVC pwdWrong];
                }
            });
            
        });

    }
    
}

///取消输入密码支付
- (void)cancelInputPwd
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.0;
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    } completion: ^(BOOL finish){
        [_maskView removeFromSuperview];
        [_inputPwdVC.view removeFromSuperview];
    }];
}

///忘记密码
- (void)forgetPassword
{
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.0;
        _inputPwdVC.view.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    } completion: ^(BOOL finish){
        [_maskView removeFromSuperview];
        [_inputPwdVC.view removeFromSuperview];
        WalletPasswordViewController *walletPwdVC = [[WalletPasswordViewController alloc] init];
        [self.navigationController pushViewController:walletPwdVC animated:YES];
    }];
    
}



//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_cashTxtField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([_cashTxtField.text length]==0){
                if(single == '.'){
                    [_cashTxtField resignFirstResponder];
                    [[iToast makeText:@"第一个数字不能为小数点!"] show];
                    [_cashTxtField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
                if (single == '0') {
                    [_cashTxtField resignFirstResponder];
                    [[iToast makeText:@"第一个数字不能为0!"] show];
                    [_cashTxtField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [_cashTxtField resignFirstResponder];
                    [[iToast makeText:@"您已经输入过小数点了!"] show];
                    [_cashTxtField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[_cashTxtField.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        [_cashTxtField resignFirstResponder];
                        [[iToast makeText:@"您最多输入两位小数!"] show];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [_cashTxtField resignFirstResponder];
            [[iToast makeText:@"您输入的格式不正确，只可输入数字!"] show];
            [_cashTxtField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}

@end
