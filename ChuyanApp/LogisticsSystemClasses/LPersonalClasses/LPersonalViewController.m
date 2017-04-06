//
//  LPersonalViewController.m
//  HSApp
//
//  Created by xc on 16/1/27.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LPersonalViewController.h"

#import "LFeedbackViewController.h"

@interface LPersonalViewController ()
{
    Out_LPersonInfoBody *_tempModel;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property (nonatomic, strong) UIView *personView;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *addressLabel;


@property (nonatomic, strong) UILabel *feedbackLabel;
@property (nonatomic, strong) UIButton *feedbackBtn;
@property (nonatomic, strong) UIImageView *arrowImgView;

@property (nonatomic, strong) UIButton *backHomeBtn;

@end

@implementation LPersonalViewController
@synthesize delegate;


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
        _titleLabel.text = @"个人中心";
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
    
    


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_personView) {
        _personView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 100)];
        _personView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_personView];
    }
    
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        _headImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headImgView.layer.cornerRadius = 30;
        _headImgView.layer.masksToBounds = YES;
        //边框宽度及颜色设置
        [_headImgView.layer setBorderWidth:0.1];
        [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
        _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
        //        _headImgView.userInteractionEnabled = YES;
        //        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)];
        //        [_headImgView addGestureRecognizer:singleTap1];
        [_personView addSubview:_headImgView];
        
    }
    
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,10,SCREEN_WIDTH-100,20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = LargeFont;
        _nameLabel.textColor = TextMainCOLOR;
        _nameLabel.text = @"配送员";
        _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_personView addSubview:_nameLabel];
    }
    
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,40,SCREEN_WIDTH-100,20)];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = LargeFont;
        _numberLabel.textColor = TextMainCOLOR;
        _numberLabel.text = @"工号:239048203";
        _numberLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        [_personView addSubview:_numberLabel];
    }
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,70,SCREEN_WIDTH-100,20)];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.font = LargeFont;
        _addressLabel.textColor = TextMainCOLOR;
        _addressLabel.text = @"站点：夫子庙";
        _addressLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_personView addSubview:_addressLabel];
    }
    
    
    if (!_feedbackLabel) {
        _feedbackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,210,SCREEN_WIDTH,40)];
        _feedbackLabel.backgroundColor = WhiteBgColor;
        _feedbackLabel.font = LargeFont;
        _feedbackLabel.textColor = TextMainCOLOR;
        _feedbackLabel.text = @"    意见反馈";
        _feedbackLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _feedbackLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_feedbackLabel];
    }
    
    
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 217.5, 25, 25)];
        _arrowImgView.image = [UIImage imageNamed:@"btn_choice"];
        [self.view addSubview:_arrowImgView];
    }
    
    if (!_feedbackBtn) {
        _feedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _feedbackBtn.frame = CGRectMake(0,210, SCREEN_WIDTH, 40);
        [_feedbackBtn addTarget:self action:@selector(feedbackClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_feedbackBtn];
    }
    
    if (!_backHomeBtn) {
        _backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backHomeBtn.frame = CGRectMake(20,280, SCREEN_WIDTH-40, 40);
        [_backHomeBtn setTitle:@"返回雏燕" forState:UIControlStateNormal];
        [_backHomeBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        _backHomeBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _backHomeBtn.layer.borderWidth = 0.5;
        _backHomeBtn.layer.cornerRadius = 5;
        [_backHomeBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_backHomeBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_backHomeBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _backHomeBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_backHomeBtn];
    }
    [self getPersonInfo];
}


- (void)getPersonInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    
    NSString *hamcString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LPersonInfoModel *outModel = [[communcation sharedInstance] getPersonInfoWith:userInfoModel.userId andDigest:hamcString];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                NSData *userData = [userDefault objectForKey:UserKey];
                UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
                _tempModel = outModel.data;
                _nameLabel.text = _tempModel.company;
                _numberLabel.text = [NSString stringWithFormat:@"工号:%@",_tempModel.employeeno];
                DLog(@"@@@@@@@@@@@@%@",_tempModel.employeeno);
                _addressLabel.text = [NSString stringWithFormat:@"站点：%@",_tempModel.branchname];
                [_headImgView setImageURLStr:userInfoModel.header placeholder:[UIImage imageNamed:@"nav_leftbar_info"]];
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


- (void)feedbackClick
{
    LFeedbackViewController *feedbackVC = [[LFeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}


- (void)backClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
