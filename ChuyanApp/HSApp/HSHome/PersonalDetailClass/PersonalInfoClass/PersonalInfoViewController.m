//
//  PersonalInfoViewController.m
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonHeadTableViewCell.h"
#import "PersonOtherInfoTableViewCell.h"
#import "ChangeTelephoneNumberController.h"
#import "EditPersonInfoViewController.h"
#import <Accelerate/Accelerate.h>
@interface PersonalInfoViewController ()<UpdateNameDelegate>
{
    ///用户头像
    UIImage *_headImg;
    ///头像上传后地址
    NSString *_headImgString;
    ///用户名
    NSString *_userNameString;
    ///性别
    int _sex;
    ///年龄
    NSString *_birthday;
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *personTableView;

@property(nonatomic, strong) id<ALBBMediaServiceProtocol> albbMediaService;
@property(nonatomic, strong) TFEUploadNotification *notificationupload1;
@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewBgColor;
    //    //添加头部菜单栏
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
    
    [self initpersonTableView];
    [self.view addSubview:_personTableView];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        _userNameString = userInfoModel.username;
        _sex = userInfoModel.gender;
        _birthday = [NSString stringWithFormat:@"%ld",userInfoModel.birthday];
        
    }else
    {
        
    }
    
    ///上传功能初始化
    _albbMediaService =[[TaeSDK sharedInstance] getService:@protocol(ALBBMediaServiceProtocol)];
    _notificationupload1 = [TFEUploadNotification notificationWithProgress:nil success:^(TFEUploadSession *session, NSString *url) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _headImgString = url;
        
        [self updateUserInfoWithType:1];
        
    } failed:^(TFEUploadSession *session, NSError *error) {
        [[iToast makeText:@"图片上传失败!"] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    
    UIView *vio=[[UIView alloc]initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, SCREEN_HEIGHT-84)];
    
    UIImageView *imaBG= [[UIImageView alloc]initWithFrame:self.view.frame];
    imaBG.backgroundColor=[UIColor yellowColor];
    NSURL*bgurl=[NSURL URLWithString:userInfoModel.header];
    //    imaBG.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:bgurl]];
    UIImage *imag=[UIImage imageWithData:[NSData dataWithContentsOfURL:bgurl]];
    [imaBG setImage:[self blurryImage:imag withBlurLevel:0.5]];
    //    DLog(@"****%@",bgurl);
    imaBG.alpha=0.8;
    [vio addSubview:imaBG];
    _personTableView.backgroundView=vio;
    
    
    //    UIView *tableHeader=[[UIView alloc]init];
    //    tableHeader.frame=CGRectMake(0, 0, SCREEN_WIDTH, 100);
    //    _personTableView.tableHeaderView=tableHeader;
    //    UIImageView *imageHeader=[[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 70, 70)];
    //    [imageHeader setImage:imag];
    //    [tableHeader addSubview:imageHeader];
    //    tableHeader.backgroundColor=[UIColor redColor];
    
    
}

