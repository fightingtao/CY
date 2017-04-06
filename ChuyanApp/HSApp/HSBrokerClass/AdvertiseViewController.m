//
//  AdvertiseViewController.m
//  HSApp
//
//  Created by cbwl on 16/5/2.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "AdvertiseViewController.h"
#import "publicResource.h"

@interface AdvertiseViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation AdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewBgColor;
    //添加头部菜单栏
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0,200, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = MiddleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = self.desc;
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
    
    UIWebView *WebView = [[UIWebView alloc]init];
    WebView.frame = self.view.frame;
    WebView.scalesPageToFit = YES;
    [self.view addSubview:WebView];
    
    NSString *urlSting = [_model.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlSting];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [WebView loadRequest:request];
    
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

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
