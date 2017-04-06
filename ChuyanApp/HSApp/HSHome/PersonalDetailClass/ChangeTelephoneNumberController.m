//
//  ChangeTelephoneNumberController.m
//  HSApp
//
//  Created by 李志明 on 16/9/13.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "ChangeTelephoneNumberController.h"
#import "publicResource.h"
#import "iToast.h"
#import "communcation.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
@interface ChangeTelephoneNumberController ()
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (weak, nonatomic) IBOutlet UILabel *oldLable;

@property (weak, nonatomic) IBOutlet UITextField *changNumber;

@end

@implementation ChangeTelephoneNumberController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
        _titleLabel.text = @"修改手机号";
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
    self.oldLable.text = [NSString stringWithFormat:@"当前手机号码：%@",self.telephoneNumber];
}

- (IBAction)countersignBtnClick:(id)sender {
    [_changNumber resignFirstResponder];//注销第一响应者
    
    if (_changNumber.text.length == 0) {
        [[iToast makeText:@"请输入手机号"] show];
        return;
    }
    
    if ([_changNumber.text isEqualToString:self.telephoneNumber]) {
        [[iToast makeText:@"请您输入要更换的新手机号码"]show];
        return;
    }
    
    if ([[communcation sharedInstance]checkTel:_changNumber.text]== NO){
        [[iToast makeText:@"请输入正确的手机号"] show];
        return;
    }

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId && ![userInfoModel.userId isEqualToString:@""])
    {
        NSArray *array = [[NSArray alloc] initWithObjects:self.telephoneNumber,_changNumber.text, nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
     
        in_chagnPhoneNumberModel *inModel = [[in_chagnPhoneNumberModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.Phone =_changNumber.text;
        inModel.oldPhone = self.telephoneNumber;
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"修改中...";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            out_chagnPhoneNumberModel *outModel = [[communcation sharedInstance] changtelephoneNumberWithModel:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"手机号修改成功"] show];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:_changNumber.text forKey:@"phoneNumble"];
                    LoginViewController *VC = [[LoginViewController alloc]init];
                    [self.navigationController pushViewController:VC animated:YES ];
                }else{
                    
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }
}

-(void)leftItemClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
