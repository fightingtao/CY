//
//  CustomerHomeViewController.m
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CustomerHomeViewController.h"

#import "MicrophonePushViewController.h"
#import "CHomeOrderTableViewCell.h"
#import "CHomeOrderIngTableViewCell.h"
#import "CHomeCommentTableViewCell.h"

#import "COrderDynamicViewController.h"
#import "PublishOrderViewController.h"
#import "ChooseBrokerViewController.h"
#import "COrderDetailViewController.h"
#import "LoginViewController.h"
#import "CustomerInfoViewController.h"

#import "COrderPayTypeChooseViewController.h"

#import "CustomerCommentViewController.h"


#import "OrderFeesChooseViewController.h"

#import "BtnAndLabelView.h"

#import "NetWorkFailedViewController.h"
#import "AdvertiseViewController.h"
#import "CommentViewController.h"

#import "YuEZhiFuViewController.h"

@interface CustomerHomeViewController ()<CHomeOrderDelegate,OrderIngCellDelegate,ChooseBrokerCompleteDelegate,OrderFeesChooseDelegate,BtnAndLableDelegate,PaySuccessBackDelegate,CommentSuccessDelegate,NetWorkReloadDelegate>
{
    NSTimer *timer;//录音时检测音量大小定时器
    
    NSString *_cityName;
    NSString *_lastDate;
    NSString *_lastorderid;
    
    NSMutableArray *_orderListArray;//列表
    
    ///呼单中类型
    int _orderIngType;
    
    ///评论类型
    int _commentType;

}

@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) AdAnimationView *adAnimationView;//滚动广告
@property (nonatomic, strong) CustomerHeadView *cHeadView;//雇主headview
@property (nonatomic, strong) CustomerButtomView *cButtomView;//雇主buttomview


@property (strong, nonatomic)   AVAudioRecorder  *recorder;
@property (strong, nonatomic)   AVAudioPlayer    *player;
@property (strong, nonatomic)   NSString         *recordFileName;
@property (strong, nonatomic)   NSString         *recordFilePath;

@property (nonatomic, strong) UIView *mainView;//广告背景图
@property (nonatomic, strong) UIView *maskView;//背景view
@property (strong, nonatomic) MicrophonePushViewController *microPhoneVC;

@property (nonatomic, strong) OrderFeesChooseViewController *feesChooseVC;

@property (nonatomic, strong) NetWorkFailedViewController *netWorkFailedVC;

@property (nonatomic, strong) BtnAndLabelView   *meishiBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *yinpinBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *chaoshiBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *xianhuaBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *maicaiBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *maiyaoBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *banshiBtnLab;
@property (nonatomic, strong) BtnAndLabelView   *songhuoBtnLab;


@end

