//
//  EditUserVoiceViewController.m
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "EditUserVoiceViewController.h"

@interface EditUserVoiceViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation EditUserVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        _titleLabel.text = @"江湖口号";
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
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    if (!_demandTextView) {
        _demandTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 85)];
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
    
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH, 20)];
        _placeLabel.numberOfLines = 1;
        _placeLabel.backgroundColor = [UIColor clearColor];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.font = LittleFont;
        _placeLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        _placeLabel.text = @"输入您的江湖口号，限30字";
        [self.view addSubview:_placeLabel];
    }
    

    
}
//-(void  )BackBtnClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


////导航栏左右侧按钮点击
//
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];

}


//导航栏左右侧按钮点击
- (void)rightItemClick
{
    [_demandTextView resignFirstResponder];
    if (_demandTextView.text.length == 0) {
        [[iToast makeText:@"请输入您的江湖口号!"] show];
        return;
    }
    if (_demandTextView.text.length > 30) {
        [[iToast makeText:@"请输入30字以内江湖口号!"] show];
        return;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"修改中";
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_demandTextView.text, nil];
    NSString *hmacString = [[communcation sharedInstance]  ArrayCompareAndHMac:dataArray];
    In_EditUserDeclare *inModel = [[In_EditUserDeclare alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hmacString;
    inModel.user_id = userInfoModel.userId;
    inModel.declaration = _demandTextView.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_EditUserDeclare *outModel = [[communcation sharedInstance] editUserDeclareWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"江湖口号编辑成功!"] show];
                [self dismissViewControllerAnimated:YES completion:nil];
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
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeLabel.hidden=NO;//隐藏文字
        }else{
            _placeLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.demandTextView.text.length==1){//textview长度为1时候
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
@end
