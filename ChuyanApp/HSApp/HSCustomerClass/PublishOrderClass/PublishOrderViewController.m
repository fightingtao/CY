//
//  PublishOrderViewController.m
//  HSApp
//
//  Created by xc on 15/11/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PublishOrderViewController.h"
#import "PublishOrderTypeTableViewCell.h"
#import "PublishOrderFeesTableViewCell.h"
#import "PublishOrderAddressTableViewCell.h"
#import "OrderTypeChooseViewController.h"
#import "OrderFeesChooseViewController.h"
#import "OrderAddressChooseViewController.h"


@interface PublishOrderViewController ()<OrderTypeChooseDelegate,OrderFeesChooseDelegate,OrderAddressChooseDelegate>
{
    ///上传图片Data数组
    NSMutableArray *_imgsArray;
    ///已选择小费
    OutTipsBody *_tipsModel;
    ///已选择类型
    OutTypeBody *_typeModel;
    ///已选择地址
    OutAddressBody *_toAddressModel;
    OutAddressBody *_fromAddressModel;
    ///上传后语音地址
    NSString *_voiceUrlString;
    ///上传图片的字符串
    NSString *_imageUrlString;
    ///判断语音或者图片是否上传结束，如果是语音则是[_imgsArray count]+1,文字则是[_imgsArray count]
    int _uploadIndex;
    NSString *_advertId;
    
}
@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITableView *publishTableView;


@property (nonatomic, strong) UIView *textOrderView;//文字呼单
@property (nonatomic, strong) UIView *voiceOrderView;//语音呼单

@property (nonatomic, strong) UITextView *demandTextView;//文字需求内容



@property (nonatomic, strong) UIView *playVoiceView;//播放语音view
@property (nonatomic, strong) UIButton *playVoiceBtn;
@property (nonatomic, strong) UILabel *voiceTipLabel;
@property (nonatomic, strong) UIButton *deleteVoiceBtn;

@property (nonatomic, strong) UIView *uploadImgView;//上传图片
@property (nonatomic, strong) UIImageView *uploadTipImg;
@property (nonatomic, strong) UILabel *uploadTipLabel;
@property (nonatomic, strong) UIButton *uploadImgBtn;


@property (nonatomic, strong) UIView *publishOrderView;
@property (nonatomic, strong) UIButton *publishOrderBtn;

@property (nonatomic, strong) UIView *maskView;//背景view
@property (nonatomic, strong) OrderTypeChooseViewController *typeChooseVC;
@property (nonatomic, strong) OrderFeesChooseViewController *feesChooseVC;


@property (strong, nonatomic)   AVAudioPlayer    *player;

@property(nonatomic, strong) id<ALBBMediaServiceProtocol> albbMediaService;
@property(nonatomic, strong) TFEUploadNotification *notificationupload1;
@property(nonatomic, strong) TFEUploadNotification *notificationupload2;

@end

