//
//  RechargePacketViewController.m
//  HSApp
//
//  Created by xc on 15/12/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RechargePacketViewController.h"

@interface RechargePacketViewController ()

@property (nonatomic, strong) UITableView *typeTableView;
@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation RechargePacketViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WhiteBgColor;
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-40, 50)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = LittleFont;
        _titleLabel.textColor = TextMainCOLOR;
        _titleLabel.text = @"选择金额";
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    
    if (!_cancalBtn) {
        _cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancalBtn.frame = CGRectMake(0,200, SCREEN_WIDTH-40, 50);
        [_cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancalBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancalBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _cancalBtn.titleLabel.font = LittleFont;
        [self.view addSubview:_cancalBtn];
    }
    
    [self initpublishTableView];
    [self.view addSubview:_typeTableView];
    
    [self getTypeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化table
-(UITableView *)initpublishTableView
{
    if (_typeTableView != nil) {
        return _typeTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 50.0;
    rect.size.width = self.view.frame.size.width-40;
    rect.size.height = 150;
    
    self.typeTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    _typeTableView.backgroundColor = ViewBgColor;
    _typeTableView.showsVerticalScrollIndicator = NO;
    return _typeTableView;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)getTypeData
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        NSString *hmacString = [[communcation sharedInstance] hmac:@"" withKey:userInfoModel.primaryKey];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_RechargeMoneyModel *outModel = [[communcation sharedInstance] getRechargeMoneyListWithKey:userInfoModel.userId AndDigest:hmacString];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    
                    _typeArray = outModel.data;
                    [_typeTableView reloadData];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }
    
    
}



#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_typeArray count];
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
    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    for (id obj in cell.contentView.subviews)  {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel* thelabel = (UILabel*)obj;
            [thelabel removeFromSuperview];
        }
    }
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-40, 50)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = LittleFont;
    contentLabel.textColor = TextMainCOLOR;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:contentLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Out_RechargeMoneyBody *model = [_typeArray objectAtIndex:indexPath.section];
    contentLabel.text = model.recharge_desc;
    NSLog(@"%@",model.recharge_desc);
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Out_RechargeMoneyBody *model = [_typeArray objectAtIndex:indexPath.section];
    [self.delegate chooseTypeWithModel:model];
    
}





- (void)cancelClick
{
    [self.delegate cancelTypeChoose];
}


@end
