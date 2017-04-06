//
//  AppDelegate.m
//  HSApp
//
//  Created by xc on 15/11/5.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AppDelegate.h"
#import "AlipaySDK.h"
#import "APayAuthInfo.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "MBProgressHUD.h"
#import "MKJNavigationViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [NSThread sleepForTimeInterval:1.5];
    
    //调用键盘方法start
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:0];
    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    //end
    
    //网络检测
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
    
    //集成百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"XG698WOM8zO6iuqjAzWnDvb6"  generalDelegate:self];
    if (!ret) {
        NSLog(@"baidu manager start failed!");
    }
    
    //阿里百川
    [[TaeSDK sharedInstance] setDebugLogOpen:NO];
    
    
    //sdk初始化
    [[TaeSDK sharedInstance] asyncInit:^{
        NSLog(@"初始化成功");
    } failedCallback:^(NSError *error) {
        NSLog(@"初始化失败:%@",error);
    }];
    
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    [APService setupWithOption:launchOptions];
    
    
    //集成友盟SDK
    [UMSocialData setAppKey:@"565e5ace67e58eb976007f94"];
    //设置图文分享
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialWechatHandler setWXAppId:@"wx5a6c8debcd643ff1" appSecret:@"4efb08d9d73c3bf4b654798d3451695c" url:@"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105458286" appKey:@"uF8lcoapcx1XMgXD" url:@"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8"];
    [UMSocialData defaultData].extConfig.qqData.url = @"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8";
    
    //    打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"231345184"
                                              secret:@"814862667ffc1ee9ac7913b9b2f00d2e"
                                         RedirectURL:@"http://www.3856.cc"];
    
    // 微信
    [WXApi registerApp:@"wxa034bad9cba2af52" withDescription:@"CYApp"];
    
    //执行定位功能
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            [self locationClick];
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前定位不可用，请检查设置中是否打开定位服务?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"设置", nil];
        [alert show];
    }
    
    _homePageVC = [[HomePageViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:_homePageVC];
    _personVC = [[PersonInfoViewController alloc] init];
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:_personVC];
    
    //侧边栏初始化
    _menuViewController = [[FLSideSlipViewController alloc]initWithRootViewController:homeNav];
    _menuViewController.leftDistance = SCREEN_WIDTH-60;//设置滑动距离
    _menuViewController.scaleSize = 1;//设置缩小比例
    _menuViewController.animationType = AnimationTransitionAndScale;//设置动画类型
    _menuViewController.canSlideInPush = NO;
    _menuViewController.leftViewController = personNav;
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSData *userData = [userDefault objectForKey:UserKey];
//    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //生成引导页
        XQNewFeatureVC *newVc = [[XQNewFeatureVC alloc] initWithFeatureImagesNameArray:@[@"1",@"2",@"33"]];
        newVc.pageIndicatorTintColor = [UIColor blackColor];
        self.window.rootViewController = newVc;
        newVc.completeBlock = ^{
            //设置第一次进入后唯1，表示已经使用过该应用，不在进入引导页
//            UserInfoSaveModel *saveModel = [[UserInfoSaveModel alloc] init];
//            saveModel.isFirst = @"1";
//            NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:saveModel];
//            [userDefault setObject:setData forKey:UserKey];
            self.window.rootViewController = _menuViewController;
        };
    }else{
        self.window.rootViewController = _menuViewController;
    }
//        [self performSelector:@selector(getAppStore) withObject:nil afterDelay:2.0];
    //    [self getAppStore];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self locationClick];
    [APService setBadge:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//获取DeviceToken成功
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //这里进行的操作，是将Device Token发送到服务端
    [APService registerDeviceToken:deviceToken];
    
    //    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"DeviceToken:%@",deviceToken] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //    [alert show];
}
//网络发生变化时处理
- (void)netChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [currReach currentReachabilityStatus];
    if(status == NotReachable)
    {
        [[iToast makeText:@"当前没有网络连接!请检查网络!"] show];
        return;
        
    }
    if(status == kReachableViaWiFi)
    {
        [[iToast makeText:@"当前为WIFI网络!"] show];
        return;
        
    }
    if(status == kReachableViaWWAN)
    {
        [[iToast makeText:@"当前为2G/3G/4G网络!"] show];
        return;
        
    }
}


/*!
 *   @author XC, 15-08-06 10:08:23
 *
 *   @brief  百度地图代理
 *
 *   @param iError 代理处理
 *
 *   @since 1.0
 */
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

//定位
- (void)locationClick
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //    _locService.distanceFilter =10.0;
    _locService.desiredAccuracy =kCLLocationAccuracyBest;
    
    //启动LocationService
    [_locService startUserLocationService];
}


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];
    
    _staticlat = userLocation.location.coordinate.latitude;
    _staticlng = userLocation.location.coordinate.longitude;
    
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
    BMKAddressComponent *city = result.addressDetail;
    _staticCity = city.city;
    if ([result.poiList count] > 0) {
        BMKPoiInfo *tempAddress = [result.poiList objectAtIndex:0];
        
        _staticAddress = tempAddress.address;
    }else
    {
        _staticAddress = result.address;
    }
    
    
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    [[iToast makeText:@"定位失败，请检查是否打开定位服务!"] show];
}


- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}


- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
    NSNotification *notification = [NSNotification notificationWithName:PushNotifyName object:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    
    NSNotification *notification = [NSNotification notificationWithName:PushNotifyName object:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    // 微信
    [WXApi handleOpenURL:url delegate:self];
    
    // 支付宝
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
    }];
    
    return YES;
    
}

- (void)onResp:(BaseResp *)resp
{
    
    //支付返回结果，实际支付结果需要去微信服务器端查询
    if ([resp isKindOfClass:[PayResp class]])
    {
        switch (resp.errCode){
            case WXSuccess:{
                
                AlertViewOne = [[UIAlertView alloc]initWithTitle:@"提示" message:@"微信支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [AlertViewOne show];
            }
                break;
            case WXErrCodeCommon:{
                //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                //strMsg = [NSString stringWithFormat:@"错误码ErrCode>>>>>>>%d,错误字符串ErrStr>>>>>>>>%@",resp.errCode,resp.errStr];
                AlertViewTwo = [[UIAlertView alloc]initWithTitle:@"提示" message:@"微信支付失败,是否重新支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                [AlertViewTwo show];
                
            }
                break;
            case WXErrCodeUserCancel:{
                AlertViewThree = [[UIAlertView alloc]initWithTitle:@"提示" message:@"微信支付取消,是否重新支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                [AlertViewThree show];
                
            }
                break;
            case WXErrCodeSentFail:{
                
            }
                break;
            case WXErrCodeUnsupport:{
                //微信不支持
                NSLog(@"微信不支持");
                
            }
                break;
            case WXErrCodeAuthDeny:{
                //授权失败
            }
                break;
            default:
                break;
                
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == AlertViewOne){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BackVC" object:nil userInfo:@{@"code":@"1000"}];
    }
    else if (alertView == AlertViewTwo){
        if (buttonIndex == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BackVC" object:nil userInfo:@{@"code":@"1001"}];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChongZhiVC" object:nil userInfo:nil];
        }
        else{
            
        }
    }
    else if (alertView == AlertViewThree){
        if (buttonIndex ==0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BackVC" object:nil userInfo:@{@"code":@"1001"}];
        }else
        {
            
        }
    }
    else if (alertView==alertV){
//        if (buttonIndex==0){
//            NSURL *url = [NSURL URLWithString:iosDownLoad];
//            [[UIApplication sharedApplication] openURL:url];
//        }
    }
    else
    {
        if (buttonIndex == 0) {
            
        }
        
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        
    }
    
}

#pragma mark ********
- (void)getCommentList
{
    //    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    NSData *userData = [userDefault objectForKey:UserKey];
    //    UserInfoSaveModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    //    NSArray *dataArray = [[NSArray alloc] initWithObjects:_userId,[NSString stringWithFormat:@"%d",_commentType],_lastDate,_lastorderid, nil];
    //    NSString *hamcString = [[communcation sharedInstance] ArrayCompareAndHMac:dataArray];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[communcation sharedInstance]getVerisonWithMsg:@"" resultDic:^(NSDictionary *dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
        }];
        //        Out_CommentListModel *outModel = [[communcation sharedInstance] getCommentListWithModel:inModel];
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            if (!outModel)
        //            {
        //                [[iToast makeText:@"网络不给力,请稍后重试!"] show];
        //
        //            }else if (outModel.code ==1000)
        //            {
        //                               }
        //            }else{
        //                [[iToast makeText:outModel.message] show];
        //            }
        //        });
        
    });
}
//
//#pragma mark ----------
//-(void)getAppStore{
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[communcation sharedInstance]getVerisonFromAppStoreWithResultDic:^(NSDictionary *dic) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                DLog(@"当前版本号%@",dic);
//                NSDictionary *data=[[dic objectForKey:@"results"] firstObject];
//                
//                ///AppStore最新的版本号
//                NSString *version=[data objectForKey:@"version"];
//#pragma  mark -  获取当前本地的版本号
//                NSDictionary *localDic =[[NSBundle mainBundle] infoDictionary];
//                NSString * localVersion =[localDic objectForKey:@"CFBundleShortVersionString"] ;
//                
//                if (![localVersion isEqualToString: version])//如果本地版本比较低 证明要更新版本
//                {
////                    _homePageVC.view.userInteractionEnabled=NO;
////                    _menuViewController.view.userInteractionEnabled=NO;
////                    _personVC.view.userInteractionEnabled=NO;
//                    iosDownLoad=[data objectForKey:@"trackViewUrl"];
//                    
//                    alertV = [[UIAlertView alloc]initWithTitle:@"有更新了" message:@"感谢认真工作的你" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新喽", nil];
//                    [alertV show];
//                }
//            });
//            
//        }];
//    });
//}
@end