@implementation PublishOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        _titleLabel.text = @"发布需求";
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
    //文字需求
    if (!_textOrderView) {
        _textOrderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 195)];
        _textOrderView.backgroundColor = ViewBgColor;
    }
    
    
    if (!_demandTextView) {
        _demandTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 100)];
        _demandTextView.textColor = TextMainCOLOR;//设置textview里面的字体颜色
        _demandTextView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
        _demandTextView.delegate = self;//设置它的委托方法
        _demandTextView.backgroundColor = WhiteBgColor;//设置它的背景颜色
        _demandTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
        _demandTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _demandTextView.scrollEnabled = NO;//是否可以拖动
        _demandTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _demandTextView.layer.borderColor = [UIColor blackColor].CGColor;
        _demandTextView.layer.borderWidth = 0.5;
        [_textOrderView addSubview:_demandTextView];
    }
    
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 23, SCREEN_WIDTH-40, 40)];
        _placeLabel.numberOfLines = 2;
        _placeLabel.backgroundColor = [UIColor clearColor];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.font = LittleFont;
        _placeLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        _placeLabel.text = @"你可以输入对需求的描述：例如买什么东西，办什么事情、需要送什么东西。";
        [_textOrderView addSubview:_placeLabel];
    }
    
    if (_type ==2) {
        _placeLabel.text = _placeString;
        _demandTextView.selectable = NO;
    }
    _placeLabel.text = _placeString;
    
    if (_placeString.length < 20) {
        _placeLabel.frame = CGRectMake(25, 25, SCREEN_WIDTH-40, 20);
    }
    //语音需求
    if (!_voiceOrderView) {
        _voiceOrderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 140)];
        _voiceOrderView.backgroundColor = ViewBgColor;
    }
    
    if (!_voiceTipLabel) {
        _voiceTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,20, SCREEN_WIDTH-125, 44)];
        _voiceTipLabel.backgroundColor = WhiteBgColor;
        _voiceTipLabel.font = LittleFont;
        _voiceTipLabel.textColor = TextMainCOLOR;
        _voiceTipLabel.text = @"10S";
        _voiceTipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _voiceTipLabel.textAlignment = NSTextAlignmentCenter;
        _voiceTipLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _voiceTipLabel.layer.borderWidth = 0.5;
        [_voiceOrderView addSubview:_voiceTipLabel];
    }
    
    if (!_playVoiceBtn) {
        _playVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playVoiceBtn.frame = CGRectMake(40,27, 30, 30);
        [_playVoiceBtn setImage:[UIImage imageNamed:@"btn_suspended"] forState:UIControlStateNormal];
        [_playVoiceBtn addTarget:self action:@selector(playVoiceClick) forControlEvents:UIControlEventTouchUpInside];
        [_voiceOrderView addSubview:_playVoiceBtn];
    }
    
    if (!_deleteVoiceBtn) {
        _deleteVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteVoiceBtn.frame = CGRectMake(SCREEN_WIDTH-90,20, 70, 44);
        [_deleteVoiceBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteVoiceBtn addTarget:self action:@selector(deleteVoiceClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteVoiceBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _deleteVoiceBtn.layer.borderWidth = 0.5;
        [_deleteVoiceBtn setBackgroundColor:WhiteBgColor];
        [_deleteVoiceBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _deleteVoiceBtn.titleLabel.font = LittleFont;
        [_voiceOrderView addSubview:_deleteVoiceBtn];
    }
    //上传图片
    if (!_uploadImgView) {
        _uploadImgView = [[UIView alloc] initWithFrame:CGRectMake(20, 135, SCREEN_WIDTH-40  , 44)];
        _uploadImgView.backgroundColor = WhiteBgColor;
        _uploadImgView.layer.borderColor = [UIColor blackColor].CGColor;
        _uploadImgView.layer.borderWidth = 0.5;
    }
    
    if (!_uploadTipImg) {
        _uploadTipImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 31, 24)];
        _uploadTipImg.image = [UIImage imageNamed:@"btn_photo"];
        [_uploadImgView addSubview:_uploadTipImg];
    }
    
    if (!_uploadTipLabel) {
        _uploadTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-40, 44)];
        _uploadTipLabel.backgroundColor = [UIColor clearColor];
        _uploadTipLabel.font = LittleFont;
        _uploadTipLabel.textColor = TextMainCOLOR;
        _uploadTipLabel.text = @"上传图片";
        _uploadTipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _uploadTipLabel.textAlignment = NSTextAlignmentCenter;
        [_uploadImgView addSubview:_uploadTipLabel];
    }

    if (!_uploadImgBtn) {
        _uploadImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _uploadImgBtn.frame = CGRectMake(0,0, SCREEN_WIDTH-40, 44);
        [_uploadImgBtn addTarget:self action:@selector(uploadImgClick) forControlEvents:UIControlEventTouchUpInside];
        [_uploadImgView addSubview:_uploadImgBtn];
    }
    
    _imgsArray = [[NSMutableArray alloc] init];
    
    //发布需求
    if (!_publishOrderView) {
        _publishOrderView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        _publishOrderView.backgroundColor = ViewBgColor;
        [self.view addSubview:_publishOrderView];
    }
    
    if (!_publishOrderBtn) {
        _publishOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishOrderBtn.frame = CGRectMake(20,5, SCREEN_WIDTH-40, 40);
        [_publishOrderBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [_publishOrderBtn addTarget:self action:@selector(publishOrderClick) forControlEvents:UIControlEventTouchUpInside];
        _publishOrderBtn.layer.borderColor = TextMainCOLOR.CGColor;
        _publishOrderBtn.layer.borderWidth = 0.5;
        _publishOrderBtn.layer.cornerRadius = 5;
        [_publishOrderBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:WhiteBgColor] forState:UIControlStateNormal];
        [_publishOrderBtn setBackgroundImage:[[communcation sharedInstance] createImageWithColor:ButtonBGCOLOR] forState:UIControlStateHighlighted];
        [_publishOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _publishOrderBtn.titleLabel.font = LittleFont;
        [_publishOrderView addSubview:_publishOrderBtn];
    }
    [self initpublishTableView];
    [self.view addSubview:_publishTableView];
    
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }
    
    if (!_typeChooseVC) {
        _typeChooseVC = [[OrderTypeChooseViewController alloc] init];
        _typeChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _typeChooseVC.delegate = self;
    }
    
    if (!_feesChooseVC) {
        _feesChooseVC = [[OrderFeesChooseViewController alloc] init];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _feesChooseVC.delegate = self;
    }
    
    ///上传功能初始化
    _albbMediaService =[[TaeSDK sharedInstance] getService:@protocol(ALBBMediaServiceProtocol)];
    _imageUrlString = @"";
    _uploadIndex = 0;
    _toAddressModel = [[OutAddressBody alloc] init];
    _fromAddressModel= [[OutAddressBody alloc] init];
    _advertId = @"0";
    
    if (_publishType == OrderPublishType_VoiceOrder)
    {
        _voiceTipLabel.text = [NSString stringWithFormat:@"%dS",_voiceTime];
    }else
    {
        
    }
    
    
    _notificationupload1 = [TFEUploadNotification notificationWithProgress:nil success:^(TFEUploadSession *session, NSString *url) {
        NSLog(@"%@", session.responseUrl);
        
        _voiceUrlString = session.responseUrl;
        _uploadIndex++;
        [self allContentPublish];
    } failed:^(TFEUploadSession *session, NSError *error) {
        NSLog(@"%@",error);
        [[iToast makeText:@"语音上传失败!"] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    _notificationupload2 = [TFEUploadNotification notificationWithProgress:nil success:^(TFEUploadSession *session, NSString *url) {
        NSLog(@"%@", session.responseUrl);
        if (_imageUrlString.length == 0) {
            _imageUrlString = [NSString stringWithFormat:@"%@%@",_imageUrlString,session.responseUrl];
            _uploadIndex++;
        }else
        {
            _imageUrlString = [NSString stringWithFormat:@"%@,%@",_imageUrlString,session.responseUrl];
            _uploadIndex++;
        }
        [self allContentPublish];
    } failed:^(TFEUploadSession *session, NSError *error) {
        NSLog(@"%@",error);
        [[iToast makeText:@"图片上传失败!"] show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

    if (_tempDefaultType) {
        _typeModel = _tempDefaultType;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.player stop];
}

//初始化table
-(UITableView *)initpublishTableView
{
    if (_publishTableView != nil) {
        return _publishTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 64.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-64-50;
    
    self.publishTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _publishTableView.delegate = self;
    _publishTableView.dataSource = self;
    _publishTableView.backgroundColor = ViewBgColor;
    _publishTableView.showsVerticalScrollIndicator = NO;
    return _publishTableView;
}


-(AppDelegate*)delegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_typeModel.typeId == 3) {
        return 4;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_imgsArray count] == 0) {
        if (_publishType == OrderPublishType_TxtOrder)
        {
            return 195;
        }else
        {
            return 140;
        }
        
    }else
    {
        if (_publishType == OrderPublishType_TxtOrder)
        {
            return 285;
        }else
        {
            return 230;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_publishType == OrderPublishType_TxtOrder)
    {
        _uploadImgView.frame = CGRectMake(20, 135, SCREEN_WIDTH-40  , 44);
        [_textOrderView addSubview:_uploadImgView];
        [self showImgInView];
        return _textOrderView;
    }else
    {
        _uploadImgView.frame = CGRectMake(20, 79, SCREEN_WIDTH-40  , 44);
        [_voiceOrderView addSubview:_uploadImgView];
        [self showImgInView];
        return _voiceOrderView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellName = @"PublishOrderTypeTableViewCell";
        PublishOrderTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PublishOrderTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_typeModel) {
            cell.contentLable.text = [NSString stringWithFormat:@"%@",_typeModel.type_name];
        }else
        {
            cell.contentLable.text = @"选择类型";
        }
        return cell;
    }else if (indexPath.row == 1)
    {
        static NSString *cellName = @"PublishOrderFeesTableViewCell";
        PublishOrderFeesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PublishOrderFeesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (_tipsModel) {
            cell.contentLable.text = [NSString stringWithFormat:@"%0.2f元",_tipsModel.tip];
        }else
        {
            cell.contentLable.text = @"选择小费";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2)
    {
        static NSString *cellName = @"PublishOrderAddressTableViewCell";
        PublishOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PublishOrderAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (_toAddressModel) {
            cell.phoneLabel.text = _toAddressModel.telephone;
            cell.addressLabel.text = _toAddressModel.text;
        }else
        {
            cell.phoneLabel.text = @"";
            cell.addressLabel.text = @"";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellName = @"PublishOrderAddressTableViewCell";
        PublishOrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[PublishOrderAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        if (_fromAddressModel) {
            cell.phoneLabel.text = _fromAddressModel.telephone;
            cell.addressLabel.text = _fromAddressModel.text;
        }else
        {
            cell.phoneLabel.text = @"";
            cell.addressLabel.text = @"";
        }
        cell.titleLable.text = @"取货地址";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (indexPath.row == 0) {
        if (_tempDefaultType) {
            return;
        }
        [window addSubview:_maskView];
        [window addSubview:_typeChooseVC.view];
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.alpha = 0.7;
            _typeChooseVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-250)/2, SCREEN_WIDTH-40, 250);
        } completion: ^(BOOL finish){
        }];
    }else if (indexPath.row == 1)
    {
        [window addSubview:_maskView];
        [window addSubview:_feesChooseVC.view];
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.alpha = 0.7;
            _feesChooseVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-350)/2, SCREEN_WIDTH-40, 350);
        } completion: ^(BOOL finish){
        }];
    }else if (indexPath.row == 2)
    {
        OrderAddressChooseViewController *addressChooseVC = [[OrderAddressChooseViewController alloc] init];
        addressChooseVC.addressType = 1;
        addressChooseVC.delegate = self;
        [self.navigationController pushViewController:addressChooseVC animated:YES];
    }else
    {
        OrderAddressChooseViewController *addressChooseVC = [[OrderAddressChooseViewController alloc] init];
        addressChooseVC.addressType = 2;
        addressChooseVC.delegate = self;
        [self.navigationController pushViewController:addressChooseVC animated:YES];
    }
}


