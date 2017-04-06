//
//  HSAlertShowViewController.m
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "HSAlertShowViewController.h"

@interface HSAlertShowViewController ()

@end

@implementation HSAlertShowViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = 5;
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,25, SCREEN_WIDTH-40, 30)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,50, SCREEN_WIDTH-40, 30)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = TextDetailCOLOR;
        _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_detailLabel];
    }
    
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH-40, 1)];
        _line.backgroundColor = LineColor;
        [self.view addSubview:_line];
    }
    
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(20,105,(SCREEN_WIDTH-120)/2, 40);
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _cancelBtn.layer.borderWidth = 0.5;
        _cancelBtn.layer.cornerRadius = 5;
        [_cancelBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_cancelBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_cancelBtn];
    }
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(60+(SCREEN_WIDTH-120)/2,105,(SCREEN_WIDTH-120)/2, 40);
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.borderColor = MAINCOLOR.CGColor;
        _confirmBtn.layer.borderWidth = 0.5;
        _confirmBtn.layer.cornerRadius = 5;
        [_confirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_confirmBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_confirmBtn];
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
- (void)setDataWithTitle:(NSString*)title andDetail:(NSString*)detail andConfirmBtnTitle:(NSString*)confirmBtnTitle andCancelBtnTitle:(NSString*)cancelBtnTitle
{
    _titleLabel.text = title;
    _detailLabel.text = detail;
    [_confirmBtn setTitle:confirmBtnTitle forState:UIControlStateNormal];
    [_cancelBtn setTitle:cancelBtnTitle forState:UIControlStateNormal];
    
}

- (void)confirmClick
{
    [self.delegate confirmBtnClick];
}


-(void)cancelClick
{
    [self.delegate cancelBtnClick];
}
@end
