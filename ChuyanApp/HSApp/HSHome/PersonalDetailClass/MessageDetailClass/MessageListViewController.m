//
//  MessageListViewController.m
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MessageListViewController.h"
#import "MegDynamicTableViewCell.h"
#import "MegNotiTableViewCell.h"

@interface MessageListViewController ()
{
    NSString *_lastDate;
    NSString *_lastorderid;
    int _type;
    NSMutableArray *_msgListArray;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UITableView *msgTableView;

@end

@implementation MessageListViewController

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
        _titleLabel.text = @"消息";
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

    
    //加载头部选择功能
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headView];
    }
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"动态" forState:UIControlStateNormal];
        [_button1 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button1 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(buttonDTClick) forControlEvents:UIControlEventTouchUpInside];
        _button1.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 40);
        _button1.titleLabel.font = LittleFont;
        _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button1.selected = YES;
        [_headView addSubview:_button1];
    }
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"通知" forState:UIControlStateNormal];
        [_button2 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button2 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(buttonNotfClick) forControlEvents:UIControlEventTouchUpInside];
        _button2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 40);
        _button2.titleLabel.font = LittleFont;
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button2];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    
    _nowType = MsgType_Dynamic;
    
    [self initpublishTableView];
    [self.view addSubview:_msgTableView];
    
    //添加刷新控件
    [self.msgTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.msgTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    _lastorderid = @"0";
    _lastDate = @"0";
    _msgListArray = [[NSMutableArray alloc] init];
    [self getMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)getMessage
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"正在获取...";
    
    if (_nowType == MsgType_Dynamic) {
        _type = 2;
    }else
    {
        _type = 1;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%d",_type],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_HSMessageModel *inModel = [[In_HSMessageModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.type = _type;
    inModel.lastDate = [_lastDate longLongValue];
    inModel.lastrowid = [_lastorderid longLongValue];
    inModel.userid = userInfoModel.userId;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        Out_HSMessageModel *outModel = [[communcation sharedInstance] getHSMessageWithModel:inModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_msgTableView headerEndRefreshing];
            [_msgTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if ([_lastDate isEqualToString:@"0"]) {
                    [_msgListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_HSMessageBody *model = [outModel.data objectAtIndex:i];
                        [_msgListArray addObject:model];
                    }
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"暂无消息!"] show];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_HSMessageBody *model = [outModel.data objectAtIndex:i];
                        [_msgListArray addObject:model];
                    }
                }
                [_msgTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

//初始化table
-(UITableView *)initpublishTableView
{
    if (_msgTableView != nil) {
        return _msgTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104;
    
    self.msgTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _msgTableView.delegate = self;
    _msgTableView.dataSource = self;
    _msgTableView.backgroundColor = ViewBgColor;
    _msgTableView.showsVerticalScrollIndicator = NO;
    return _msgTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_msgListArray count];
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
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nowType == MsgType_Dynamic) {
        return [MegDynamicTableViewCell cellHeightWithModel:@""];
    }else
    {
        return [MegNotiTableViewCell cellHeightWithModel:@""];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nowType == MsgType_Dynamic) {
        static NSString *cellName = @"MegDynamicTableViewCell";
        MegDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MegDynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        Out_HSMessageBody *model = [_msgListArray objectAtIndex:indexPath.section];
        [cell setMsgWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"MegNotiTableViewCell";
        MegNotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MegNotiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        Out_HSMessageBody *model = [_msgListArray objectAtIndex:indexPath.section];
        [cell setMsgWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark 动态
- (void)buttonDTClick
{
    
    if (_nowType == MsgType_Dynamic) {
        return;
    }else
    {
        _button1.selected = YES;
        _button2.selected = NO;
        _nowType = MsgType_Dynamic;
        _lastorderid = @"0";
        _lastDate = @"0";
        [self getMessage];
    }
}

#pragma mark 通知
- (void)buttonNotfClick
{
    if (_nowType == MsgType_Notice) {
        return;
    }else
    {
        _button1.selected = NO;
        _button2.selected = YES;
        _nowType = MsgType_Notice;
        _lastorderid = @"0";
        _lastDate = @"0";
        [self getMessage];
    }

}

//顶部刷新和底部刷新
- (void)headerRereshing
{
    _lastorderid = @"0";
    _lastDate = @"0";
    [self getMessage];
}

- (void)footerRereshing
{
    if (_msgListArray.count==0) {
        [iToast makeText:@"暂无消息"];
        return;
    }
    
    Out_HSMessageBody *model = [_msgListArray objectAtIndex:_msgListArray.count-1];
    _lastorderid = [NSString stringWithFormat:@"%ld",model.messageId];
    _lastDate= [NSString stringWithFormat:@"%ld",model.createtime];
    [self getMessage];
    
}


//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
