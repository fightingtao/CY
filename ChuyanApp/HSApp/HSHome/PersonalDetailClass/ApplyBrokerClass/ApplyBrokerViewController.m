//
//  ApplyBrokerViewController.m
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ApplyBrokerViewController.h"

#import "ApplyBrokerInfoTableViewCell.h"
#import "ApplyBrokerImgTableViewCell.h"
#import "ApplyBrokerTestTableViewCell.h"

#import "BrokerTrainViewController.h"
#import "BrokerTestViewController.h"
#import "BrokerDelegateViewController.h"

@interface ApplyBrokerViewController ()<ApplyInfoDelegate,IdImgDelegate,CompleteTrainDelegate,CompleteTestDelegate>
{
    ///是否培训
    BOOL _isTrain;
    ///是否测试
    BOOL _isTest;
    ///当前选择图片的类型 1是正面照 2是反面照 3是手持照
    int _currentImgType;
    ///是否同意协议
    BOOL _protocolYES;
    
    ///上传的身份证图片
    UIImage *_positiveImg;
    UIImage *_negativeImg;
    UIImage *_handIdImg;
    
    ///上传图片后图片地址
    NSString *_positiveImgString;
    NSString *_negativeImgString;
    NSString *_handIdImgString;
    
    ///身份信息
    NSString *_realNameString;
    NSString *_realPhoneString;
    NSString *_realIdString;
    ///上传图片索引
    int _uploadIndex;
}

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *applyTableView;

@property (nonatomic, strong) UIView *dealView;
@property (nonatomic, strong) UIButton *applyBtn;

@property (nonatomic, strong) UILabel *tipLabel;//警示

@property (nonatomic, strong) UIView *checkView;
@property (nonatomic, strong) UILabel *delegateLabel;
@property (nonatomic, strong) UIButton *delegateBtn;
@property (nonatomic, strong) UIButton *checkBtn;


@property(nonatomic, strong) id<ALBBMediaServiceProtocol> albbMediaService;
@property(nonatomic, strong) TFEUploadNotification *notificationupload1;
@property(nonatomic, strong) TFEUploadNotification *notificationupload2;
@property(nonatomic, strong) TFEUploadNotification *notificationupload3;

@end

