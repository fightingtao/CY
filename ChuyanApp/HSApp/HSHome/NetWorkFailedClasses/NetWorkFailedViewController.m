//
//  NetWorkFailedViewController.m
//  HSApp
//
//  Created by xc on 16/2/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "NetWorkFailedViewController.h"

@interface NetWorkFailedViewController ()



@end

@implementation NetWorkFailedViewController
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, SCREEN_WIDTH, 20)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = TextDetailCOLOR;
        _tipLabel.text = @"您的网络不给力，请检查网络";
        _tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tipLabel];
    }
    
    if (!_errorImgview) {
        _errorImgview = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-114)/2, self.view.frame.size.height/2-20-114, 114, 78)];
        _errorImgview.image = [UIImage imageNamed:@"netWork"];
        [self.view addSubview:_errorImgview];
    }
    
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadBtn.frame = CGRectMake((SCREEN_WIDTH-150)/2,_tipLabel.frame.origin.y+40, 150, 44);
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadBtn addTarget:self action:@selector(netWorkReloadClick) forControlEvents:UIControlEventTouchUpInside];
        _reloadBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _reloadBtn.layer.borderWidth = 0.5;
        _reloadBtn.layer.cornerRadius = 5;
        [_reloadBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_reloadBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_reloadBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_reloadBtn];
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

- (void)netWorkReloadClick
{
    [self.delegate netWorkReload];
}

@end
