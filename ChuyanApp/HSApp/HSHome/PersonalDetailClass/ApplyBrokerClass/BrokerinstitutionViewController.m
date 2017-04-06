//
//  BrokerinstitutionViewController.m
//  HSApp
//
//  Created by xc on 16/1/12.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "BrokerinstitutionViewController.h"

@interface BrokerinstitutionViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation BrokerinstitutionViewController

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
        _titleLabel.text = @"管理制度";
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
    
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        [self.view addSubview:_webView];
        //1 成就 2管理制度 3注册协议
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        NSString *string;
        if (_type == 1) {
            string = [NSString stringWithFormat:@"%@%@",UserAchieveURL,userInfoModel.userId];
            _titleLabel.text = @"成就";
        }else if (_type == 2)
        {
            string = BrokerInstitutionTURL;
            _titleLabel.text = @"管理制度";
        }else
        {
            string = BrokerInstitutionTURL;
        }
        NSString *urlSting = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL* url = [NSURL URLWithString:urlSting];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_webView loadRequest:request];
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
- (void)leftItemClick
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