//播放语音
- (void)playVoiceClick
{
    NSString *convertedPath = [self GetPathByFileName:[@"recoder" stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
    
///amr转wav
    if ([VoiceConverter ConvertAmrToWav:[NSString stringWithFormat:@"%@",_voicePath] wavSavePath:convertedPath]){
    }else
        NSLog(@"amr转wav失败");
    
    self.player = [[AVAudioPlayer alloc]init];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    self.player = [self.player initWithContentsOfURL:[NSURL URLWithString:convertedPath] error:nil];
    [self.player play];
}


//删除语音
- (void)deleteVoiceClick
{
    [self leftItemClick];
}

//发布需求
- (void)publishOrderClick
{
    if (_publishType == OrderPublishType_TxtOrder ) {
        if (_demandTextView.text.length == 0) {
            [[iToast makeText:@"请输入需求内容!"] show];
            return;
        }
    }
    if (!_typeModel||_typeModel.typeId == 0) {
         [[iToast makeText:@"请选择类型!"] show];
        return;
    }
    if (!_tipsModel|| _tipsModel.tipid == 0) {
        [[iToast makeText:@"请选择小费!"] show];
        return;
    }
    if (_typeModel.typeId==3) {
        if (!_fromAddressModel||!_fromAddressModel.addressid) {
            [[iToast makeText:@"请选择取货地址!"] show];
            return;
        }
        if (!_toAddressModel||!_toAddressModel.addressid) {
            [[iToast makeText:@"请选择送达地址!"] show];
            return;
        }
    }else
    {
        if (!_toAddressModel||!_toAddressModel.addressid) {
            [[iToast makeText:@"请选择送达地址!"] show];
            return;
        }
    }
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"发布中";
    if (_publishType == OrderPublishType_VoiceOrder)
    {
        NSString *uploadName= [NSString stringWithFormat:@"%@.amr",[self uniqueString]];
        TFEUploadParameters *params1 = [TFEUploadParameters paramsWithFilePath:_voicePath space:@"static" fileName:uploadName dir:@"produce.client/order"];
        [_albbMediaService upload:params1 options:nil notification:_notificationupload1];
    }else
    {
        if (_demandTextView.text.length == 0) {
            [[iToast makeText:@"请输入需求内容!"] show];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            return;
        }
    }

    if (_imgsArray && [_imgsArray count] != 0) {
        for (int i = 0; i < [_imgsArray count]; i++) {
            UIImage *image = [_imgsArray objectAtIndex:i];
            NSData *imageData=UIImageJPEGRepresentation(image, 0);
            NSString *uploadName = [NSString stringWithFormat:@"%@.%@",[self uniqueString],[self typeForImageData:imageData]];
            TFEUploadParameters *params1 = [TFEUploadParameters paramsWithData:imageData space:@"static" fileName:uploadName dir:@"produce.client/order"];
            [_albbMediaService upload:params1 options:nil notification:_notificationupload2];
        }
        
    }else
    {
        [self allContentPublish];
    }
}

//图片或者语音上传完成后调用
- (void)allContentPublish
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (_publishType == OrderPublishType_VoiceOrder)
    {
        if (_uploadIndex == _imgsArray.count +1)
        {
            NSArray *dataArray = [[NSArray alloc] initWithObjects:_voiceUrlString,_imageUrlString,@"",[NSString stringWithFormat:@"%f",_tipsModel.tip],userInfoModel.userId,[NSString stringWithFormat:@"%d",_typeModel.typeId],@"2", app.staticCity,[NSString stringWithFormat:@"%f",app.staticlat],[NSString stringWithFormat:@"%f",app.staticlng],_advertId,_toAddressModel.addressid,_fromAddressModel.addressid,nil];
            NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
            In_PublishOrderModel *inModel = [[In_PublishOrderModel alloc] init];
            inModel.key = userInfoModel.userId;
            inModel.digest = hmacString;
            inModel.desc = @"";
            inModel.tip = [NSString stringWithFormat:@"%f",_tipsModel.tip];
            inModel.userId = userInfoModel.userId;
            inModel.type = @"2";
            inModel.orderTypeId = [NSString stringWithFormat:@"%d",_typeModel.typeId];
            inModel.cityname = app.staticCity;
            inModel.lat = [NSString stringWithFormat:@"%f",app.staticlat];
            inModel.lng = [NSString stringWithFormat:@"%f",app.staticlng];
            inModel.advertId = _advertId;
            inModel.addressId = _fromAddressModel.addressid;
            inModel.toAddressId = _toAddressModel.addressid;
            inModel.voicePath = _voiceUrlString;
            inModel.picurls = _imageUrlString;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                Out_PulishOrderModel *outModel = [[communcation sharedInstance] publishOrderWithModel:inModel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (!outModel)
                    {
                        [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                        _uploadIndex = 0;
                    }else if (outModel.code ==1000)
                    {
                        [[iToast makeText:@"需求发布成功!"] show];
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
    }else
    {
        if (_uploadIndex == _imgsArray.count) {
            NSArray *dataArray = [[NSArray alloc] initWithObjects:@"",_imageUrlString,_demandTextView.text,[NSString stringWithFormat:@"%f",_tipsModel.tip],userInfoModel.userId,[NSString stringWithFormat:@"%d",_typeModel.typeId],@"1", app.staticCity,[NSString stringWithFormat:@"%f",app.staticlat],[NSString stringWithFormat:@"%f",app.staticlng],_advertId,_toAddressModel.addressid,_fromAddressModel.addressid,nil];
            NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
            In_PublishOrderModel *inModel = [[In_PublishOrderModel alloc] init];
            inModel.key = userInfoModel.userId;
            inModel.digest = hmacString;
            inModel.desc = _demandTextView.text;
            inModel.tip = [NSString stringWithFormat:@"%f",_tipsModel.tip];
            inModel.userId = userInfoModel.userId;
            inModel.type = @"1";
            inModel.orderTypeId = [NSString stringWithFormat:@"%d",_typeModel.typeId];
            inModel.cityname = app.staticCity;
            inModel.lat = [NSString stringWithFormat:@"%f",app.staticlat];
            inModel.lng = [NSString stringWithFormat:@"%f",app.staticlng];
            inModel.advertId = _advertId;
            inModel.addressId = _fromAddressModel.addressid;
            inModel.toAddressId = _toAddressModel.addressid;
            inModel.voicePath = @"";
            inModel.picurls = _imageUrlString;
            
            NSLog(@"请求内容：%@",inModel);
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                Out_PulishOrderModel *outModel = [[communcation sharedInstance] publishOrderWithModel:inModel];
                NSLog(@"测试 %@",outModel);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (!outModel)
                    {
                        [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                        _uploadIndex = 0;
                    }else if (outModel.code ==1000)
                    {
                        [[iToast makeText:@"需求发布成功!"] show];
                        [self leftItemClick];
                    }else{
                        NSLog(@"确认发布%@",outModel);

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
}


#pragma OrderTypeChooseDelegate 选择类型事件代理
- (void)cancelTypeChoose
{
    [UIView animateWithDuration:0.3 animations:^{
        _typeChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_typeChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _typeChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
    }];
}
- (void)chooseTypeWithModel:(OutTypeBody*)model
{
    [UIView animateWithDuration:0.3 animations:^{
        _typeChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_typeChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _typeChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 250);
        
        //传入选中类型，刷新数据
        _typeModel = model;
        [_publishTableView reloadData];
    }];
}


#pragma OrderFeesChooseDelegate 选择小费事件代理
- (void)cancelFeesChoose
{
    [UIView animateWithDuration:0.3 animations:^{
        _feesChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_feesChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
    }];
}
- (void)chooseFeesWithModel:(OutTipsBody*)model 
{
    [UIView animateWithDuration:0.3 animations:^{
        _feesChooseVC.view.frame = CGRectMake(20, -SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_feesChooseVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        //传入选中小费，刷新界面
        _tipsModel = model;
        [_publishTableView reloadData];
        
    }];
}

#pragma OrderAddressChooseDelegate 选择地址事件代理
- (void)getOrderAddressWithModel:(OutAddressBody *)model AndType:(int)type
{
    if (type == 1) {
        _toAddressModel = model;
    }else
    {
        _fromAddressModel  = model;
    }
    [_publishTableView reloadData];
}


//上传图片
- (void)uploadImgClick
{
    [self.demandTextView resignFirstResponder];//释放键盘
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册选择",@"拍摄照片", nil];
    [as showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //  相册
        if ([_imgsArray count]==3) {
            [[iToast makeText:@"最多上传3张图片"] show];
            return;
        }
        DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
        cont.delegate = self;
        cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
        cont.nColumnCount = 3;
        if ([_imgsArray count] == 0) {
            cont.nMaxCount = 3;
        }else if ([_imgsArray count] == 1)
        {
            cont.nMaxCount = 2;
        }else if ([_imgsArray count] == 2)
        {
            cont.nMaxCount = 1;
        }else if ([_imgsArray count] == 3)
        {
            cont.nMaxCount = 0;
        }
        
        [[self delegate].menuViewController presentViewController:cont animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }];
    }else if (buttonIndex == 1) {
        //  拍照
        if ([_imgsArray count]==3) {
            [[iToast makeText:@"最多上传3张图片"] show];
            return;
        }
        [self toCameraPickingController];
    }
}

//拍照
- (void)toCameraPickingController
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [[iToast makeText:@"当前设备不支持拍照"] show];
        return;
    }
    else {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.view.backgroundColor = [UIColor blackColor];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [[self delegate].menuViewController presentViewController:cameraPicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_imgsArray addObject:img];
    [_publishTableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [[self delegate].menuViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [[self delegate].menuViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }];
    
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        for (int i        = 0; i < MIN(4, aSelected.count); i++)
        {
            UIImage *img      = [aSelected objectAtIndex:i];
            [_imgsArray addObject:img];
        }
    }
    else if (picker.nResultType == DO_PICKER_RESULT_ASSET)
    {
        for (int i        = 0; i < MIN(4, aSelected.count); i++)
        {
            UIImage *img      = [ASSETHELPER getImageFromAsset:aSelected[i] type:ASSET_PHOTO_SCREEN_SIZE];
            [_imgsArray addObject:img];
        }
        
        [ASSETHELPER clearData];
    }
    [_publishTableView reloadData];
}

//展示选择的图片
- (void)showImgInView
{
    if (_publishType == OrderPublishType_TxtOrder) {
        for (id obj in _textOrderView.subviews)  {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView* theimage = (UIImageView*)obj;
                [theimage removeFromSuperview];
            }
        }
    }else
    {
        for (id obj in _voiceOrderView.subviews)  {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView* theimage = (UIImageView*)obj;
                [theimage removeFromSuperview];
            }
        }
    }

    
    if ([_imgsArray count] == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            _voiceOrderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 140);
            _textOrderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 195);
        } completion: ^(BOOL finish){
            _demandTextView.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 100);
        }];
        return;
    }
    
    for (int i = 0; i< [_imgsArray count]; i++) {
        if (_publishType == OrderPublishType_TxtOrder) {
            UIImage *img = [_imgsArray objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+75*i+15*i, 195, 75, 75)];
            imageView.tag = i;
            [imageView setImage:img];
            if (imageView.tag == 0)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
                [btn addTarget:self action:@selector(deleteImg1) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:[UIImage imageNamed:@"btn_del"] forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkImg1)];
                [imageView addGestureRecognizer:singleTap];
            }else if (imageView.tag == 1)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
                [btn addTarget:self action:@selector(deleteImg2) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:[UIImage imageNamed:@"btn_del"] forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkImg2)];
                [imageView addGestureRecognizer:singleTap];
            }else if (imageView.tag == 2)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
                [btn addTarget:self action:@selector(deleteImg3) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:[UIImage imageNamed:@"btn_del"] forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkImg3)];
                [imageView addGestureRecognizer:singleTap];
            }
            

            [_textOrderView addSubview:imageView];
        }else
        {
            UIImage *img = [_imgsArray objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+75*i+15*i, 140, 75, 75)];
            imageView.tag = i;
            [imageView setImage:img];
            if (imageView.tag == 0)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
                [btn addTarget:self action:@selector(deleteImg1) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:[UIImage imageNamed:@"btn_del"] forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkImg1)];
                [imageView addGestureRecognizer:singleTap];
            }else if (imageView.tag == 1)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
                [btn addTarget:self action:@selector(deleteImg2) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:[UIImage imageNamed:@"btn_del"] forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkImg2)];
                [imageView addGestureRecognizer:singleTap];
            }else if (imageView.tag == 2)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
                [btn addTarget:self action:@selector(deleteImg3) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:[UIImage imageNamed:@"btn_del"] forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkImg3)];
                [imageView addGestureRecognizer:singleTap];
            }
            

            [_voiceOrderView addSubview:imageView];
        }
        
    }
    if (_publishType == OrderPublishType_TxtOrder) {
        [UIView animateWithDuration:0.3 animations:^{
            _textOrderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 285);
            _demandTextView.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 100);
        } completion: ^(BOOL finish){
            
        }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _voiceOrderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 230);
            _demandTextView.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 100);
        } completion: ^(BOOL finish){
            
        }];
    }
}


