//
//  AboutVersionViewController.m
//  HSApp
//
//  Created by xc on 15/11/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AboutVersionViewController.h"

@interface AboutVersionViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *conpanyLabel;
@end

@implementation AboutVersionViewController

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
        _titleLabel.text = @"版本介绍";
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
    
    
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2, 104, 120, 120)];
        _iconImg.image = [UIImage imageNamed:@"icon_version.png"];
        [self.view addSubview:_iconImg];
    }
    
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,230,SCREEN_WIDTH,20)];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        [_versionLabel setTextColor:TextMainCOLOR];
        [_versionLabel setFont:LittleFont];
        _versionLabel.text = [NSString stringWithFormat:@"V%@",kVersion];
        [self.view addSubview:_versionLabel];
    }
    
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,240,SCREEN_WIDTH-80,60)];
        _infoLabel.numberOfLines = 2;
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        [_infoLabel setTextColor:TextMainCOLOR];
        [_infoLabel setFont:LittleFont];
        _infoLabel.text = @"雏燕是一款为时间宝贵的个人，打理生活琐事的懒人神器";
        [self.view addSubview:_infoLabel];
    }
    
    if (!_conpanyLabel) {
        _conpanyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-30,SCREEN_WIDTH,20)];
        _conpanyLabel.textAlignment = NSTextAlignmentCenter;
        [_conpanyLabel setTextColor:TextDetailCOLOR];
        [_conpanyLabel setFont:[UIFont systemFontOfSize:12.0]];
        _conpanyLabel.text = @"Copyright©2015 HuSong.All Rights Reserved";
        [self.view addSubview:_conpanyLabel];
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
@end
