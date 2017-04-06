//
//  forgetPswViewController.m
//  HSApp
//
//  Created by cbwl on 16/7/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "forgetPswViewController.h"
#import "UserInfoSaveModel.h"
#import "iToast.h"
#import "NetModel.h"
#import "MBProgressHUD.h"
#import "communcation.h"
@interface forgetPswViewController ()
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@end

@implementation forgetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
        _titleLabel.text = @"修改密码";
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:_titleLabel];
    }
    
    self.navigationItem.titleView = _titleView;
    
    _goBtn.layer.borderColor = TextMainCOLOR.CGColor;
    _goBtn.layer.borderWidth = 0.5;
    _goBtn.layer.cornerRadius = 5;

    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 30, 30);
    [leftItem setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    _phone.text=userInfoModel.telephone;

}
-(void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)onButtonClick:(id)sender {
    
    if (_pswText.text.length == 0) {
        [[iToast makeText:@"请输入密码"] show];
        return;
    }
    else  if  (![_pswSendTxt.text isEqualToString:_pswText.text])
    {
        [[iToast makeText:@"两次输入的密码必须相同"] show];
        return;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfoModel&&userInfoModel.userId && ![userInfoModel.userId isEqualToString:@""])
    {
        NSArray *array = [[NSArray alloc] initWithObjects:_phone.text,_pswText.text, nil];

        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
        
        
        in_chagnPswModel *inModel = [[in_chagnPswModel alloc] init];
        inModel.phone=_phone.text;
        inModel.psw=_pswText.text;
        
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_chagnPswModel *outModel = [[communcation sharedInstance] changePswWithInModel:inModel digest:hmacString andKey:userInfoModel.userId ];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"密码修改成功"] show];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
        });
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        [textField resignFirstResponder];
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_pswText == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:10];
        }
    }
    else if (_pswSendTxt == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:20];
            [[iToast makeText:@"密码不能超过二十位"] show];
        }
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
