//
//  AboutHSViewController.m
//  HSApp
//
//  Created by xc on 15/11/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AboutHSViewController.h"
#import "PersonOtherInfoTableViewCell.h"

#import "AboutVersionViewController.h"
#import "FeedBackViewController.h"
#import "UserGuideViewController.h"

@interface AboutHSViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *aboutTableView;
@end

@implementation AboutHSViewController

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
        _titleLabel.text = @"关于雏燕";
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
    
    
    [self initpersonTableView];
    [self.view addSubview:_aboutTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_aboutTableView != nil) {
        return _aboutTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.aboutTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _aboutTableView.delegate = self;
    _aboutTableView.dataSource = self;
    _aboutTableView.backgroundColor = ViewBgColor;
    _aboutTableView.showsVerticalScrollIndicator = NO;
    _aboutTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _aboutTableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"PersonOtherInfoTableViewCell";
    PersonOtherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[PersonOtherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (indexPath.row == 0) {
        cell.titleLable.text = @"新手指南";
        cell.contentLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 1)
    {
        cell.titleLable.text = @"联系我们";
        cell.contentLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 2)
    {
        cell.titleLable.text = @"意见反馈";
        cell.contentLable.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else
    {
        cell.titleLable.text = @"版本介绍";
        cell.contentLable.hidden = YES;
        cell.arrowImg.hidden = YES;
        [cell CurrentVersion];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UserGuideViewController *guideVC = [[UserGuideViewController alloc] init];
        [self.navigationController pushViewController:guideVC animated:YES];
    }else if (indexPath.row == 1)
    {
         [self getHotline];
        
    }else if (indexPath.row == 2)
    {
        FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }else
    {
        //AboutVersionViewController *versionVC = [[AboutVersionViewController alloc] init];
        //[self.navigationController pushViewController:versionVC animated:YES];
    }
}



- (void)getHotline
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_HotLineModel *outModel = [[communcation sharedInstance] getHotLine];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",outModel.data.hotline];
                UIWebView * callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
            }else{
                [[iToast makeText:outModel.message] show];

            }
        });
        
    });
    

}

//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
@end