@implementation CustomerHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteBgColor;
    
    //头部banner及tip初始化
    if (!_ctipView) {
//        _ctipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 285+285)];
        _ctipView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 285)];

        _ctipView.backgroundColor = WhiteBgColor;
    }

    //----------------------------------------------------------------
    if (!_meishiBtnLab) {
        _meishiBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH/4, 175/2)];
        [_meishiBtnLab setImgWith:[UIImage imageNamed:@"food"] WithTitle:@"美食"];
        _meishiBtnLab.tag = MenuSelect_Meishi;
        _meishiBtnLab.delegate = self;
        [_ctipView addSubview:_meishiBtnLab];
    }
    
    if (!_yinpinBtnLab) {
        _yinpinBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 90, SCREEN_WIDTH/4, 175/2)];
        [_yinpinBtnLab setImgWith:[UIImage imageNamed:@"drink"] WithTitle:@"饮品"];
        _yinpinBtnLab.tag = MenuSelect_Yinpin;
        _yinpinBtnLab.delegate = self;
        [_ctipView addSubview:_yinpinBtnLab];
    }
    
    if (!_chaoshiBtnLab) {
        _chaoshiBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, 90, SCREEN_WIDTH/4, 175/2)];
        [_chaoshiBtnLab setImgWith:[UIImage imageNamed:@"supermarket"] WithTitle:@"超市"];
        _chaoshiBtnLab.tag = MenuSelect_Chaoshi;
        _chaoshiBtnLab.delegate = self;
        [_ctipView addSubview:_chaoshiBtnLab];
    }
    
    if (!_xianhuaBtnLab) {
        _xianhuaBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 90, SCREEN_WIDTH/4, 175/2)];
        [_xianhuaBtnLab setImgWith:[UIImage imageNamed:@"flower"] WithTitle:@"鲜花"];
        _xianhuaBtnLab.tag = MenuSelect_Xianhua;
        _xianhuaBtnLab.delegate = self;
        [_ctipView addSubview:_xianhuaBtnLab];
    }
    
    if (!_maicaiBtnLab) {
        _maicaiBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(0, 90+175/2, SCREEN_WIDTH/4, 175/2)];
        [_maicaiBtnLab setImgWith:[UIImage imageNamed:@"vegetables"] WithTitle:@"买菜"];
        _maicaiBtnLab.tag = MenuSelect_Maicai;
        _maicaiBtnLab.delegate = self;
        [_ctipView addSubview:_maicaiBtnLab];
    }
    
    if (!_maiyaoBtnLab) {
        _maiyaoBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 90+175/2, SCREEN_WIDTH/4, 175/2)];
        [_maiyaoBtnLab setImgWith:[UIImage imageNamed:@"medicine"] WithTitle:@"买药"];
        _maiyaoBtnLab.tag = MenuSelect_Maiyao;
        _maiyaoBtnLab.delegate = self;
        [_ctipView addSubview:_maiyaoBtnLab];
    }
    
    if (!_banshiBtnLab) {
        _banshiBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, 90+175/2, SCREEN_WIDTH/4, 175/2)];
        [_banshiBtnLab setImgWith:[UIImage imageNamed:@"things"] WithTitle:@"办事"];
        _banshiBtnLab.tag = MenuSelect_Banshi;
        _banshiBtnLab.delegate = self;
        [_ctipView addSubview:_banshiBtnLab];
    }
    
    if (!_songhuoBtnLab) {
        _songhuoBtnLab = [[BtnAndLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 90+175/2, SCREEN_WIDTH/4, 175/2)];
        [_songhuoBtnLab setImgWith:[UIImage imageNamed:@"-parcel"] WithTitle:@"送货"];
        _songhuoBtnLab.tag = MenuSelect_Songhuo;
        _songhuoBtnLab.delegate = self;
        [_ctipView addSubview:_songhuoBtnLab];
    }
    
    //----------------------------------------------------------------
    
    if (!_cTipLabel) {
        _cTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 265, SCREEN_WIDTH, 20)];
        _cTipLabel.backgroundColor = ViewBgColor;
        _cTipLabel.font = [UIFont systemFontOfSize:11];
        _cTipLabel.textColor = TextDetailCOLOR;
        _cTipLabel.text = @"附近有超过500个经纪人可提供服务";
        _cTipLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _cTipLabel.textAlignment = NSTextAlignmentCenter;
        [_ctipView addSubview:_cTipLabel];
    }
    
    //初始化滚动广告
    if (!_adAnimationView) {
        _adAnimationView = [[AdAnimationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        _adAnimationView.delegate = self;
        [_ctipView addSubview:_adAnimationView];
    }
    
    //[self.view addSubview:_ctipView];
    
    //此为默认加载
    AdAniMationModel *model = [[AdAniMationModel alloc] init];
    model.pic_path = @"";
    NSArray *imgArray = [[NSArray alloc] initWithObjects:model, nil];
    [_adAnimationView refreshShowWith:imgArray];

    //初始化雇主headview
    [self initcheadView];
    [self.view addSubview:_cHeadView];
    //初始化tableview
    [self inithomeTableView];
    [self.view  addSubview:_homeTableView];
    //添加刷新控件
    [self.homeTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.homeTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    _ctype = CFuncType_List;//默认呼单圈
    
    [self initcbuttomView];
    [self.view addSubview:_cButtomView];
    
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0;
    }

    if (!_microPhoneVC) {
        _microPhoneVC = [[MicrophonePushViewController alloc] init];
        _microPhoneVC.view.frame = CGRectMake((SCREEN_WIDTH-200)/2,SCREEN_HEIGHT, 200, 200);
        _microPhoneVC.view.layer.cornerRadius = 10.0f;
        _microPhoneVC.view.backgroundColor = [UIColor blackColor];
    }
    
    if (!_feesChooseVC) {
        _feesChooseVC = [[OrderFeesChooseViewController alloc] init];
        _feesChooseVC.view.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH-40, 350);
        _feesChooseVC.delegate = self;
    }
//    if(!_mainView){
////        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 285)];
//        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 285)];
//        //        _homeTableView.tableHeaderView=_ctipView;
//        _ctipView.frame=CGRectMake(0,40, SCREEN_WIDTH, 285);
//        [_mainView addSubview:_ctipView];
//        _mainView.backgroundColor = WhiteBgColor;
//        _homeTableView.tableHeaderView=_ctipView;
////        [self.view addSubview:_mainView];
//    }
    
    //初始化列表获取数据
    _orderListArray = [[NSMutableArray alloc] init];
    _cityName = @"南京市";
    _lastDate = @"";
    _lastorderid = @"";
    
    [self getOrderList];
    [self getAdvertContent];
    _homeTableView.tableHeaderView=_ctipView;

    ///呼单数据初始化
    _orderIngType = 1;
    
    ///评论类型初始化
    _commentType = 1;
#pragma mark 断网时判断
    if (!_netWorkFailedVC) {
        _netWorkFailedVC = [[NetWorkFailedViewController alloc] init];
        _netWorkFailedVC.view.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
        _netWorkFailedVC.delegate = self;
    }
}

