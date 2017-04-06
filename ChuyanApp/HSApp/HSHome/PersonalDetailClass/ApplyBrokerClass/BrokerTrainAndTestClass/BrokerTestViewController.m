//
//  BrokerTestViewController.m
//  HSApp
//
//  Created by xc on 15/12/7.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BrokerTestViewController.h"

@interface BrokerTestViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic, strong) NSArray *questionArray;
@property (nonatomic, strong) NSMutableArray *correctArray;

@property (nonatomic, strong) UIButton *answer1;
@property (nonatomic, strong) UIButton *answer2;
@property (nonatomic, strong) UIButton *answer3;


@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation BrokerTestViewController
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteBgColor;
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
        _titleLabel.text = @"在线测试";
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
    
    
    _allCorrect = YES;
    _testAnswer = 0;
    _questionArray = [[NSMutableArray alloc] init];
    _correctArray = [[NSMutableArray alloc] init];
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-180)];
        _webView.backgroundColor = WhiteBgColor;
        _webView.delegate = self;
        [self.view addSubview: _webView];
        
    }
    
    
    if (!_answer1) {
        _answer1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_answer1 setImage:[UIImage imageNamed:@"btn_unscellect"] forState:UIControlStateNormal];
        [_answer1 setImage:[UIImage imageNamed:@"btn_scellect"] forState:UIControlStateSelected];
        [_answer1 addTarget:self action:@selector(selectClick1:) forControlEvents:UIControlEventTouchUpInside];
        [_answer1 setTitle:@" A" forState:UIControlStateNormal];
        [_answer1 setTitle:@" A" forState:UIControlStateSelected];
        _answer1.frame = CGRectMake(50, SCREEN_HEIGHT-140, 40, 40);
        _answer1.titleLabel.font = [UIFont systemFontOfSize:14];
        _answer1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _answer1.selected = NO;
        [_answer1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_answer1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.view addSubview:_answer1];
    }
    
    if (!_answer2) {
        _answer2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_answer2 setImage:[UIImage imageNamed:@"btn_unscellect"] forState:UIControlStateNormal];
        [_answer2 setImage:[UIImage imageNamed:@"btn_scellect"] forState:UIControlStateSelected];
        [_answer2 addTarget:self action:@selector(selectClick2:) forControlEvents:UIControlEventTouchUpInside];
        _answer2.frame = CGRectMake(130, SCREEN_HEIGHT-140, 40, 40);
        _answer2.titleLabel.textAlignment = NSTextAlignmentCenter;
        _answer2.selected = NO;
        _answer2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_answer2 setTitle:@" B" forState:UIControlStateNormal];
        [_answer2 setTitle:@" B" forState:UIControlStateSelected];
        [_answer2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_answer2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.view addSubview:_answer2];
    }
    
    if (!_answer3) {
        _answer3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_answer3 setImage:[UIImage imageNamed:@"btn_unscellect"] forState:UIControlStateNormal];
        [_answer3 setImage:[UIImage imageNamed:@"btn_scellect"] forState:UIControlStateSelected];
        [_answer3 addTarget:self action:@selector(selectClick3:) forControlEvents:UIControlEventTouchUpInside];
        _answer3.frame = CGRectMake(210, SCREEN_HEIGHT-140, 40, 40);
        _answer3.titleLabel.font = [UIFont systemFontOfSize:14];
        [_answer3 setTitle:@" C" forState:UIControlStateNormal];
        [_answer3 setTitle:@" C" forState:UIControlStateSelected];
        [_answer3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_answer3 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _answer3.titleLabel.textAlignment = NSTextAlignmentCenter;
        _answer3.selected = NO;
        [self.view addSubview:_answer3];
    }
    
    
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
        _nextBtn.frame = CGRectMake(20, SCREEN_HEIGHT-50, SCREEN_WIDTH - 20*2, 40);
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _nextBtn.layer.cornerRadius = 5.0f;
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:MAINCOLOR];
        [self.view addSubview:_nextBtn];
    }
    
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"完成测试" forState:UIControlStateNormal];
        _submitBtn.frame = CGRectMake(20, SCREEN_HEIGHT-50, SCREEN_WIDTH - 20*2, 40);
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _submitBtn.layer.cornerRadius = 5.0f;
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:MAINCOLOR];
        _submitBtn.hidden = YES;
        [self.view addSubview:_submitBtn];
    }

    [self getTestContent];
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
- (void)getTestContent
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        NSString *hmacString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_TestModel *outModel = [[communcation sharedInstance] getTestContentWithKey:userInfoModel.userId AndDigest:hmacString];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {

                    _questionArray = outModel.data;
                    if ([outModel.data count] != 0)
                    {
                        OutTestBody *model= [_questionArray objectAtIndex:0];
                        _questionString = model.answer;
                        _correctString = model.correct;
                        _index = 1;
                        [self.webView loadHTMLString:_questionString baseURL:nil];
                    }
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }

}

