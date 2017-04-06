//
//  RewardRecommendViewController.m
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RewardRecommendViewController.h"

@interface RewardRecommendViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation RewardRecommendViewController

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
        _titleLabel.text = @"推荐有奖";
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
    
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 195)];
        _menuView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_menuView];
    }
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,35, SCREEN_WIDTH, 20)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = MiddleFont;
        _tipLabel.textColor = TextDetailCOLOR;
        _tipLabel.text = @"您的邀请码是：";
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_menuView addSubview:_tipLabel];
    }
    
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, SCREEN_WIDTH, 50)];
        _codeLabel.backgroundColor = [UIColor clearColor];
        _codeLabel.font = [UIFont systemFontOfSize:36];
        _codeLabel.textColor = TextMainCOLOR;
        _codeLabel.text = @"------";
        _codeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _codeLabel.textAlignment = NSTextAlignmentCenter;
        [_menuView addSubview:_codeLabel];
    }
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineColor;
    [_menuView addSubview:line];

    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,150, SCREEN_WIDTH, 45)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.font = MiddleFont;
        _moneyLabel.textColor = TextDetailCOLOR;
        _moneyLabel.text = @"已获--元";
        _moneyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [_menuView addSubview:_moneyLabel];
    }
    
    if (!_dealView) {
        _dealView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _dealView.backgroundColor = ViewBgColor;
        [self.view addSubview:_dealView];
    }
    
    if (!_inviteBtn) {
        _inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _inviteBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
        [_inviteBtn setTitle:@"马上邀请好友" forState:UIControlStateNormal];
        [_inviteBtn addTarget:self action:@selector(inviteClick) forControlEvents:UIControlEventTouchUpInside];
        _inviteBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _inviteBtn.layer.borderWidth = 0.5;
        _inviteBtn.layer.cornerRadius = 5;
        [_inviteBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_inviteBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_inviteBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _inviteBtn.titleLabel.font = LittleFont;
        [_dealView addSubview:_inviteBtn];
    }

    [self getInviteInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInviteInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"获取中...";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *hmacString = [[communcation sharedInstance] hmac:userInfoModel.userId withKey:userInfoModel.primaryKey];
        Out_InviteModel *outModel = [[communcation sharedInstance]inviteRewardWithKey:userInfoModel.key AndDigest:hmacString AndUserid:userInfoModel.userId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _codeLabel.text = outModel.data.inviteCode;
                _moneyLabel.text = [NSString stringWithFormat:@"已获%0.2f元",outModel.data.inviteAmount];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


- (void)inviteClick
{
    
}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
