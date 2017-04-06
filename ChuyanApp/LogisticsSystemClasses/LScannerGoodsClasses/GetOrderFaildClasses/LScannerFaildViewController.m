//
//  LScannerFaildViewController.m
//  HSApp
//
//  Created by xc on 16/1/29.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LScannerFaildViewController.h"

#import "LFailedOrderTableViewCell.h"

@interface LScannerFaildViewController ()
{
    int _cellHeight;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UITableView *goodsTableview;
@end

@implementation LScannerFaildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WhiteBgColor;
    [self.navigationController.navigationBar setBarTintColor:WhiteBgColor];
    
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
        _titleLabel.text = @"领货失败（2件）";
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
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"重新提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = MiddleFont;
    [rightBtn addTarget:self action:@selector(confirmGoodsClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _titleLabel.text = [NSString stringWithFormat:@"领货失败（%d件）",_tempModel.faliurecount];
    
    [self inithomeTableView];
    [self.view addSubview:_goodsTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化table
-(UITableView *)inithomeTableView
{
    if (_goodsTableview != nil) {
        return _goodsTableview;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.goodsTableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _goodsTableview.delegate = self;
    _goodsTableview.dataSource = self;
    _goodsTableview.backgroundColor = ViewBgColor;
    _goodsTableview.showsVerticalScrollIndicator = NO;
    return _goodsTableview;
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
    return _tempModel.faliurecwbs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identCell = @"LFailedOrderTableViewCell";
    LFailedOrderTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identCell];
    
    if (cell == nil) {
        cell = [[LFailedOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
    }
    Out_LScanFailureBody *model = [_tempModel.faliurecwbs objectAtIndex:indexPath.section];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//确认单号
- (void)confirmGoodsClick
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"重新领货...";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *allOrderString = @"";
    for (int i = 0; i < _tempModel.faliurecwbs.count; i++)
    {
        Out_LScanFailureBody *model = [_tempModel.faliurecwbs objectAtIndex:i];
        if (allOrderString.length == 0)
        {
            allOrderString = model.cwb;
        }else
        {
            allOrderString = [NSString stringWithFormat:@"%@,%@",allOrderString,model.cwb];
        }
        
    }
    NSString *hamcString = [[communcation sharedInstance] hmac:allOrderString withKey:userInfoModel.primaryKey];
    
    In_LScanGoodsModel *inModel = [[In_LScanGoodsModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.cwbs = allOrderString;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_LScanGoodsModel *outModel = [[communcation sharedInstance] scanAndGetGoodsWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if (outModel.data.faliurecount == 0) {
                    
                    [[iToast makeText:@"领货成功，继续领货!"] show];
                    [self leftItemClick];
                }else
                {
                    _tempModel = outModel.data;
                    _titleLabel.text = [NSString stringWithFormat:@"领货失败（%d件）",_tempModel.faliurecount];
                    [_goodsTableview reloadData];
                }
            }else if (outModel.code ==1001)
            {
                [[iToast makeText:outModel.message] show];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