//上传的图片放大和删除
- (void)checkImg1
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    for (int i = 0; i<_imgsArray.count; i++) {
        UIImage *image = [_imgsArray objectAtIndex:i];
        image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
        [tempArray addObject:image];
    }

    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:tempArray AndType:1];
    ib.currentIndex = 0;
    [ib show];
}
- (void)checkImg2
{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    for (int i = 0; i<_imgsArray.count; i++) {
        UIImage *image = [_imgsArray objectAtIndex:i];
        image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
        [tempArray addObject:image];
    }
    
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:tempArray AndType:1];
    ib.currentIndex = 1;
    [ib show];
}
- (void)checkImg3
{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    for (int i = 0; i<_imgsArray.count; i++) {
        UIImage *image = [_imgsArray objectAtIndex:i];
        image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
        [tempArray addObject:image];
    }
    
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:tempArray AndType:1];
    ib.currentIndex = 2;
    [ib show];
}
- (void)deleteImg1
{
    [_imgsArray removeObjectAtIndex:0];
    [_publishTableView reloadData];
    
}

- (void)deleteImg2
{
    [_imgsArray removeObjectAtIndex:1];
    [_publishTableView reloadData];
}

- (void)deleteImg3
{
    [_imgsArray removeObjectAtIndex:2];
    [_publishTableView reloadData];
}

//导航栏左右侧按钮点击

- (void)leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [self.demandTextView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.demandTextView.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeLabel.hidden=NO;//隐藏文字
        }else{
            _placeLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.demandTextView.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                _placeLabel.hidden=NO;
            }else{//不是删除
                _placeLabel.hidden=YES;
            }
        }else{//长度不为1时候
            _placeLabel.hidden=YES;
        }
    }
    return YES;
}

#pragma mark - 生成文件路径
- (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];;
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:_fileName]
                                stringByAppendingPathExtension:_type]
                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
}

#pragma mark - 生成当前时间字符串
- (NSString*)GetCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

- (NSString*) uniqueString
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

///获取图片类型
- (NSString *)typeForImageData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
    }
    
    return nil;
    
}
@end