- (void)refreshtableview{
    
    [self headerRereshing];
    //[self getOrderIngList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AppDelegate*)delegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//初始化tablew
-(UITableView *)inithomeTableView
{
    if (_homeTableView != nil) {
        return _homeTableView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 64+40;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = self.view.frame.size.height-64-82;
    
    self.homeTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.backgroundColor=[UIColor redColor];
    _homeTableView.backgroundColor = ViewBgColor;
    self.automaticallyAdjustsScrollViewInsets = false;
    _homeTableView.showsVerticalScrollIndicator = NO;
    _homeTableView.scrollsToTop = YES;
    return _homeTableView;
}

//初始化雇主headview
- (UIView *)initcheadView
{
    if (_cHeadView != nil) {
        return _cHeadView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = 64.0;
    rect.size.width = self.view.frame.size.width;
    rect.size.height = 40;
    _cHeadView.backgroundColor = WhiteBgColor;
    _cHeadView = [[CustomerHeadView alloc] initWithFrame:rect];
    _cHeadView.delegate = self;
    _ctype = CFuncType_List;
    return _cHeadView;
}


//初始化雇主buttomview
- (UIView *)initcbuttomView
{
    if (_cButtomView != nil) {
        return _cButtomView;
    }
    
    CGRect rect = self.view.frame;
    rect.origin.x = 0.0;
    rect.origin.y = SCREEN_HEIGHT-44;
    rect.size.width = SCREEN_WIDTH;
    rect.size.height = 44;
    
    _cButtomView.backgroundColor = WhiteBgColor;
    _cButtomView = [[CustomerButtomView alloc] initWithFrame:rect];
    _cButtomView.delegate = self;
    return _cButtomView;}


///获取呼单圈列表
- (void)getOrderList
{
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    mbp.labelText = @"获取中...";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_HomeListModel *outModel = [[communcation sharedInstance] getHomeContentWithCity:_cityName AndLastDate:_lastDate AndOrderId:_lastorderid];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_homeTableView headerEndRefreshing];
            [_homeTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                [self.view addSubview:_netWorkFailedVC.view];
            }else if (outModel.code ==1000)
            {
                [_netWorkFailedVC.view removeFromSuperview];
                if ([_lastDate isEqualToString:@"0"]) {
                    [_orderListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        OutHomeListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [_homeTableView reloadData];
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        OutHomeListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }
                [_homeTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

///获取广告内容
- (void)getAdvertContent
{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_AdvertModel *outModel = [[communcation sharedInstance] getHomeAdvertWithCity:_cityName];
        dispatch_async(dispatch_get_main_queue(), ^{

            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [_netWorkFailedVC.view removeFromSuperview];
                _cTipLabel.text = [NSString stringWithFormat:@"附近有超过%d个经纪人可提供服务",outModel.data.brokerCount];

                if (outModel.data.adverts.count == 0) {
                    return ;
                }
                [_adAnimationView refreshShowWith:outModel.data.adverts];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

#pragma mark  获取呼单列表信息
- (void)getOrderIngList
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (!userInfoModel.key||userInfoModel.key.length==0){
        
        return;
    }
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,@"0",[NSString stringWithFormat:@"%d",_orderIngType],_lastDate,_lastorderid, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
//    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    mbp.labelText = @"获取中...";
    In_OrderIngListModel *inModel = [[In_OrderIngListModel alloc] init];
    inModel.key = userInfoModel.userId;
    inModel.digest = hamcString;
    inModel.userId = userInfoModel.userId;
    inModel.usertype = @"0";
    inModel.type = [NSString stringWithFormat:@"%d",_orderIngType];
    inModel.lastDate = _lastDate;
    inModel.lastorderid = _lastorderid;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderIngListModel *outModel = [[communcation sharedInstance] getOrderIngListWithModel:inModel];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_homeTableView headerEndRefreshing];
            [_homeTableView footerEndRefreshing];
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [_netWorkFailedVC.view removeFromSuperview];
                if ([_lastDate isEqualToString:@"0"]) {
                    [_orderListArray removeAllObjects];
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }else
                {
                    if (outModel.data.count == 0) {
                        [[iToast makeText:@"没有啦！全部出来了!"] show];
                        return ;
                    }
                    for (int i = 0; i < outModel.data.count; i++) {
                        Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                        [_orderListArray addObject:model];
                    }
                }
                [_homeTableView reloadData];
            }else{
                [[iToast makeText:outModel.message] show];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles: nil];
                alert.tag=200;
                [alert show];
            }
        });
        
    });

}

///获取评论列表
- (void)getCommentList
{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,[NSString stringWithFormat:@"%d",_commentType],_lastDate,_lastorderid, nil];
        NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"获取中...";
        In_CommentListModel *inModel = [[In_CommentListModel alloc] init];
        inModel.key = userInfoModel.userId;
        inModel.digest = hamcString;
        inModel.user_id = userInfoModel.userId;
        inModel.type = _commentType;
        inModel.lastDate = [_lastDate longLongValue];
        inModel.lastrowid = [_lastorderid longLongValue];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_CommentListModel *outModel = [[communcation sharedInstance] getCommentListWithModel:inModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [_homeTableView headerEndRefreshing];
                [_homeTableView footerEndRefreshing];
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
    
                }else if (outModel.code ==1000)
                {
                    [_netWorkFailedVC.view removeFromSuperview];
                    if ([_lastDate isEqualToString:@"0"]) {
                        [_orderListArray removeAllObjects];
                        for (int i = 0; i < outModel.data.count; i++) {
                            Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                            [_orderListArray addObject:model];
                        }
                    }else
                    {
                        if (outModel.data.count == 0) {
                            [[iToast makeText:@"没有啦！全部出来了!"] show];
                            return ;
                        }
                        for (int i = 0; i < outModel.data.count; i++) {
                            Out_OrderIngListBody *model = [outModel.data objectAtIndex:i];
                            [_orderListArray addObject:model];
                        }
                    }
                    [_homeTableView reloadData];
                }else{
                    [[iToast makeText:outModel.message] show];
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户提示" message:@"登录超时,请重新登录" delegate:self cancelButtonTitle:@"去登陆" otherButtonTitles: nil];
                    alert.tag=200;
                    [alert show];
                }
            });
            
        });

}

///网络错误刷新
- (void)netWorkReload
{
    [self headerRereshing];
}

