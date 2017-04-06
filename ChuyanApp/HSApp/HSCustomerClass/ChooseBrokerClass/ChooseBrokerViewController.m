//
//  ChooseBrokerViewController.m
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ChooseBrokerViewController.h"
#import "ChooseBrokerTableViewCell.h"
#import "CustomerInfoViewController.h"


@interface ChooseBrokerViewController ()<ChooseBrokerDelegate>
{
     NSArray *_brokerListArray;//经纪人列表
    int _listType;//排序类型 1、智能排序，2：距離排序，3、好評排序，4、成就排序
    NSString *_tempOrderId;//暂存orderid
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;

@property (nonatomic, strong) UITableView *brokerTableView;

@end

@implementation ChooseBrokerViewController
@synthesize delegate;

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
        _titleLabel.text = @"选择经纪人";
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
    
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_headView];
    }
    
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"智能排序" forState:UIControlStateNormal];
        [_button1 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button1 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
        _button1.frame = CGRectMake(0, 0, SCREEN_WIDTH/4, 40);
        _button1.titleLabel.font = LittleFont;
        _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button1.selected = YES;
        [_headView addSubview:_button1];
    }
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"距离" forState:UIControlStateNormal];
        [_button2 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button2 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
        _button2.frame = CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 40);
        _button2.titleLabel.font = LittleFont;
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button2];
    }
    
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitle:@"好评" forState:UIControlStateNormal];
        [_button3 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button3 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button3 addTarget:self action:@selector(button3Click) forControlEvents:UIControlEventTouchUpInside];
        _button3.frame = CGRectMake(SCREEN_WIDTH/4*2, 0, SCREEN_WIDTH/4, 40);
        _button3.titleLabel.font = LittleFont;
        _button3.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button3];
    }
    
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setTitle:@"成就" forState:UIControlStateNormal];
        [_button4 setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_button4 setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [_button4 addTarget:self action:@selector(button4Click) forControlEvents:UIControlEventTouchUpInside];
        _button4.frame = CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 40);
        _button4.titleLabel.font = LittleFont;
        _button4.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:_button4];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [_headView addSubview:line];
    
    [self initpublishTableView];
    [self.view addSubview:_brokerTableView];
    
    _listType = 1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化table
-(UITableView *)initpublishTableView
{
    if (_brokerTableView != nil) {
        return _brokerTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 104.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-104;
    
    self.brokerTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _brokerTableView.delegate = self;
    _brokerTableView.dataSource = self;
    _brokerTableView.backgroundColor = ViewBgColor;
    _brokerTableView.showsVerticalScrollIndicator = NO;
    return _brokerTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)getBrokerListWithOrderId:(NSString*)orderId
{
    _tempOrderId = orderId;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSArray *dataArray = [[NSArray alloc] initWithObjects:orderId,[NSString stringWithFormat:@"%d",_listType], nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"获取中...";
    
    In_GetOrderBrokerModel *inModel = [[In_GetOrderBrokerModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.orderid= orderId;
    inModel.type = [NSString stringWithFormat:@"%d",_listType];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_GetOrderBrokerModel *outModel = [[communcation sharedInstance] getOrderBrokerListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _brokerListArray = outModel.data;
                [_brokerTableView reloadData];
            }else
            {
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_brokerListArray count];
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
    return [ChooseBrokerTableViewCell cellHeight];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"ChooseBrokerTableViewCell";
    ChooseBrokerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[ChooseBrokerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    Out_GetOrderBrokerBody *model = [_brokerListArray objectAtIndex:indexPath.section];
    [cell setBrokerContentWithModel:model];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}




//智能排序
- (void)button1Click
{
    _button1.selected = YES;
    _button2.selected = NO;
    _button3.selected = NO;
    _button4.selected = NO;
    _listType = 1;
    [self getBrokerListWithOrderId:_tempOrderId];
}

//距离排序
- (void)button2Click
{
    _button1.selected = NO;
    _button2.selected = YES;
    _button3.selected = NO;
    _button4.selected = NO;
    _listType = 2;
    [self getBrokerListWithOrderId:_tempOrderId];
}

//好评排序
- (void)button3Click
{
    _button1.selected = NO;
    _button2.selected = NO;
    _button3.selected = YES;
    _button4.selected = NO;
    _listType = 3;
    [self getBrokerListWithOrderId:_tempOrderId];
}

//成就排序
- (void)button4Click
{
    _button1.selected = NO;
    _button2.selected = NO;
    _button3.selected = NO;
    _button4.selected = YES;
    _listType = 4;
    [self getBrokerListWithOrderId:_tempOrderId];
}


#pragma ChooseBrokerDelegate 选择经纪人代理
- (void)chooseBrokerWithModel:(Out_GetOrderBrokerBody *)model
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hamcString = [[communcation sharedInstance] hmac:model.orderbrokerid withKey:userInfoModel.primaryKey];
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_ChooseBrokerModel *outModel = [[communcation sharedInstance] chooseBrokerWithKey:userInfoModel.userId AndDegist:hamcString AndOrderbrokerid:model.orderbrokerid];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"成功选择经纪人!"] show];
                [self dismissViewControllerAnimated:YES completion:^{
                    [self.delegate completeAndRefresh];
                }];
            }else
            {
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


///头像点击实现
- (void)headImgClickWithModel:(Out_GetOrderBrokerBody*)model
{
    CustomerInfoViewController *customerInfoVC = [[CustomerInfoViewController alloc] init];
    customerInfoVC.userId = model.user_id;
    customerInfoVC.commentType = 1;
    [self.navigationController pushViewController:customerInfoVC animated:YES];

}
//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}


@end
