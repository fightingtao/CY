//
//  LSendMsgViewController.m
//  HSApp
//
//  Created by xc on 16/2/16.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LSendMsgViewController.h"

@interface LSendMsgViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITextView *demandTextView;//文字需求内容

@end

@implementation LSendMsgViewController

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
        _titleLabel.text = @"发送短信";
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
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    
    if (!_demandTextView) {
        _demandTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        _demandTextView.textColor = TextMainCOLOR;//设置textview里面的字体颜色
        _demandTextView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
        _demandTextView.delegate = self;//设置它的委托方法
        _demandTextView.backgroundColor = WhiteBgColor;//设置它的背景颜色
        _demandTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
        _demandTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _demandTextView.scrollEnabled = NO;//是否可以拖动
        _demandTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_demandTextView];
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

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//导航栏左右侧按钮点击

- (void)rightItemClick
{
    if (_demandTextView.text.length == 0) {
        [[iToast makeText:@"请输入您的短信内容!"] show];
        return;
    }
    
    [_demandTextView resignFirstResponder];
    
    NSString *content = _demandTextView.text;
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"提交中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:content,_mobileStr,_nameStr, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    In_LSendMsgModel *inModel = [[In_LSendMsgModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.mobiles = _mobileStr;
    inModel.recipients = _nameStr;
    inModel.senddetail = content;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LSendMsgModel *outModel = [[communcation sharedInstance] userSendMsgWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已成功短信通知用户!"] show];
                [self leftItemClick];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [self.demandTextView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.demandTextView.text.length==0){//textview长度为0
        
    }else{//textview长度不为0
        if (self.demandTextView.text.length==1){//textview长度为1时候
        }
    }
    return YES;
}

@end