//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
       outBuffer.data,outBuffer.width,outBuffer.height,8,outBuffer.rowBytes,colorSpace,CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_personTableView != nil) {
        return _personTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT;
    
    self.personTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _personTableView.delegate = self;
    _personTableView.dataSource = self;
    _personTableView.backgroundColor = ViewBgColor;
    _personTableView.showsVerticalScrollIndicator = NO;
    _personTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _personTableView;
}
-(AppDelegate*)delegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    
    return 40;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellName = @"PersonHeadTableViewCell";
        PersonHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        if (_headImg) {
            cell.contentImg.image = _headImg;
        }else
        {
            [cell.contentImg setImageURLStr:userInfoModel.header placeholder:[UIImage imageNamed:@"nav_leftbar_info"]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"PersonOtherInfoTableViewCell";
        PersonOtherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PersonOtherInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (indexPath.row == 1) {
            cell.titleLable.text = @"昵称";
            cell.contentLable.text = _userNameString;
            
        }else if (indexPath.row == 2)
        {
            cell.titleLable.text = @"性别";
            if (_sex == 0) {
                cell.contentLable.text = @"女";
            }else
            {
                cell.contentLable.text = @"男";
            }
            
        }
        else if (indexPath.row == 3){
            cell.titleLable.text = @"出生日期";
            double unixTimeStamp = [_birthday doubleValue]/1000;
            NSTimeInterval _interval=unixTimeStamp;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
            [_formatter setLocale:[NSLocale currentLocale]];
            [_formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *_date=[_formatter stringFromDate:date];
            cell.contentLable.text = _date;

                   }
        
//        else
//        {
////            cell.titleLable.text = @"修改绑定手机号";
//            
//
//                  }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        _headSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张照片",@"从手机相册选择", nil];
        [_headSheet showInView:self.view];
    }else if (indexPath.row == 1)
    {
        EditPersonInfoViewController *editPersonInfoVC = [[EditPersonInfoViewController alloc] init];
        editPersonInfoVC.delegate = self;
        [self.navigationController pushViewController:editPersonInfoVC animated:YES];
    }else if (indexPath.row == 2)
    {
        _sexSheet = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        [_sexSheet showInView:self.view];
    }
    
    else if (indexPath.row == 3)
    {
        _pikerView = [HZQDatePickerView instanceDatePickerView];
        _pikerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 20);
        [_pikerView setBackgroundColor:[UIColor clearColor]];
        _pikerView.delegate = self;
        [_pikerView.datePickerView setMaximumDate:[NSDate date]];
        [self.view addSubview:_pikerView];

    }
    
//    else
//    {
//        
//        
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        NSData *userData = [userDefault objectForKey:UserKey];
//        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//        
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        ChangeTelephoneNumberController *VC = [[ChangeTelephoneNumberController alloc]init];
//        VC.telephoneNumber = userInfoModel.telephone;;
//        [app.menuViewController pushToNewViewController:VC animation:YES];
//          }
}


////导航栏左右侧按钮点击
//
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == _headSheet) {
        if (buttonIndex == 1) {
            //  相册
            [self toPhotoPickingController];
        }
        if (buttonIndex == 0) {
            //  拍照
            [self toCameraPickingController];
        }
    }else
    {
        if (buttonIndex == 0) {
            _sex = 1;
            [self updateUserInfoWithType:3];
        }
        if (buttonIndex == 1)
        {
            _sex = 0;
            [self updateUserInfoWithType:3];
        }
        [_personTableView reloadData];
        
    }
    
}

#pragma UpdateNameDelegate 修改用户名代理
- (void)updateUserNameWith:(NSString *)nameString
{
    _userNameString = nameString;
    [_personTableView reloadData];
    [self updateUserInfoWithType:2];
}

///修改用户信息
///1 是头像，2 是昵称 3 是性别 4 是年龄
- (void)updateUserInfoWithType:(int)type
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    In_UpdateUserInfoModel *inModel = [[In_UpdateUserInfoModel alloc] init];
    NSString *hmacString;
    
    if (type == 1)
    {
        NSArray *dateArray = [[NSArray alloc] initWithObjects:@"-1",_headImgString,@"",@"",userInfoModel.userId, nil];
        hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dateArray];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.user_id = userInfoModel.userId;
        inModel.username = @"";
        inModel.header = _headImgString;
        inModel.birthday = @"";
        inModel.gender = -1;
        
    }else if (type == 2)
    {
        NSArray *dateArray = [[NSArray alloc] initWithObjects:@"-1",_userNameString,@"",@"",userInfoModel.userId, nil];
        hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dateArray];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.user_id = userInfoModel.userId;
        inModel.username = _userNameString;
        inModel.header = @"";
        inModel.birthday = @"";
        inModel.gender = -1;
    }else if (type == 3)
    {
        NSArray *dateArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",_sex],@"",@"",@"",userInfoModel.userId, nil];
        hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dateArray];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.user_id = userInfoModel.userId;
        inModel.username = @"";
        inModel.header = @"";
        inModel.birthday = @"";
        inModel.gender = _sex;
    }else
    {
        NSArray *dateArray = [[NSArray alloc] initWithObjects:@"-1",@"",@"",_birthday,userInfoModel.userId, nil];
        hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dateArray];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.user_id = userInfoModel.userId;
        inModel.username = @"";
        inModel.header = @"";
        inModel.birthday = _birthday;
        inModel.gender = -1;
    }
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_UpdateUserInfoModel *outModel = [[communcation sharedInstance] updateUserInfoWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if (type == 1) {
                    [[iToast makeText:@"头像已修改!"] show];
                    
                    [self saveheaderImageToDocument];
                }else if (type == 2)
                {
                    [[iToast makeText:@"昵称已修改!"] show];
                }else if (type == 3)
                {
                    [[iToast makeText:@"性别已修改!"] show];
                }else
                {
                    [[iToast makeText:@"年龄已修改!"] show];
                }
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
    
    
}