#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    switch (_ctype) {
        case CFuncType_List:
        {
           
            return [_orderListArray count];
        }
        case CFuncType_Work:
        {
         
            return [_orderListArray count];
        }
        case CFuncType_Comment:
        {
            return [_orderListArray count];
        }
        default:
            return 0;
    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_ctype) {
        case CFuncType_List:
        {
            OutHomeListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            return [CHomeOrderTableViewCell cellHeightWithModel:model];
        }
        case CFuncType_Work:
        {
            Out_OrderIngListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            return [CHomeOrderIngTableViewCell cellHeightWithModel:model];
        }
        case CFuncType_Comment:
        {
            return [CHomeCommentTableViewCell cellHeightWithModel:@"测试"];
        }
        default:
            return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_ctype) {
        case CFuncType_List:
        {
                        
            static NSString *identCell = @"CHomeOrderTableViewCell";
            CHomeOrderTableViewCell *cell = [[CHomeOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
            
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            OutHomeListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            [cell setOrderContentWithModel:model];
            return cell;
        }
        case CFuncType_Work:
        {
            static NSString *identCell = @"CHomeOrderIngTableViewCell";
            CHomeOrderIngTableViewCell *cell = [[CHomeOrderIngTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
            Out_OrderIngListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            [cell setOrderContentWithModel:model];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case CFuncType_Comment:
        {
            static NSString *cellName = @"CHomeCommentTableViewCell";
            CHomeCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[CHomeCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            Out_CommentListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            [cell setOrderContentWithModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default:
            return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (_ctype == CFuncType_List) {
        
        if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
        {
            OutHomeListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            COrderDynamicViewController *orderDynamicVC = [[COrderDynamicViewController alloc] init];
            orderDynamicVC.orderId = model.orderId;
            orderDynamicVC.isGetOrder = NO;
            [app.menuViewController pushToNewViewController:orderDynamicVC animation:YES];
        }else{
            [[iToast makeText:@"请先登录!"]show];
        }
        
    }else if (_ctype == CFuncType_Work)
    {
        if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
        {
            Out_OrderIngListBody *model = [_orderListArray objectAtIndex:indexPath.section];
            COrderDetailViewController *orderDetailVC = [[COrderDetailViewController alloc] init];
            orderDetailVC.delegate = self;
            [app.menuViewController pushToNewViewController:orderDetailVC animation:YES];
            //判断状态和传入orderid
            if (model.statusId >= 3)
            {
                orderDetailVC.nowStatus = OrderStatus_YJD;
            }else
            {
                orderDetailVC.nowStatus = OrderStatus_WJD;
            }
            
            orderDetailVC.orderId = model.orderId;
            
            [orderDetailVC getOrderDetail];
            
        }else{
            [[iToast makeText:@"请先登录!"]show];
        }

    }else if (_ctype == CFuncType_Comment)
    {
        
    }
}


//顶部刷新和底部刷新
- (void)headerRereshing
{
    switch (_ctype) {
        case CFuncType_List:
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            [self getOrderList];
            [self getAdvertContent];
            return;
        }
        case CFuncType_Work:
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            [self getOrderIngList];
            return;
        }
        case CFuncType_Comment:
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            [self getCommentList];
            return;
        }
        default:
            return;
    }
    
}

- (void)footerRereshing
{
    switch (_ctype) {
        case CFuncType_List:
        {
            if ([_orderListArray count] != 0) {
                OutHomeListBody *model = [_orderListArray objectAtIndex:[_orderListArray count]-1];
                _lastDate = [NSString stringWithFormat:@"%ld",model.createTime];
                _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
                [self getOrderList];
            }else
            {
                [[iToast makeText:@"暂无数据"] show];
                [_homeTableView footerEndRefreshing];
            }
            return;
        }
        case CFuncType_Work:
        {
            if ([_orderListArray count] != 0) {
                Out_OrderIngListBody *model = [_orderListArray objectAtIndex:[_orderListArray count]-1];
                _lastDate = [NSString stringWithFormat:@"%@",model.createTime];
                _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
                [self getOrderIngList];
            }else
            {
                [[iToast makeText:@"暂无数据"] show];
                [_homeTableView footerEndRefreshing];
            }
            return;
        }
        case CFuncType_Comment:
        {
            if ([_orderListArray count] != 0) {
                Out_CommentListBody *model = [_orderListArray objectAtIndex:[_orderListArray count]-1];
                _lastDate = [NSString stringWithFormat:@"%ld",model.create_date];
                _lastorderid = [NSString stringWithFormat:@"%ld",model.row_id];
                [self getCommentList];
            }else
            {
                [[iToast makeText:@"暂无数据"] show];
                [_homeTableView footerEndRefreshing];
            }
            return;
        }
        default:
            return;
    }
    
}
//-------------------------------------------------------------

#pragma BtnAndLableDelegate 八类点击事件代理
- (void)btnAndLabelClicked:(BtnAndLabelView *)selectView
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        //发布文字需求
        PublishOrderViewController *publishOrderVC = [[PublishOrderViewController alloc] init];
        publishOrderVC.publishType = OrderPublishType_TxtOrder;
        [[self delegate].menuViewController pushToNewViewController:publishOrderVC animation:YES];
        
        OutTypeBody *tempTypeModel = [[OutTypeBody alloc] init];
        /// 1 代办 2 代购 3代送
        switch (selectView.tag) {
            case MenuSelect_Meishi:
            {
                publishOrderVC.placeString = @"在此输入您想要吃的美食";
                tempTypeModel.type_name = @"代购";
                tempTypeModel.typeId = 2;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Yinpin:
            {
                publishOrderVC.placeString = @"在此输入您想要喝的饮品";
                tempTypeModel.type_name = @"代购";
                tempTypeModel.typeId = 2;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Chaoshi:
            {
                publishOrderVC.placeString = @"在此输入您想要在超市购买的商品";
                tempTypeModel.type_name = @"代购";
                tempTypeModel.typeId = 2;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Xianhua:
            {
                publishOrderVC.placeString = @"在此输入您想要购买的鲜花";
                tempTypeModel.type_name = @"代购";
                tempTypeModel.typeId = 2;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Maicai:
            {
                publishOrderVC.placeString = @"在此输入您想要在菜场买的菜";
                tempTypeModel.type_name = @"代购";
                tempTypeModel.typeId = 2;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Maiyao:
            {
                publishOrderVC.placeString = @"在此输入您想要在药店买的药";
                tempTypeModel.type_name = @"代购";
                tempTypeModel.typeId = 2;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Banshi:
            {
                publishOrderVC.placeString = @"在此输入您想要办的事情";
                tempTypeModel.type_name = @"代办";
                tempTypeModel.typeId = 1;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            case MenuSelect_Songhuo:
            {
                publishOrderVC.placeString = @"在此输入您想要送的物品";
                tempTypeModel.type_name = @"代送";
                tempTypeModel.typeId = 3;
                publishOrderVC.tempDefaultType = tempTypeModel;
            }
                break;
            default:
                break;
        }

    }else{
        
        [[iToast makeText:@"您还没有登录,快去登录!"] show];
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"您还没有登录,快去登录!" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//        alertView.tag=100;
//        alertView .delegate=self;
//        [alertView show];
//        return;
    }
}


//-------------------------------------------------------------
#pragma CustomerHeadDelegate 雇主头部view点击事件代理
///选择呼单圈
- (void)headOrderListClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _cHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        _homeTableView.frame = CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-148);
        
        _homeTableView.tableHeaderView=_ctipView;
        _cButtomView.frame = CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44);
        _cHeadView.line.frame = CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5);
    } completion: ^(BOOL finish){
        _ctype = CFuncType_List;
        _lastDate = @"0";
        _lastorderid = @"0";
        
        [self getOrderList];
        [self getAdvertContent];
    }];
}

///选择呼单中
- (void)headOrderWorkClick
{
    
    _homeTableView.tableHeaderView=nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        [UIView animateWithDuration:0.3 animations:^{
            _cHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
            _homeTableView.frame = CGRectMake(0, 144, SCREEN_WIDTH, SCREEN_HEIGHT-144);
         
            _cButtomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44);
            _cHeadView.line.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
            
            //主菜单处理
            [_cHeadView.orderListBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            [_cHeadView.orderWorkBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            [_cHeadView.commentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            
        } completion: ^(BOOL finish){
            _ctype = CFuncType_Work;
            _lastDate = @"0";
            _lastorderid = @"0";
            _orderIngType = 1;
            [self getOrderIngList];
        }];
    }else
    {
        [[iToast makeText:@"请先登录!"] show];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"暂未登录，先登录吧" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alertView.delegate=self;
        alertView.tag=100;
        [alertView show];
        return;
    }
}
#pragma mark alert方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        if (alertView.tag==200) {
            [self goLogin];
        }
    }
}
//进入登陆界面
- (void)goLogin
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [delegate.menuViewController pushToNewViewController:loginVC animation:YES];
}
///选择呼单评价
- (void)headOrderCommentClick
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        [UIView animateWithDuration:0.3 animations:^{
            _cHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
            _homeTableView.frame = CGRectMake(0, 144, SCREEN_WIDTH, SCREEN_HEIGHT-144);
//            _homeTableView.frame = CGRectMake(0,64+80+285, SCREEN_WIDTH, SCREEN_HEIGHT-64+80+285);
            _homeTableView.tableHeaderView=nil;

//            _ctipView.frame = CGRectMake(0, 64+79.5, SCREEN_WIDTH, 285);
            _cButtomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44);
            _cHeadView.line.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
            
            //主菜单处理
            [_cHeadView.orderListBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            [_cHeadView.orderWorkBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            [_cHeadView.commentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            
        } completion: ^(BOOL finish){
            _ctype = CFuncType_Comment;
            _lastDate = @"0";
            _lastorderid = @"0";
            _orderIngType = 1;
            [self getCommentList];
        }];
    }else
    {
        [[iToast makeText:@"请先登录!"] show];
    }

    
    
}

///子菜单功能处理
-(void)cDetailFuncClick:(CDetailFuncType)type
{
    
    switch (type) {
        case CDetailFuncType_Order://子菜单功能类型-呼单中
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _orderIngType = 1;
            [self getOrderIngList];
            return;
        }
        case CDetailFuncType_History://子菜单功能类型-呼单历史
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _orderIngType = 2;
            [self getOrderIngList];
            return;
        }
        case CDetailFuncType_ToBrokerComment://子菜单功能类型-我对经纪人评价
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _commentType = 1;
            [self getCommentList];
            return;
        }
        case CDetailFuncType_ToUserComment://子菜单功能类型-经纪人对我评价
        {
            _lastDate = @"0";
            _lastorderid = @"0";
            _commentType = 2;
            [self getCommentList];
            return;
        }
        default:
            return;
    }

}

