//
//  BrokerTrainViewController.m
//  HSApp
//
//  Created by xc on 15/12/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BrokerTrainViewController.h"

@interface BrokerTrainViewController ()
{
    NSArray *_picArray;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@end

@implementation BrokerTrainViewController
@synthesize delegate;

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
        _titleLabel.text = @"在线培训";
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
    
    [self getTrainContent];
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
- (void)getTrainContent
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
            Out_TrainModel *outModel = [[communcation sharedInstance] getTrainContentWithKey:userInfoModel.userId AndDigest:hmacString];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    _picArray = outModel.data;
                    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
                    scrollView.pagingEnabled = YES;
                    scrollView.bounces = NO;
                    scrollView.scrollEnabled = YES;
                    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*[_picArray count], SCREEN_HEIGHT-64);
                    scrollView.showsHorizontalScrollIndicator = NO;
                    scrollView.showsVerticalScrollIndicator = NO;
                    [self.view addSubview:scrollView];
                    
                    for (int i = 0; i<[_picArray count]; i++) {
                        OutTrainBody *model = [_picArray objectAtIndex:i];
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                        imageView.contentMode = UIViewContentModeScaleAspectFit;
                        imageView.backgroundColor = WhiteBgColor;
                        [imageView setImageURLStr:model.picPath placeholder:[UIImage imageNamed:@"g1"]];
                        [scrollView addSubview:imageView];
                        if (i == [_picArray count]-1) {
                            imageView.userInteractionEnabled = YES;
                            UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                            completeBtn.backgroundColor = [UIColor clearColor];
                            completeBtn.layer.cornerRadius  = 5;
                            completeBtn.layer.masksToBounds = YES;
                            completeBtn.layer.borderColor = MAINCOLOR.CGColor;
                            completeBtn.layer.borderWidth = 0.5;
                            [completeBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                            [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
                            [completeBtn setTitle:@"完成培训" forState:UIControlStateNormal];
                            completeBtn.frame = CGRectMake((SCREEN_WIDTH-150)/2, imageView.frame.size.height-70, 150, 40);
                            [imageView addSubview:completeBtn];
                            
                        }
                    }
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }

}


///完成培训
- (void)completeBtnClick
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
            Out_ComPleteTrainModel *outModel = [[communcation sharedInstance] completeTrainContentWithKey:userInfoModel.userId AndDigest:hmacString AndBrokerId:userInfoModel.userId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已经完成培训!"] show];
                    [self.delegate completeTrainWithStatus:1];
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
