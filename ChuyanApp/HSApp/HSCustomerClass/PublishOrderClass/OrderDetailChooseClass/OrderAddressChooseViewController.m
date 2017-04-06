//
//  OrderAddressChooseViewController.m
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "OrderAddressChooseViewController.h"
#import "CommonAddressTableViewCell.h"

@interface OrderAddressChooseViewController ()
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *addressTableView;
@property (nonatomic, strong) NSArray *addressArray;

@end

@implementation OrderAddressChooseViewController
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
        _titleLabel.text = @"选择地址";
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,50, 30)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LittleFont;
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 230)];
        _headView.backgroundColor = ViewBgColor;
        [self.view addSubview:_headView];
    }
    
    if (!_tipTitileLabel) {
        _tipTitileLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,200, 70, 40)];
        _tipTitileLabel.backgroundColor = [UIColor clearColor];
        _tipTitileLabel.font = LittleFont;
        _tipTitileLabel.textColor = TextMainCOLOR;
        _tipTitileLabel.text = @"常用地址";
        _tipTitileLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipTitileLabel.textAlignment = NSTextAlignmentLeft;
        [_headView addSubview:_tipTitileLabel];
    }
    //新增地址
    if (!_addAddressView) {
        _addAddressView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 180)];
        _addAddressView.backgroundColor = WhiteBgColor;
        [_headView addSubview:_addAddressView];
    }
    
    if (!_nameTipLabel) {
        _nameTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 70, 60)];
        _nameTipLabel.backgroundColor = [UIColor clearColor];
        _nameTipLabel.font = LittleFont;
        _nameTipLabel.textColor = TextMainCOLOR;
        _nameTipLabel.text = @"联系人:";
        _nameTipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameTipLabel.textAlignment = NSTextAlignmentLeft;
        [_addAddressView addSubview:_nameTipLabel];
    }
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(110,0,SCREEN_WIDTH-130,60)];
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.backgroundColor = [UIColor clearColor];
        _nameTextField.textColor = TextMainCOLOR;
        _nameTextField.font = LittleFont;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.delegate = self;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_addAddressView addSubview:_nameTextField];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LineColor;
    [_addAddressView addSubview:line];
    if (!_phoneTipLabel) {
        _phoneTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,60, 70, 60)];
        _phoneTipLabel.backgroundColor = [UIColor clearColor];
        _phoneTipLabel.font = LittleFont;
        _phoneTipLabel.textColor = TextMainCOLOR;
        _phoneTipLabel.text = @"联系电话:";
        _phoneTipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _phoneTipLabel.textAlignment = NSTextAlignmentLeft;
        [_addAddressView addSubview:_phoneTipLabel];
    }
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(110,60,SCREEN_WIDTH-130,60)];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.backgroundColor = [UIColor clearColor];
        _phoneTextField.textColor = TextMainCOLOR;
        _phoneTextField.font = LittleFont;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
        [_addAddressView addSubview:_phoneTextField];
    }
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = LineColor;
    [_addAddressView addSubview:line2];
    if (!_addressTipLabel) {
        _addressTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,120, 70, 60)];
        _addressTipLabel.backgroundColor = [UIColor clearColor];
        _addressTipLabel.font = LittleFont;
        _addressTipLabel.textColor = TextMainCOLOR;
        _addressTipLabel.text = @"联系地址:";
        _addressTipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _addressTipLabel.textAlignment = NSTextAlignmentLeft;
        [_addAddressView addSubview:_addressTipLabel];
    }
    if (!_addressTextField) {
        _addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(110,120,SCREEN_WIDTH-135,60)];
        _addressTextField.borderStyle = UITextBorderStyleNone;
        _addressTextField.backgroundColor = [UIColor clearColor];
        _addressTextField.textColor = TextMainCOLOR;
        _addressTextField.font = LittleFont;
        _addressTextField.keyboardType = UIKeyboardTypeDefault;
        _addressTextField.delegate = self;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressTextField.returnKeyType = UIReturnKeyDone;
        [_addAddressView addSubview:_addressTextField];
    }
    
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(SCREEN_WIDTH-25,139, 25, 25);
        [_locationBtn setImage:[UIImage imageNamed:@"btn_location"] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
        [_addAddressView addSubview:_locationBtn];
    }
    
    
    [self initpublishTableView];
    [self.view addSubview:_addressTableView];
    
    [self getAddressList];
    
    
  }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化table
-(UITableView *)initpublishTableView
{
    if (_addressTableView != nil) {
        return _addressTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 300.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-300;
    
    self.addressTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.backgroundColor = ViewBgColor;
    _addressTableView.showsVerticalScrollIndicator = NO;
    return _addressTableView;
}

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
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OutAddressBody *model = [_addressArray objectAtIndex:indexPath.section];
    [self.delegate getOrderAddressWithModel:model AndType:_addressType];
    [self leftItemClick];
}




//导航栏左右侧按钮点击
- (void)rightItemClick
{
    if (_nameTextField.text.length == 0) {
        [[iToast makeText:@"请输入联系人"] show];
        return;
    }
    
    if (_phoneTextField.text.length == 0) {
        [[iToast makeText:@"请输入联系电话"] show];
        return;
    }
    
    if (_addressTextField.text.length == 0) {
        [[iToast makeText:@"请输入联系地址"] show];
        return;
    }
    
    if (![[communcation sharedInstance]checkTel:_phoneTextField.text]) {
        return;
    }
    
    //新增地址
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        //生成加密数组
        NSArray *array = [[NSArray alloc] initWithObjects:userInfoModel.userId,_nameTextField.text,_phoneTextField.text,_addressTextField.text, nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:array];
        In_AddAddressModel *inModel = [[In_AddAddressModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.userId = userInfoModel.userId;
        inModel.name = _nameTextField.text;
        inModel.telephone = _phoneTextField.text;
        inModel.text = _addressTextField.text;
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"加载中";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AddAddressModel *outModel = [[communcation sharedInstance] addNewAddressWithModel:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [self.delegate getOrderAddressWithModel:outModel.data AndType:_addressType];
                    [self leftItemClick];
                    
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });
    }

}

//定位
- (void)locationClick
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _addressTextField.text = @"正在定位...";
}


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];
    
    
    BMKGeoCodeSearch *bmGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    bmGeoCodeSearch.delegate = self;
    
    BMKReverseGeoCodeOption *bmOp = [[BMKReverseGeoCodeOption alloc] init];
    bmOp.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL geoCodeOk = [bmGeoCodeSearch reverseGeoCode:bmOp];
    if (geoCodeOk) {
        NSLog(@"ok");
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if ([result.poiList count] > 0) {
        BMKPoiInfo *tempAddress = [result.poiList objectAtIndex:0];
        _addressTextField.text = tempAddress.address;
    }else
    {
        _addressTextField.text = result.address;
    }
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    [[iToast makeText:@"定位失败，请重试!"] show];
}



- (void)leftItemClick
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        [textField resignFirstResponder];
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_phoneTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果输入框内容大于11则弹出警告
            textField.text = [toBeString substringToIndex:10];
        }
    }
    return YES;
}

@end
