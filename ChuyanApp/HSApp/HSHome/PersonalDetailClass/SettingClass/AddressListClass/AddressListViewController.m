//
//  AddressListViewController.m
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AddressListViewController.h"
#import "CommonAddressTableViewCell.h"
#import "AddAndEditAddressViewController.h"

@interface AddressListViewController ()<AddAddressDelegate>

{
    NSIndexPath  *_sourceIndexPath;

}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *addressTableView;

@property (nonatomic, strong) NSArray *addressArray;

@end

@implementation AddressListViewController

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
        _titleLabel.text = @"常用地址";
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
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    [self initpublishTableView];
    [self.view addSubview:_addressTableView];
    
    [self getAddressList];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGuesture:)];
    [self.addressTableView addGestureRecognizer:longPress];
    
}
- (void)handleLongPressGuesture:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.addressTableView];
    NSIndexPath *indexPath = [self.addressTableView indexPathForRowAtPoint:location];
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                _sourceIndexPath = indexPath;
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"是否删除" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                [alert show];
                
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            break;
        }
            
        default: {
            
            break;
        }
    }
}



//初始化table
-(UITableView *)initpublishTableView
{
    if (_addressTableView != nil) {
        return _addressTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height;
    
    self.addressTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.backgroundColor = ViewBgColor;
    _addressTableView.showsVerticalScrollIndicator = NO;
    return _addressTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)getAddressList
{
    //获取用户信息
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        
        NSArray *array = [[NSArray alloc] initWithObjects:userInfoModel.userId, nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
        In_AddressModel *inModel = [[In_AddressModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.userId = userInfoModel.userId;
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AddressModel *outModel = [[communcation sharedInstance] getAddressWithMode:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    _addressArray = outModel.data;
                    [_addressTableView reloadData];
                    
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
    return [_addressArray count];
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
    return 65;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"CommonAddressTableViewCell";
    CommonAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[CommonAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OutAddressBody *model = [_addressArray objectAtIndex:indexPath.section];
    [cell setAddressDataWithModel:model];
    
    return cell;
    
}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           [self deleteAddress:indexPath];
                                                                           //删除地址
                                                                       }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"编辑"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [self editAddress:indexPath];
                                                                            //编辑地址
                                                                          }];
    rowActionSec.backgroundColor = TextDetailCOLOR;
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self editAddress:indexPath];        //编辑地址

}


//删除地址
- (void)deleteAddress:(NSIndexPath *)indexPath

{
    OutAddressBody *model = [_addressArray objectAtIndex:indexPath.section];
    //获取用户信息
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        
        NSArray *array = [[NSArray alloc] initWithObjects:model.addressid, nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
        In_DeleteAddressModel *inModel = [[In_DeleteAddressModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.addressid = model.addressid;
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_DeleteAddressModel *outModel = [[communcation sharedInstance] deleteAddressWithModel:inModel];;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"地址已删除!"] show];
                    [self getAddressList];
                    
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }

}


//编辑地址
- (void)editAddress:(NSIndexPath *)indexPath
{
    OutAddressBody *model = [_addressArray objectAtIndex:indexPath.section];
    AddAndEditAddressViewController *editAddressVC = [[AddAndEditAddressViewController alloc] init];
    editAddressVC.editModel = model;
    editAddressVC.type = 1;
    editAddressVC.delegate = self;
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

//导航栏左右侧按钮点击
- (void)rightItemClick
{
    AddAndEditAddressViewController *editAddressVC = [[AddAndEditAddressViewController alloc] init];
    editAddressVC.type = 0;
    editAddressVC.delegate = self;
    [self.navigationController pushViewController:editAddressVC animated:YES];
}


#pragma AddAddressDelegate 完成添加或编辑地址
- (void)completeNewAddress
{
    [self getAddressList];
}

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [self deleteAddress:_sourceIndexPath];
    }
}
@end