#pragma CHomeOrderDelegate 呼单圈事件代理
///呼单圈中用户头头像点击代理实现
- (void)headImgClickWithModel:( OutHomeListBody*)model
{
    
    CustomerInfoViewController *customerInfoVC = [[CustomerInfoViewController alloc] init];
    customerInfoVC.userId = model.userId;
    customerInfoVC.commentType = 2;
    [[self delegate].menuViewController pushToNewViewController:customerInfoVC animation:YES];
}

///展示呼单圈中呼单图片代理实现
- (void)showOrderImgWithModel:(OutHomeListBody *)model AndIndex:(int)index
{
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:model.picpaths AndType:0];
    ib.currentIndex = index;
    [ib show];
}

///播放语音内容代理实现
- (void)playOrderVoiceWithModel:(OutHomeListBody *)model
{
        NSURL *url=[NSURL URLWithString:model.voicePath];
        NSData *audioData = [NSData dataWithContentsOfURL:url];
    
        //根据当前时间生成文件名
        NSString *tempFileName = [self GetCurrentTimeString];
        //获取路径
        NSString *tempRecordFilePath = [self GetPathByFileName:tempFileName ofType:@"amr"];
        [audioData writeToFile:tempRecordFilePath atomically:YES];
        NSString *convertedPath = [self GetPathByFileName:[tempFileName stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
        if ([VoiceConverter ConvertAmrToWav:tempRecordFilePath wavSavePath:convertedPath]==1) {
            self.player = [[AVAudioPlayer alloc]init];
            [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
            [[AVAudioSession sharedInstance] setActive:YES error:nil];
            self.player = [self.player initWithContentsOfURL:[NSURL URLWithString:convertedPath] error:nil];
            [self.player play];
        }else
            [[iToast makeText:@"改语音不能识别并播放1"] show];
}

///订单点赞代理实现
- (void)praiseOrderWithModel:(OutHomeListBody *)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:userInfoModel.userId,model.orderId, nil];
    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_OrderPraiseModel *outModel = [[communcation sharedInstance] orderPraiseWithKey:userInfoModel.key AndDigest:hamcString AndOrderId:model.orderId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                if (outModel.data.zan_flag == 0) {
                    [[iToast makeText:@"取消点赞!"] show];
                }else
                {
                    [[iToast makeText:@"已经点赞!"] show];
                }
                [self headerRereshing];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}


///订单评论代理实现
- (void)commentOrderWithModel:(OutHomeListBody *)model
{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSData *userData = [userDefault objectForKey:UserKey];
//    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//
//    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
//    {
//        COrderDynamicViewController *orderDynamicVC = [[COrderDynamicViewController alloc] init];
//       orderDynamicVC.orderId = model.orderId;
//        orderDynamicVC.isGetOrder = NO;
//        [[self delegate].menuViewController pushToNewViewController:orderDynamicVC animation:YES];
//        [orderDynamicVC commentFromList];
        
        CommentViewController *comment = [[CommentViewController alloc]init];
        comment.model = model;
        [comment.demandTextView becomeFirstResponder];
        [[self delegate].menuViewController pushToNewViewController:comment animation:YES];
        
//    }else
//    {
//        [[iToast makeText:@"您还没有登录,快去登录!"] show];
//        return;
//    }
    

}
//-------------------------------------------------------------
#pragma OrderIngCellDelegate 呼单中和历史订单事件代理
///选择经纪人代理实现
- (void)chooseBrokerWithModel:(Out_OrderIngListBody*)model
{

    ChooseBrokerViewController *chooseBrokerVC = [[ChooseBrokerViewController alloc] init];
    chooseBrokerVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chooseBrokerVC];
    [[self delegate].menuViewController presentViewController:nav animated:YES completion:^{
        //获取经纪人列表
        [chooseBrokerVC getBrokerListWithOrderId:model.orderId];
    }];
}

///完成选择经纪人代理实现
- (void)completeAndRefresh
{
    _lastDate = @"0";
    _lastorderid = @"0";
    [self getOrderIngList];
}



///确认购买代理实现
- (void)orderIngConfirmOrderWithModel:(Out_OrderIngListBody*)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"加载中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString *hamcString = [[communcation sharedInstance] hmac:model.orderId withKey:userInfoModel.primaryKey];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CustomerConfirmOrderModel *outModel = [[communcation sharedInstance] CustomerConfirmOrderWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:model.orderId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已确认订单完成，快去支付吧!"] show];
                [self headerRereshing];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });
}

