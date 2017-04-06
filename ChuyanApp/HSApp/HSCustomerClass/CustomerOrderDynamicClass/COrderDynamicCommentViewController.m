//
//  COrderDynamicCommentViewController.m
//  HSApp
//
//  Created by xc on 16/1/6.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "COrderDynamicCommentViewController.h"

@interface COrderDynamicCommentViewController ()
@end

@implementation COrderDynamicCommentViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!_cancelComment) {
        _cancelComment = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
        [_cancelComment setBackgroundColor:[UIColor clearColor]];
        [_cancelComment setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelComment setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _cancelComment.titleLabel.font = MiddleFont;
        [_cancelComment addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelComment];
    }

    if (!_publishComment) {
        _publishComment = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 20)];
        [_publishComment setBackgroundColor:[UIColor clearColor]];
        [_publishComment setTitle:@"发布" forState:UIControlStateNormal];
        [_publishComment setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _publishComment.titleLabel.font = MiddleFont;
        [_publishComment addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_publishComment];
    }
    
    if (!_demandTextView) {
        _demandTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 100)];
        _demandTextView.textColor = TextMainCOLOR;//设置textview里面的字体颜色
        _demandTextView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
        _demandTextView.delegate = self;//设置它的委托方法
        _demandTextView.backgroundColor = WhiteBgColor;//设置它的背景颜色
        _demandTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
//        _demandTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _demandTextView.scrollEnabled = NO;//是否可以拖动
        _demandTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_demandTextView];
    }
    
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, SCREEN_WIDTH-40, 20)];
        _placeLabel.numberOfLines = 1;
        _placeLabel.backgroundColor = [UIColor clearColor];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.font = LittleFont;
        _placeLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        _placeLabel.text = @"输入您的评论";
        [self.view addSubview:_placeLabel];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_demandTextView becomeFirstResponder];
    
    _demandTextView.frame = CGRectMake(0, 40, SCREEN_WIDTH, 100);
    _demandTextView.text = @"";
    
    _placeLabel.text = _placeString;
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)leftItemClick
{
    [self.delegate cancelDynamicComment];
}


- (void)rightItemClick
{
    if (_demandTextView.text.length == 0) {
        [[iToast makeText:@"请输入评论内容"] show];
        return;
    }
    [self.delegate addDynamciCommentWithContent:_demandTextView.text AndParent_comment_id:_parent_comment_id];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [self.demandTextView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.demandTextView.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeLabel.hidden=NO;//隐藏文字
        }else{
            _placeLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.demandTextView.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                _placeLabel.hidden=NO;
            }else{//不是删除
                _placeLabel.hidden=YES;
            }
        }else{//长度不为1时候
            _placeLabel.hidden=YES;
        }
    }
    return YES;
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [self leftItemClick];
    
}
@end
