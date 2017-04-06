//
//  ComplainOrderViewController.m
//  HSApp
//
//  Created by xc on 16/1/7.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "ComplainOrderViewController.h"

@interface ComplainOrderViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic,strong) UITextView *textView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic,strong) UILabel *placeLabel;

@end

@implementation ComplainOrderViewController

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
        _titleLabel.text = @"发布需求";
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 44)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 50, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = MiddleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];

    if (!_textView) {
        _textView= [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)]; //初始化大小并自动释放
        
        _textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
        
        _textView.font = [UIFont fontWithName:@"Arial" size:15.0];//设置字体名字和字体大小
        
        _textView.delegate = self;//设置它的委托方法
        
        _textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
        
        _textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
        
        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        
        _textView.scrollEnabled = YES;//是否可以拖动
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_textView];
    }
    
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 40)];
        _placeLabel.numberOfLines = 2;
        _placeLabel.backgroundColor = [UIColor clearColor];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.font = [UIFont systemFontOfSize:15];
        _placeLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        _placeLabel.text = @"  请输入您的投诉内容";
        [self.view addSubview:_placeLabel];
    }
    
    
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45)];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"  请填写你的手机号";
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.textColor = [UIColor colorWithRed:76.0/255 green:76.0/255.0 blue:76.0/255.0 alpha:1];
        _phoneTextField.font = [UIFont systemFontOfSize:15];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        [self.view addSubview:_phoneTextField];
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [self.textView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.textView.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeLabel.hidden=NO;//隐藏文字
        }else{
            _placeLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.textView.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                _placeLabel.hidden=NO;
            }else{//不是删除
                _placeLabel.hidden=YES;
            }
        }else{//长度不为1时候
            _placeLabel.hidden=YES;
        }
    }
    return YES;
}



//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemClick
{
    [_textView resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    if (_textView.text.length == 0 || _textView.text.length>200) {
        [[iToast makeText:@"请填写您的投诉内容!"] show];
        return;
    }
    
    if (_phoneTextField.text.length != 11)
    {
        [[iToast makeText:@"请填写正确联系方式!"] show];
        return;
    }

    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"提交中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_orderId,_textView.text,_phoneTextField.text, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    In_ComplainModel *inModel = [[In_ComplainModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.userid = userInfoModel.userId;
    inModel.orderid = _orderId;
    inModel.text = _textView.text;
    inModel.telephone = _phoneTextField.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_AllSameModel *outModel = [[communcation sharedInstance] complainOrderWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您提交投诉，我们将尽快为您处理!"] show];
                [self leftItemClick];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

@end