///立即付款代理实现
- (void)orderIngPayOrderWithModel:(Out_OrderIngListBody*)model
{
    COrderPayTypeChooseViewController *payTypeChooseVC = [[COrderPayTypeChooseViewController alloc] init];
    payTypeChooseVC.delegate = self;
    [[self delegate].menuViewController pushToNewViewController:payTypeChooseVC animation:YES];
    payTypeChooseVC.orderId = model.orderId;
    payTypeChooseVC.orderType = model.orderTypeId;
    [payTypeChooseVC getOrderPayDetail];
}

#pragma PaySuccessBackDelegate 支付完成代理
- (void)paySuccessBackRefresh
{
////    [self headerRereshing];
////    [self headOrderWorkClick];
    [self getOrderIngList];
//    
    //[_homeTableView reloadData];
    
}

///评价雇主代理实现
- (void)orderIngCommentCustomerWithModel:(Out_OrderIngListBody*)model
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CustomerCommentViewController *commentVC = [[CustomerCommentViewController alloc] init];
    commentVC.type = @"1";
    commentVC.orderId = model.orderId;
    commentVC.delegate = self;
    [app.menuViewController pushToNewViewController:commentVC animation:YES];
    
}
#pragma CommentSuccessDelegate 评论成功刷新
- (void)commentSuccessBackRefresh
{
    [self headerRereshing];
}



