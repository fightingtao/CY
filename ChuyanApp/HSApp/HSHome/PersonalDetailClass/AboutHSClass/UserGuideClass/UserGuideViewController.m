//
//  UserGuideViewController.m
//  HSApp
//
//  Created by xc on 15/12/1.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "UserGuideViewController.h"

@interface UserGuideViewController ()


@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) UIScrollView *userScrollView;
@property (nonatomic, strong) UIScrollView *brokerScrollView;
@property (nonatomic, strong) UIScrollView *workScrollView;

@end

@implementation UserGuideViewController

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
        _titleLabel.text = @"新手指南";
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
    
    //加载头部选择功能
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headView];
    }
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"雇主" forState:UIControlStateNormal];
        [_button1 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button1 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        _button1.frame = CGRectMake(SCREEN_WIDTH/7, 0, SCREEN_WIDTH/7, 40);
        _button1.titleLabel.font = LittleFont;
        _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button1.selected = YES;
        [_headView addSubview:_button1];
    }
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"经纪人" forState:UIControlStateNormal];
        [_button2 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button2 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        _button2.frame = CGRectMake(SCREEN_WIDTH/7*3, 0, SCREEN_WIDTH/7, 40);
        _button2.titleLabel.font = LittleFont;
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button2];
    }
    
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitle:@"工作" forState:UIControlStateNormal];
        [_button3 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button3 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button3 addTarget:self action:@selector(button3Click) forControlEvents:UIControlEventTouchUpInside];
        _button3.frame = CGRectMake(SCREEN_WIDTH/7*5, 0, SCREEN_WIDTH/7, 40);
        _button3.titleLabel.font = LittleFont;
        _button3.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button3];
    }

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!_userScrollView) {
        _userScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
        _userScrollView.pagingEnabled = YES;
        _userScrollView.bounces = NO;
        _userScrollView.scrollEnabled = YES;
        _userScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*5, SCREEN_HEIGHT-104);
        _userScrollView.showsHorizontalScrollIndicator = NO;
        _userScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_userScrollView];
        
        for (int i = 0; i<5; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, _userScrollView.frame.size.width, _userScrollView.frame.size.height)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = WhiteBgColor;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"组-%d.png",i+1]];
            imageView.image = image;
            [_userScrollView addSubview:imageView];
            
        }
    }

    if (!_brokerScrollView) {
        _brokerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
        _brokerScrollView.pagingEnabled = YES;
        _brokerScrollView.bounces = NO;
        _brokerScrollView.scrollEnabled = YES;
        _brokerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*5, SCREEN_HEIGHT-104);
        _brokerScrollView.showsHorizontalScrollIndicator = NO;
        _brokerScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_brokerScrollView];
        
        for (int i = 0; i<5; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, _brokerScrollView.frame.size.width, _brokerScrollView.frame.size.height)];
             imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = WhiteBgColor;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"组-%d.png",i+6]];
            imageView.image = image;
            [_brokerScrollView addSubview:imageView];
            
        }
    }
    
    if (!_workScrollView) {
        _workScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2,104, SCREEN_WIDTH, SCREEN_HEIGHT-104)];
        _workScrollView.pagingEnabled = YES;
        _workScrollView.bounces = NO;
        _workScrollView.scrollEnabled = YES;
        _workScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*6, SCREEN_HEIGHT-104);
        _workScrollView.showsHorizontalScrollIndicator = NO;
        _workScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_workScrollView];
        
        for (int i = 0; i<6; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, _workScrollView.frame.size.width, _workScrollView.frame.size.height)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = WhiteBgColor;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"w%d.png",i+1]];
            imageView.image = image;
            [_workScrollView addSubview:imageView];
            
        }
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

//呼单详情
- (void)button1Click
{
    [UIView animateWithDuration:0.3 animations:^{
        _userScrollView.frame = CGRectMake(0,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _brokerScrollView.frame = CGRectMake(SCREEN_WIDTH,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _workScrollView.frame = CGRectMake(SCREEN_WIDTH, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    } completion: ^(BOOL finish){
        _button1.selected = YES;
        _button2.selected = NO;
        _button3.selected = NO;
    }];
}

//呼单状态
- (void)button2Click
{
    [UIView animateWithDuration:0.3 animations:^{
        _userScrollView.frame = CGRectMake(-SCREEN_WIDTH,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _brokerScrollView.frame = CGRectMake(0,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _workScrollView.frame = CGRectMake(SCREEN_WIDTH,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    } completion: ^(BOOL finish){
        _button1.selected = NO;
        _button2.selected = YES;
        _button3.selected = NO;
    }];
}

- (void)button3Click{
    
    [UIView animateWithDuration:0.3 animations:^{
        _userScrollView.frame = CGRectMake(-SCREEN_WIDTH*2,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _brokerScrollView.frame = CGRectMake(-SCREEN_WIDTH,104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _workScrollView.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    } completion: ^(BOOL finish){
        _button1.selected = NO;
        _button2.selected = NO;
        _button3.selected = YES;
    }];
     
}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    _brokerScrollView.hidden = YES;
    _userScrollView.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