- (void)selectClick1:(id)sender
{
    if (!_answer1.selected) {
        _answer1.selected = !_answer1.selected;
    }
    if (_answer1.selected)
    {
        _testAnswer = 1;
        _answer2.selected = NO;
        _answer3.selected = NO;
    }else{
        
    }
}


- (void)selectClick2:(id)sender
{
    if (!_answer2.selected)
    {
        _answer2.selected = !_answer2.selected;
    }
    if (_answer2.selected)
    {
        _testAnswer = 2;
        _answer1.selected = NO;
        _answer3.selected = NO;
    }else{
        
    }
}

- (void)selectClick3:(id)sender
{
    if (!_answer3.selected)
    {
        _answer3.selected = !_answer3.selected;
    }
    if (_answer3.selected)
    {
        _testAnswer = 3;
        _answer2.selected = NO;
        _answer1.selected = NO;
    }else{
        
    }
}


- (void)nextClick:(id)sender
{
    if (_testAnswer==0) {
        [[iToast makeText:@"请选择一个答案!"] show];
        return;
    }
    if (_testAnswer != _correctString) {
        _allCorrect = NO;
    }
    
    _answer1.selected = NO;
    _answer2.selected = NO;
    _answer3.selected = NO;
    _testAnswer = 0;
    _index++;
    OutTestBody *model= [_questionArray objectAtIndex:_index-1];
    _questionString = model.answer;
    _correctString = model.correct;
    [self.webView loadHTMLString:_questionString baseURL:nil];
    
    if (_index == [_questionArray count])
    {
        _nextBtn.hidden = YES;
        _submitBtn.hidden = NO;
        
    }
}

- (void)submitClick:(id)sender
{
    if (_testAnswer==0) {
        [[iToast makeText:@"请选择一个答案!"] show];
        return;
    }
    if (_testAnswer != _correctString) {
        _allCorrect = NO;
    }
    if (!_allCorrect)
    {
        [[iToast makeText:@"答题错误，请重新答题!"] show];

        OutTestBody *model= [_questionArray objectAtIndex:0];
        _questionString = model.answer;
        _correctString = model.correct;

        _answer1.selected = NO;
        _answer2.selected = NO;
        _answer3.selected = NO;
        _testAnswer = 0;
        _index = 1;
        [self.webView loadHTMLString:_questionString baseURL:nil];
        _nextBtn.hidden = NO;
        _submitBtn.hidden = YES;
        _allCorrect = YES;
        return;
    }
    [self testCompleteClick];
}


//完成培训
- (void)testCompleteClick
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        NSString *hmacString = [[communcation sharedInstance] hmac:userInfoModel.userId withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_ComPleteTestModel *outModel = [[communcation sharedInstance] completeTestContentWithKey:userInfoModel.userId AndDigest:hmacString AndBrokerId:userInfoModel.userId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已经完成测试!"] show];
                    [self.delegate completeTestWithStatus:1];
                    [self leftItemClick];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }

}


- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
