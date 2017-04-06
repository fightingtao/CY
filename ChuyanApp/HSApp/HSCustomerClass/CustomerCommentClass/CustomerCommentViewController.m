//
//  CustomerCommentViewController.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CustomerCommentViewController.h"
#import "CommentBrokerTableViewCell.h"
#import "CommentBrokerContentTableViewCell.h"

@interface CustomerCommentViewController ()<CommentContentDelegate>
{
    ///用户信息
    Out_CommentUserBody *_userInfoModel;
    
    ///评分
    double _commentPoint;
    
    ///评论内容
    NSString *_commentContent;
    
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation CustomerCommentViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
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
        _titleLabel.text = @"评价";
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
    
    
    //生成顶部右侧按钮
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 44)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 12, 50, 25)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if (!_shareView) {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _shareView.backgroundColor =ViewBgColor;
    }
    
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(SCREEN_WIDTH - 90, 0, 80, 40);
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setTitle:@"分享好友 》" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = LittleFont;
        [_shareView addSubview:_shareBtn];
    }

    [self initpublishTableView];
    [self.view addSubview:_commentTableView];
    
    //默认
    _commentPoint = 5.0;
    [self getUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化table
-(UITableView *)initpublishTableView
{
    if (_commentTableView != nil) {
        return _commentTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.commentTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = ViewBgColor;
    _commentTableView.showsVerticalScrollIndicator = NO;
    return _commentTableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getUserInfo
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:_orderId,_type, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CommentUserModel *outModel = [[communcation sharedInstance] getCommentUserInfoWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:_orderId AndType:_type];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _userInfoModel = outModel.data;
                [_commentTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return _shareView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [CommentBrokerTableViewCell cellHeight];
    }else
    {
        return [CommentBrokerContentTableViewCell cellHeight];;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellName = @"CommentBrokerTableViewCell";
        CommentBrokerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[CommentBrokerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (_userInfoModel) {
            [cell setOrderContentWithModel:_userInfoModel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"CommentBrokerContentTableViewCell";
        CommentBrokerContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[CommentBrokerContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


#pragma CommentContentDelegate 评论代理获得评分和评论内容
- (void)StarScore:(CGFloat)score
{
    _commentPoint = score;
}

- (void)commentContent:(NSString *)content
{
    _commentContent = content;
}

//分享
- (void)shareClick
{
    
}

//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


//导航栏左右侧按钮点击
- (void)rightItemClick
{
    if (!_commentContent || _commentContent.length == 0) {
        [[iToast makeText:@"请输入评价内容!"] show];
        return;
    }
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"评价中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_orderId,_commentContent,[NSString stringWithFormat:@"%0.1f",_commentPoint], nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    In_UserCommentModel *inModel = [[In_UserCommentModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.userid = userInfoModel.userId;
    inModel.orderid = _orderId;
    inModel.content = _commentContent;
    inModel.point = _commentPoint;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_UserCommentModel *outModel = [[communcation sharedInstance] userCommentUserWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已成功评价!"] show];
                [self leftItemClick];
                
                
                //评价成功刷新回调
                [self.delegate commentSuccessBackRefresh];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

@end