///展示订单图片代理实现
- (void)orderIngshowOrderImgWithModel:(Out_OrderIngListBody *)model AndIndex:(int)index
{
    ImgBrowser *ib = [[ImgBrowser alloc]init];
    [ib setImgaeArray:model.picpaths AndType:0];
    ib.currentIndex = index;
    [ib show];
}
///播放语音内容代理实现
- (void)orderIngplayOrderVoiceWithModel:(Out_OrderIngListBody*)model
{
    NSURL *url=[NSURL URLWithString:model.voicePath];
    NSData *audioData = [NSData dataWithContentsOfURL:url];
    
    //根据当前时间生成文件名
    NSString *tempFileName = [self GetCurrentTimeString];
    //获取路径
    NSString *tempRecordFilePath = [self GetPathByFileName:tempFileName ofType:@"amr"];
    [audioData writeToFile:tempRecordFilePath atomically:YES];
    NSString *convertedPath = [self GetPathByFileName:[tempFileName stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
    if ([VoiceConverter ConvertAmrToWav:tempRecordFilePath wavSavePath:convertedPath]==1) {
        self.player = [[AVAudioPlayer alloc]init];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        self.player = [self.player initWithContentsOfURL:[NSURL URLWithString:convertedPath] error:nil];
        [self.player play];
    }else
        [[iToast makeText:@"改语音不能识别并播放1"] show];
}

///拨打电话代理实现
- (void)callBrokerWithModel:(Out_OrderIngListBody *)model
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.bTelephone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

///取消呼单代理实现
- (void)orderIngCancelOrderWithModel:(Out_OrderIngListBody*)model
{
    MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbp.labelText = @"取消呼单中";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *hamcString = [[communcation sharedInstance] hmac:model.orderId withKey:userInfoModel.primaryKey];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Out_CancelOrderBeforeModel *outModel = [[communcation sharedInstance] cancelOrderBeforeWithWithKey:userInfoModel.userId AndDigest:hamcString AndOrderId:model.orderId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (!outModel)
            {
                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                
            }else if (outModel.code ==1000)
            {
                [[iToast makeText:@"您已取消该呼单!"] show];
                [self headerRereshing];
            }else{
                [[iToast makeText:outModel.message] show];
            }
        });
        
    });

}

///追加小费代理实现
- (void)orderIngMoreTipsWithModel:(Out_OrderIngListBody*)model
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:_maskView];
    [window addSubview:_feesChooseVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _maskView.alpha = 0.7;
        _feesChooseVC.view.frame = CGRectMake(20, (SCREEN_HEIGHT-350)/2, SCREEN_WIDTH-40, 350);
        _feesChooseVC.tempOrderId = model.orderId;
        
    } completion: ^(BOOL finish){
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
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.labelText = @"追加小费中...";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefault objectForKey:UserKey];
        UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        NSArray *dataArray = [[NSArray alloc] initWithObjects:_feesChooseVC.tempOrderId,[NSString stringWithFormat:@"%d",model.tipid], nil];
        NSString *hmacString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            Out_AllSameModel *outModel = [[communcation sharedInstance] addMoreTipsWithKey:userInfoModel.userId AndDigest:hmacString AndOrderId:_feesChooseVC.tempOrderId AndTipsId:model.tipid];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!outModel)
                {
                    [[iToast makeText:@"网络不给力,请稍后重试!"] show];
                    
                }else if (outModel.code ==1000)
                {
                    [[iToast makeText:@"您已追加小费!"] show];
                    [self headerRereshing];
                }else{
                    [[iToast makeText:outModel.message] show];
                }
            });
            
        });

        
    }];
}

//-------------------------------------------------------------

#pragma PublishDemandDelegate 发布需求事件代理
- (void)publishTextDemand
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        //发布文字需求
        PublishOrderViewController *publishOrderVC = [[PublishOrderViewController alloc] init];
        publishOrderVC.publishType = OrderPublishType_TxtOrder;
        [[self delegate].menuViewController pushToNewViewController:publishOrderVC animation:YES];
        publishOrderVC.placeString = @"你可以输入对需求的描述：例如买什么东西，办什么事情、需要送什么东西。";
        
    }else
    {
        [[iToast makeText:@"您还没有登录,快去登录!"] show];
        return;
    }

    
}
- (void)startVoiceDemand
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {

    }else
    {
        [[iToast makeText:@"您还没有登录,快去登录!"] show];
        return;
    }
    
    [self.view addSubview:_maskView];
    [self.view addSubview:_microPhoneVC.view];
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0.5;
        _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44);
        _microPhoneVC.view.frame = CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-200)/2, 200, 200);
        _microPhoneVC.view.alpha = 0.6;
    } completion: ^(BOOL finish){
    }];

    //根据当前时间生成文件名
    self.recordFileName = [self GetCurrentTimeString];
//    NSLog(@"recordfilename>>>>>>>>%@",self.recordFileName);
    
    //获取路径
    self.recordFilePath = [self GetPathByFileName:self.recordFileName ofType:@"wav"];
    
    //初始化录音
    self.recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:self.recordFilePath] settings:[VoiceConverter GetAudioRecorderSettingDict] error:nil];
    
    // 允许测量
    self.recorder.meteringEnabled = YES;
    
    //准备录音
    if ([self.recorder prepareToRecord]){
        
        // AVAudioSessionCategoryPlayAndRecord 用于播放和录音
        // 是否允许访问麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        // 也可以这样写
        // [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
        // [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [self.recorder record];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    }

}