///拍照上传头像
- (void)toCameraPickingController
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [[iToast makeText:@"该设备不支持拍照!"] show];
        return;
    }
    else {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.view.backgroundColor = [UIColor blackColor];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraPicker.allowsEditing = YES;
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            
            [[self delegate].menuViewController presentViewController:cameraPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
        else {
            [[self delegate].menuViewController presentViewController:cameraPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
    }
}

- (void)toPhotoPickingController
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [[iToast makeText:@"该设备不支持拍照!"] show];
        return;
    }
    else {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.view.backgroundColor = [UIColor whiteColor];
        photoPicker.delegate = self;
        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoPicker.allowsEditing = YES;
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            [[self delegate].menuViewController presentViewController:photoPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
        else {
            [[self delegate].menuViewController presentViewController:photoPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
    }
}
#pragma mark 头像保存到本地
-(void)saveheaderImageToDocument{
    NSUserDefaults *userDefault1 = [NSUserDefaults standardUserDefaults];
    NSData *userData1 = [userDefault1 objectForKey:UserKey];
    UserInfoSaveModel *outModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData1];
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    UserInfoSaveModel *saveModel = [[UserInfoSaveModel alloc] init];
    saveModel.primaryKey = outModel.primaryKey;
    saveModel.key = outModel.key;
    saveModel.userId = outModel.userId;
    saveModel.username = outModel.username;
    saveModel.type = outModel.type;
    saveModel.status = outModel.status;
    saveModel.isdelete = outModel.isdelete;
    saveModel.header =_headImgString ;
    saveModel.telephone = outModel.telephone;
    saveModel.gender = outModel.gender;
    saveModel.notifyid = outModel.notifyid;
    saveModel.level = outModel.level;
    saveModel.point = outModel.point;
    saveModel.istested = outModel.istested;
    saveModel.istrained = outModel.istrained;
    saveModel.cityName = outModel.cityName;
    saveModel.tag = outModel.tag;
    saveModel.positiveIdPath = outModel.positiveIdPath;
    saveModel.negativeIdPath = outModel.negativeIdPath;
    saveModel.handIdPath = outModel.handIdPath;
    saveModel.authenTelephone = outModel.authenTelephone;
    saveModel.realName = outModel.realName;
    saveModel.idNum = outModel.idNum;
    saveModel.brokerStatus = outModel.brokerStatus;
    saveModel.isbroker = outModel.isbroker;
    saveModel.declaration = outModel.declaration;
    saveModel.birthday = outModel.birthday;
    saveModel.isauthen = outModel.isauthen;
    saveModel.stars = outModel.stars;
    saveModel.title = outModel.title;
    saveModel.isFirst = @"1";
    saveModel.isSetPayPassword = outModel.isSetPayPassword;
    saveModel.isBindWithdrawAccount = outModel.isBindWithdrawAccount;
    saveModel.iswork = outModel.iswork;
    NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:saveModel];
    [userDefault setObject:setData forKey:UserKey];
    NSSet *set = [[NSSet alloc] initWithObjects:outModel.tag, nil];
    [APService setTags:set alias:outModel.notifyid callbackSelector:nil object:nil];
    
    
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

//图片选择代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }];
    }
    else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }];
    }
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    _headImg = img;
    [_personTableView reloadData];
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"头像上传中";
    NSData *imageData1;
    if (UIImagePNGRepresentation(_headImg) == nil) {
        
        imageData1 = UIImageJPEGRepresentation(_headImg, 1);
        
    } else {
        
        imageData1 = UIImagePNGRepresentation(_headImg);
    }
    
    TFEUploadParameters *params1 = [TFEUploadParameters paramsWithData:imageData1 space:@"static" fileName:[self uniqueString] dir:@"produce.client/user"];
    
    [_albbMediaService upload:params1 options:nil notification:_notificationupload1];
}


//日期选择代理
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    _birthday = date;
    [_personTableView reloadData];
    [self updateUserInfoWithType:4];
}

///获取随机不重复字符串
- (NSString*) uniqueString
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}


@end
