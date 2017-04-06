//
//  RegisterViewController.h
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#import "iToast.h"
#import "MBProgressHUD.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

#import "UserInfoSaveModel.h"
#import "AppDelegate.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService* _locService;
    
}

@end