- (void)endVoiceDemand
{
    //结束语音 录音准备发布
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefault objectForKey:UserKey];
    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (userInfoModel&&userInfoModel.userId&&![userInfoModel.userId isEqualToString:@""])
    {
        
    }else
    {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _microPhoneVC.view.frame = CGRectMake((SCREEN_WIDTH-200)/2,SCREEN_HEIGHT, 200, 200);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_microPhoneVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
    
    //
    [timer invalidate];
    
    double cTime = self.recorder.currentTime;
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    //停止录音
    [self.recorder stop];
    
    //开始转换格式
    
    NSDate *date = [NSDate date];
    NSString *amrPath = [self GetPathByFileName:self.recordFileName ofType:@"amr"];
    
//wav转amr
    if ([VoiceConverter ConvertWavToAmr:self.recordFilePath amrSavePath:amrPath]){
        
        date = [NSDate date];
        NSString *convertedPath = [self GetPathByFileName:[self.recordFileName stringByAppendingString:@"_AmrToWav"] ofType:@"wav"];
        
//amr转wav
        if ([VoiceConverter ConvertAmrToWav:amrPath wavSavePath:convertedPath]){
            
        }else{
            
        }
//            NSLog(@"amr转wav失败");
        
        
    }else
//        NSLog(@"wav转amr失败");
    
    if (cTime < 3)
    {
        [[iToast makeText:@"您的说话时间太短，请重说！"] show];
        
    }else
    {
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        PublishOrderViewController *publishOrderVC = [[PublishOrderViewController alloc] init];
        publishOrderVC.voicePath = amrPath;
        publishOrderVC.voiceTime = cTime;
        publishOrderVC.publishType = OrderPublishType_VoiceOrder;
        [app.menuViewController pushToNewViewController:publishOrderVC animation:YES];
    }

}

- (void)cancelVoiceDemand
{
    
    //取消语音录音
    [UIView animateWithDuration:0.3 animations:^{
        _microPhoneVC.view.frame = CGRectMake((SCREEN_WIDTH-200)/2,SCREEN_HEIGHT, 200, 200);
        _maskView.alpha = 0;
    } completion: ^(BOOL finish){
        [_microPhoneVC.view removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
    
    //删除录制文件
    if ([self.recorder isRecording])
    {
        [self.recorder stop];
        [self.recorder deleteRecording];
        [timer invalidate];
        [[iToast makeText:@"已取消语音录制"] show];
    }else{
        return;
    }
}

#pragma AdAnimationViewDelegate 轮播图点击事件代理
- (void)adHasSelect:(AdAniMationModel *)model
{
//    NSLog(@"广告点击");
//    NSArray *imgArr = [[NSArray alloc] initWithObjects:model.pic_path, nil];
//    ImgBrowser *ib = [[ImgBrowser alloc]init];
//    [ib setImgaeArray:imgArr AndType:0];
//    ib.currentIndex = 0;
//    [ib show];
    
    if (model.type == 1){
        AdvertiseViewController *adver = [[AdvertiseViewController alloc]init];
        adver.model = model;
        [[self delegate].menuViewController pushToNewViewController:adver animation:YES];
    }
    else if (model.type == 2){
        PublishOrderViewController *publishOrderVC = [[PublishOrderViewController alloc] init];
        publishOrderVC.placeString = model.desc;
        publishOrderVC.type = model.type;
        [[self delegate].menuViewController pushToNewViewController:publishOrderVC animation:YES];
       
    }
    else if (model.type == 3){
        PublishOrderViewController *publishOrderVC = [[PublishOrderViewController alloc] init];
         publishOrderVC.placeString = model.desc;
        [[self delegate].menuViewController pushToNewViewController:publishOrderVC animation:YES];
       
    }
    else if (model.type == 4){
        AdvertiseViewController *adver = [[AdvertiseViewController alloc]init];
        adver.desc = model.desc;
        adver.Str = model.url;
        [[self delegate].menuViewController pushToNewViewController:adver animation:YES];
    }
}


#pragma mark - 生成当前时间字符串
- (NSString*)GetCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

#pragma mark - 生成文件路径
- (NSString*)GetPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileDirectory = [[[directory stringByAppendingPathComponent:_fileName] stringByAppendingPathExtension:_type] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return fileDirectory;
    
}

- (void)detectionVoice
{
   [self.recorder updateMeters]; // 刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    double lowPassResults = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
//    NSLog(@"%lf",lowPassResults);
    
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_one"]];
    }else if (0.06<lowPassResults<=0.13) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_one"]];
    }else if (0.13<lowPassResults<=0.20) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_one"]];
    }else if (0.20<lowPassResults<=0.27) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_one"]];
    }else if (0.27<lowPassResults<=0.34) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_two"]];
    }else if (0.34<lowPassResults<=0.41) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_two"]];
    }else if (0.41<lowPassResults<=0.48) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_two"]];
    }else if (0.48<lowPassResults<=0.55) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_two"]];
    }else if (0.55<lowPassResults<=0.62) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_two"]];
    }else if (0.62<lowPassResults<=0.69) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_three"]];
    }else if (0.69<lowPassResults<=0.76) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_three"]];
    }else if (0.76<lowPassResults<=0.83) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_three"]];
    }else if (0.83<lowPassResults<=0.9) {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_three"]];
    }else {
        [_microPhoneVC.microPhoneImg setImage:[UIImage imageNamed:@"icon_microphone_three"]];
    }
    
}

- (void)ConfirmOver{
    [self getOrderIngList];
}

//-------------------------------------------------------------

@end
