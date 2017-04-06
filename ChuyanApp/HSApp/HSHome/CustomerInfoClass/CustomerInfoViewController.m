//
//  CustomerInfoViewController.m
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CustomerInfoViewController.h"
#import "CustomerInfoTableViewCell.h"
#import "CustomerInfoCommentTableViewCell.h"

@interface CustomerInfoViewController ()
{
    NSString *_lastDate;
    NSString *_lastorderid;
    NSMutableArray *_commentListArray;
    

    
    Out_CheckUserInfoBody *_userInfoModel;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *customerTableView;

@end

@implementation CustomerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
        _titleLabel.text = @"个人信息";
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
    
    
    [self initpublishTableView];
    [self.view addSubview:_customerTableView];
    
    _customerTableView.hidden = YES;
    
    _commentListArray = [[NSMutableArray alloc] init];
    _lastDate = @"0";
    _lastorderid = @"0";
    
    [self getUserInfo];
}


//初始化table
-(UITableView *)initpublishTableView
{
    if (_customerTableView != nil) {
        return _customerTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.customerTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _customerTableView.delegate = self;
    _customerTableView.dataSource = self;
    _customerTableView.backgroundColor = ViewBgColor;
    _customerTableView.showsVerticalScrollIndicator = NO;
    return _customerTableView;
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
    mbp.labelText = @"获取中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hamcString = [[communcation sharedInstance] hmac:_userId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        Out_CheckUserInfoModel *outModel = [[communcation sharedInstance] checkUserInfoWithKey:userInfoModel.key AndDigest:hamcString AndUserId:_userId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _userInfoModel = outModel.data;
                [_customerTableView reloadData];
                _customerTableView.hidden = NO;
                [self getCommentList];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


///获取评论列表
- (void)getCommentList
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *dataArray = [[NSArray alloc] initWithObjects:_userId,[NSString stringWithFormat:@"%d",_commentType],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:_customerTableView animated:YES];
    mbp.labelText = @"获取中...";
    
    In_CommentListModel *inModel = [[In_CommentListModel alloc] init];
    inModel.key = userInfoModel.key;
    inModel.digest = hamcString;
    inModel.user_id = _userId;
    inModel.type = _commentType;
    inModel.lastDate = [_lastDate longLongValue];
    inModel.lastrowid = [_lastorderid longLongValue];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CommentListModel *outModel = [[communcation sharedInstance] getCommentListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:_customerTableView animated:YES];
            [_customerTableView headerEndRefreshing];
            [_customerTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([_lastDate isEqualToString:@"0"]) {
                    [_commentListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_commentListArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_commentListArray addObject:model];
                    }
                }
                [_customerTableView reloadData];
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
    if (section == 0) {
        return 1;
    }
    return [_commentListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.01;
    }
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 30.0)];
        
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = TextMainCOLOR;
        headerLabel.font = LittleFont;
        headerLabel.text = @"评价";
        headerLabel.frame = CGRectMake(20.0, 0.0, SCREEN_WIDTH, 30.0);
        [customView addSubview:headerLabel];
        return customView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [CustomerInfoTableViewCell cellHeightWithModel:@"测试"];
    }else
    {
        return [CustomerInfoCommentTableViewCell cellHeightWithModel:@"测试"];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellName = @"CustomerInfoTableViewCell";
        CustomerInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[CustomerInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        [cell setOrderContentWithModel:_userInfoModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"CustomerInfoCommentTableViewCell";
        CustomerInfoCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[CustomerInfoCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        Out_CommentListBody *model = [_commentListArray objectAtIndex:indexPath.row];
        [cell setOrderContentWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
