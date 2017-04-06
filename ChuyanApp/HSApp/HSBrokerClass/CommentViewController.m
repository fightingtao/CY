//
//  CommentViewController.m
//  HSApp
//
//  Created by cbwl on 16/5/2.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "CommentViewController.h"

#import "publicResource.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "UserInfoSaveModel.h"
#import "communcation.h"

@interface CommentViewController ()

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *ShuLabel;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = ViewBgColor;
    //添加头部菜单栏
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0,200, 36)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 150, 36)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = MiddleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = @"评论";
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
    
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = CGRectMake(0, 110, SCREEN_WIDTH, 20);
        _bgView.backgroundColor = WhiteBgColor;
        [self.view addSubview:_bgView];

    }
    
    if (!_cancelComment) {
        _cancelComment = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 50, 20)];
        [_cancelComment setBackgroundColor:[UIColor clearColor]];
        
        [_cancelComment setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelComment setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _cancelComment.titleLabel.font = MiddleFont;
        [_cancelComment addTarget:self action:@selector(CancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_cancelComment];
    }
    
    if (!_publishComment) {
        _publishComment = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60,0, 50, 20)];
        [_publishComment setBackgroundColor:[UIColor clearColor]];
        [_publishComment setTitle:@"发布" forState:UIControlStateNormal];
        [_publishComment setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _publishComment.titleLabel.font = MiddleFont;
        [_publishComment addTarget:self action:@selector(PublicClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_publishComment];
    }
    
    if (!_demandTextView) {
        _demandTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 150)];
        _demandTextView.textColor = TextMainCOLOR;//设置textview里面的字体颜色
        _demandTextView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
        _demandTextView.delegate = self;//设置它的委托方法
        _demandTextView.backgroundColor = WhiteBgColor;//设置它的背景颜色
        _demandTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
        //        _demandTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _demandTextView.scrollEnabled = NO;//是否可以拖动
        _demandTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _demandTextView.userInteractionEnabled = YES;
        [self.view addSubview:_demandTextView];
    }
    
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 135, SCREEN_WIDTH-40, 20)];
        _placeLabel.numberOfLines = 1;
        _placeLabel.backgroundColor = [UIColor clearColor];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.font = LittleFont;
        _placeLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        _placeLabel.text = @"输入您的评论";
        [self.view addSubview:_placeLabel];
    }
    
    if (!_ShuLabel) {
        _ShuLabel = [[UILabel alloc]init];
        _ShuLabel.frame = CGRectMake(SCREEN_WIDTH-160, 285,140, 20);
        //_ShuLabel.backgroundColor = [UIColor grayColor];
        _ShuLabel.textAlignment = NSTextAlignmentCenter;
        _ShuLabel.font = LittleFont;
        _ShuLabel.textColor = TextMainCOLOR;
        _ShuLabel.text = @"可以输入140个字";
        [self.view addSubview:_ShuLabel];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)CancelClick{
    _demandTextView.text = nil;
    _placeLabel.hidden = NO;
    _placeLabel.text = @"请输入评论内容";
    _ShuLabel.text = @"可以输入140个字";
}

- (void)PublicClick{
    
    if (_demandTextView.text.length == 0) {
        [[iToast makeText:@"请输入评论内容"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"评论中...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_model.orderId,@"",_demandTextView.text, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_AddDynamicCommentModel *inModel = [[In_AddDynamicCommentModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.user_id = userInfoModel.userId;
    inModel.order_id = _model.orderId;
    inModel.content = _demandTextView.text;
    inModel.parent_comment_id = @"";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        Out_AllSameModel *outModel = [[communcation sharedInstance] addCommentToOrderDynamicWithModel:inModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已成功评论!"] show];
                [self leftItemClick];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

    
}

- (void)keyboardWillHide:(NSNotification *)notif {
  
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
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
//    return YES;

    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 140 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 140)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    return YES;

}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > 140)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:140];
        
        [textView setText:s];
    }
    
    //不让显示负数
    //self.lbNums.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,10 - existTextNum),10];
//    NSLog(@"剩余>>>>>>>>>%@",[NSString stringWithFormat:@"%ld/%d",MAX(0,140 - existTextNum),140]);
    _ShuLabel.text = [NSString stringWithFormat:@"可以输入%ld/%d字",MAX(0,140 - existTextNum),140];
}


@end
