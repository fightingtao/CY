//
//  AppDelegate.h
//  HSApp
//
//  Created by xc on 15/11/5.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "iToast.h"
#import "FLSideSlipViewController.h"
#import "publicResource.h"
#import "XQNewFeatureVC.h"
#import "IQKeyboardManager.h"
#import "UserInfoSaveModel.h"
#import "HomePageViewController.h"
#import "PersonInfoViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"

#import <TAESDK/TaeSDK.h>

#import "APService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate,WXApiDelegate>
{
    Reachability  *hostReach;
    BMKMapManager* _mapManager;
    BMKLocationService* _locService;
    UIAlertView *AlertViewOne;
    UIAlertView *AlertViewTwo;
    UIAlertView *AlertViewThree;
    UIAlertView *alertV;
    NSString *iosDownLoad;
}



@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) FLSideSlipViewController *menuViewController;
@property (nonatomic, strong) HomePageViewController *homePageVC;
@property (nonatomic, strong) PersonInfoViewController *personVC;

@property (nonatomic, strong) NSString *staticCity;
@property (nonatomic, strong) NSString *staticAddress;
@property CGFloat staticlng;
@property CGFloat staticlat;
@end

