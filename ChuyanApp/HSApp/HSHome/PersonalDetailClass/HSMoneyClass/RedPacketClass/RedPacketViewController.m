//
//  RedPacketViewController.m
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RedPacketViewController.h"
#import "RedPacketTableViewCell.h"

@interface RedPacketViewController ()
{
    NSArray *_redArray;
}


@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *redTableView;

@end

@implementation RedPacketViewController
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
        _titleLabel.text = @"红包";
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
    
    [self initpersonTableView];
    [self.view addSubview:_redTableView];
    
    _redTableView.hidden = YES;
    
    [self getWalletInfo];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_redTableView != nil) {
        return _redTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.redTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _redTableView.delegate = self;
    _redTableView.dataSource = self;
    _redTableView.backgroundColor = ViewBgColor;
    _redTableView.showsVerticalScrollIndicator = NO;
    _redTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _redTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getWalletInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%d",_type], nil];
    NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    In_RedPacketModel *inModel = [[In_RedPacketModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hmacString;
    inModel.user_id = userInfoModel.userId;
    inModel.type = _type;
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_RedPacketModel *outModel = [[communcation sharedInstance] getRedPacketWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                _redArray = outModel.data;
                [_redTableView reloadData];
                if ([_redArray count] != 0) {
                    _redTableView.hidden = NO;
                }
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
}


#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_redArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
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
    
    return 126;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"RedPacketTableViewCell";
    RedPacketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[RedPacketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    Out_RedPacketBody *model = [_redArray objectAtIndex:indexPath.section];
    [cell setRedDataWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Out_RedPacketBody *model = [_redArray objectAtIndex:indexPath.section];
    if (_type == 1) {

        [self.delegate getTheRedWithModel:model];
        [self leftItemClick];
    }else
    {
        
    }
}



//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