@implementation ApplyBrokerViewController

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
        _titleLabel.text = @"认证经纪人";
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
    
    //获取用户信息，判断是否培训，测试
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfoModel.istrained == 1) {
        _isTrain = YES;
    }else
    {
        _isTrain = NO;
    }
    if (userInfoModel.istested == 1) {
        _isTest = YES;
    }else
    {
        _isTest = NO;
    }
    
    [self initpersonTableView];
    [self.view addSubview:_applyTableView];
    
    
    if (!_dealView) {
        _dealView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _dealView.backgroundColor = ViewBgColor;
        [self.view addSubview:_dealView];
    }
    
    if (!_applyBtn) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
        [_applyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [_applyBtn addTarget:self action:@selector(applyBrokerClick) forControlEvents:UIControlEventTouchUpInside];
        _applyBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _applyBtn.layer.borderWidth = 0.5;
        _applyBtn.layer.cornerRadius = 5;
        [_applyBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_applyBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_applyBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _applyBtn.titleLabel.font = LittleFont;
        [_dealView addSubview:_applyBtn];
    }
    
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 25)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:12];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.text = @"请按要求填写真实信息，以免审核不通过再次申请!";
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }

    if (!_checkView) {
        _checkView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50)];
        _checkView.backgroundColor = ViewBgColor;
    }
    
    
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.frame = CGRectMake(20, 10, 20, 20);
        _checkBtn.backgroundColor = [UIColor whiteColor];
        [_checkBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"btn_check_cellect"] forState:UIControlStateSelected];
        [_checkBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [_checkView addSubview:_checkBtn];
        _protocolYES = NO;
    }
    
    if (!_delegateLabel) {
        _delegateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,10, 100, 20)];
        _delegateLabel.backgroundColor = [UIColor clearColor];
        _delegateLabel.font = LittleFont;
        _delegateLabel.textColor = TextMainCOLOR;
        _delegateLabel.text = @"我已阅读并同意";
        _delegateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _delegateLabel.textAlignment = NSTextAlignmentLeft;
        [_checkView addSubview:_delegateLabel];
    }
    if (!_delegateBtn) {
        _delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delegateBtn.frame = CGRectMake(150, 10, 100, 20);
        _delegateBtn.backgroundColor = [UIColor clearColor];
        [_delegateBtn setTitle:@"《经纪人协议》" forState:UIControlStateNormal];
        [_delegateBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _delegateBtn.titleLabel.font = LittleFont;
        [_delegateBtn addTarget:self action:@selector(delegateClick) forControlEvents:UIControlEventTouchUpInside];
        [_checkView addSubview:_delegateBtn];

    }
    
    ///上传功能初始化
    _albbMediaService =[[TaeSDK sharedInstance] getService:@protocol(ALBBMediaServiceProtocol)];
    _uploadIndex = 0;
    ///正面照上传回调
    _notificationupload1 = [TFEUploadNotification notificationWithProgress:nil success:^(TFEUploadSession *session, NSString *url) {

        _uploadIndex++;
        _positiveImgString = url;
        [self allContentSubmit];
    } failed:^(TFEUploadSession *session, NSError *error) {
        [[iToast makeText:@"图片上传失败!"] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    ///反面照上传回调
    _notificationupload2 = [TFEUploadNotification notificationWithProgress:nil success:^(TFEUploadSession *session, NSString *url) {
        
        _uploadIndex++;
        _negativeImgString = url;
        [self allContentSubmit];
    } failed:^(TFEUploadSession *session, NSError *error) {
        [[iToast makeText:@"图片上传失败!"] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    ///手持照上传回调
    _notificationupload3 = [TFEUploadNotification notificationWithProgress:nil success:^(TFEUploadSession *session, NSString *url) {
        
        _uploadIndex++;
        _handIdImgString = url;
        [self allContentSubmit];
    } failed:^(TFEUploadSession *session, NSError *error) {
        [[iToast makeText:@"图片上传失败!"] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化下单table
-(UITableView *)initpersonTableView
{
    if (_applyTableView != nil) {
        return _applyTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 0.0;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = SCREEN_HEIGHT-50;
    
    self.applyTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _applyTableView.delegate = self;
    _applyTableView.dataSource = self;
    _applyTableView.backgroundColor = ViewBgColor;
    _applyTableView.showsVerticalScrollIndicator = NO;
    _applyTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return _applyTableView;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 25;
    }
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 50;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _tipLabel;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return _checkView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  [ApplyBrokerInfoTableViewCell cellHeight];
    }else if (indexPath.section == 1)
    {
        return [ApplyBrokerImgTableViewCell cellHeight];
    }
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellName = @"ApplyBrokerInfoTableViewCell";
        ApplyBrokerInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ApplyBrokerInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *cellName = @"ApplyBrokerImgTableViewCell";
        ApplyBrokerImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ApplyBrokerImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (_positiveImg) {
            cell.idImg.image = _positiveImg;
        }
        
        if (_negativeImg) {
            cell.idImg2.image = _negativeImg;
        }
        
        if (_handIdImg) {
            cell.idImg3.image = _handIdImg;
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"ApplyBrokerTestTableViewCell";
        ApplyBrokerTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ApplyBrokerTestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (indexPath.row == 0) {
            cell.titleLable.text = @"在线培训";
            if (_isTrain) {
                cell.contentLable.text = @"已通过";
            }else
            {
                cell.contentLable.text = @"未通过";
            }
        }else{
            cell.titleLable.text = @"在线测试";
            if (_isTest) {
                cell.contentLable.text = @"已通过";
            }else
            {
                cell.contentLable.text = @"未通过";
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            BrokerTrainViewController *trainVC = [[BrokerTrainViewController alloc] init];
            trainVC.delegate = self;
            [self.navigationController pushViewController:trainVC animated:YES];
        }else
        {
            BrokerTestViewController *testVC = [[BrokerTestViewController alloc] init];
            testVC.delegate = self;
            [self.navigationController pushViewController:testVC animated:YES];
        }
    }
}
///提交申请，上传图片
- (void)applyBrokerClick
{
    if (!_realNameString || [_realNameString isEqualToString:@""]) {
        [[iToast makeText:@"请输入真实姓名!"] show];
        return;
    }
    
    if (!_realPhoneString || [_realPhoneString isEqualToString:@""]) {
        [[iToast makeText:@"请输入联系电话!"] show];
        return;
    }
    
    if (!_realIdString || [_realIdString isEqualToString:@""]) {
        [[iToast makeText:@"请输入身份证号!"] show];
        return;
    }
    
    if (!_positiveImg) {
        [[iToast makeText:@"请上传身份证正面照!"] show];
        return;
    }
    if (!_negativeImg) {
        [[iToast makeText:@"请上传身份证反面照!"] show];
        return;
    }
    if (!_handIdImg) {
        [[iToast makeText:@"请上传身份证手持照!"] show];
        return;
    }
    if (!_isTrain) {
        [[iToast makeText:@"请通过在线培训!"] show];
        return;
    }
    
    if (!_isTest) {
        [[iToast makeText:@"请通过在线测试!"] show];
        return;
    }
    if (!_protocolYES) {
        [[iToast makeText:@"请确认并同意《经纪人协议》!"] show];
        return;
    }
    
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"资料上传中";
    
    NSData *imageData1;
    if (UIImagePNGRepresentation(_positiveImg) == nil) {
        
        imageData1 = UIImageJPEGRepresentation(_positiveImg, 1);
        
    } else {
        
        //imageData1 = UIImagePNGRepresentation(_positiveImg);
        UIImage *image1 = [self imageCompressWithSimple:_positiveImg scaledToSize:_positiveImg.size];
        imageData1 = UIImageJPEGRepresentation(image1, 0.3f);
        
    }
    NSData *imageData2;
    if (UIImagePNGRepresentation(_negativeImg) == nil) {
        
        imageData2 = UIImageJPEGRepresentation(_negativeImg, 1);
        
    } else {
        
        //imageData2 = UIImagePNGRepresentation(_negativeImg);
        UIImage *image2 = [self imageCompressWithSimple:_negativeImg scaledToSize:_positiveImg.size];
        imageData2 = UIImageJPEGRepresentation(image2, 0.3f);

    }
    
    NSData *imageData3;
    if (UIImagePNGRepresentation(_handIdImg) == nil) {
        
        imageData3 = UIImageJPEGRepresentation(_handIdImg, 1);
        
    } else {
        
        //imageData3 = UIImagePNGRepresentation(_handIdImg);
        UIImage *image3 = [self imageCompressWithSimple:_handIdImg scaledToSize:_positiveImg.size];
        imageData3 = UIImageJPEGRepresentation(image3, 0.3f);

    }

    TFEUploadParameters *params1 = [TFEUploadParameters paramsWithData:imageData1 space:@"static" fileName:[self uniqueString] dir:@"broker/authen"];
    TFEUploadParameters *params2 = [TFEUploadParameters paramsWithData:imageData2 space:@"static" fileName:[self uniqueString] dir:@"broker/authen"];
    TFEUploadParameters *params3 = [TFEUploadParameters paramsWithData:imageData3 space:@"static" fileName:[self uniqueString] dir:@"broker/authen"];
    [_albbMediaService upload:params1 options:nil notification:_notificationupload1];
    [_albbMediaService upload:params2 options:nil notification:_notificationupload2];
    [_albbMediaService upload:params3 options:nil notification:_notificationupload3];
    
}

///提交认证信息
- (void)allContentSubmit
{
    if (_uploadIndex == 3)
    {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,_positiveImgString,_negativeImgString,_handIdImgString,_realNameString,_realPhoneString,_realIdString,nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        In_AuthenBrokerModel *inModel = [[In_AuthenBrokerModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hmacString;
        inModel.userId = userInfoModel.userId;
        inModel.positiveIdPath = _positiveImgString;
        inModel.negativeIdPath = _negativeImgString;
        inModel.handIdPath = _handIdImgString;
        inModel.authenTelephone = _realPhoneString;
        inModel.realName = _realNameString;
        inModel.idNum = _realIdString;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AuthenBrokerModel *outModel = [[communcation sharedInstance] authenBrokerWithModel:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    _uploadIndex = 0;
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"上传成功，请耐心等待审核通过!"] show];
                    [self leftItemClick];
                }else{
                    [[iToast makeText:outModel.message] show];
                    _uploadIndex = 0;
                }
            });
            
        });

    }else
    {
        return;
    }
}

///选择协议
- (void)selectClick:(id)sender
{
    _checkBtn.selected = !_checkBtn.selected;
    if (_checkBtn.selected)
    {
        _protocolYES = YES;
    }else{
        _protocolYES = NO;
    }

}

///查看协议
- (void)delegateClick{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BrokerDelegateViewController *borker = [[BrokerDelegateViewController alloc]init];
    [app.menuViewController pushToNewViewController:borker animation:YES];
}

#pragma CompleteTrainDelegate 完成培训代理
- (void)completeTrainWithStatus:(int)status
{
    if (status == 1) {
        _isTrain = YES;
        [_applyTableView reloadData];
    }else
    {
        return;
    }
}


#pragma CompleteTestDelegate 完成测试代理
- (void)completeTestWithStatus:(int)status
{
    if (status == 1) {
        _isTest = YES;
        [_applyTableView reloadData];
    }else
    {
        return;
    }
}


#pragma ApplyInfoDelegate 申请信息代理
- (void)setAgentInfo:(NSString *)string andType:(int)type;
{
    if (type == 1) {
        _realNameString = string;
    }else if (type == 2)
    {
         _realPhoneString = string;
    }else
    {
         _realIdString = string;
    }
}


#pragma IdImgDelegate  选择图片代理
- (void) idImgChoose:(int)type
{
    _currentImgType = type;
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张照片",@"从手机相册选择", nil];
    [as showInView:self.view];
}


//导航栏左右侧按钮点击
- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //  相册
        [self toPhotoPickingController];
    }
    if (buttonIndex == 0) {
        //  拍照
        [self toCameraPickingController];
    }
}


- (void)toCameraPickingController
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    else {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.view.backgroundColor = [UIColor blackColor];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            [app.menuViewController presentViewController:cameraPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
        else {
            [app.menuViewController presentViewController:cameraPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
    }
}

- (void)toPhotoPickingController
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    else {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.view.backgroundColor = [UIColor whiteColor];
        photoPicker.delegate = self;
        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            [app.menuViewController presentViewController:photoPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
        else {
            [app.menuViewController presentViewController:photoPicker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            }];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

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
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];

    if (_currentImgType ==1) {
        _positiveImg = img;
    }else if (_currentImgType == 2)
    {
        _negativeImg = img;
    }else
    {
        _handIdImg = img;
    }
    [_applyTableView reloadData];
    
}

///获取随机不重复字符串
- (NSString*) uniqueString
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

- (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0,1300,900)];
    UIImage* newImage =
    UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
