//
//  MicrophonePushViewController.m
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MicrophonePushViewController.h"

@interface MicrophonePushViewController ()



@end

@implementation MicrophonePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if (!_microPhoneImg) {
        _microPhoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(75, 40, 50, 110)];
        _microPhoneImg.image = [UIImage imageNamed:@"icon_microphone_one"];
        [self.view addSubview:_microPhoneImg];
    }
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,160, 200, 20)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = LargeFont;
        _tipLabel.textColor = WhiteBgColor;
        _tipLabel.text = @"正在说话";
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tipLabel];
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

@end
