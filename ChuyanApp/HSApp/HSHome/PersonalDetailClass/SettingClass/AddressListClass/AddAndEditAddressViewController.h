//
//  AddAndEditAddressViewController.h
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
#import "UserInfoSaveModel.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@protocol AddAddressDelegate <NSObject>

- (void)completeNewAddress;

@end

@interface AddAndEditAddressViewController : UIViewController<UITextFieldDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService* _locService;
    
}

@property (nonatomic, strong) id<AddAddressDelegate>delegate;

@property (nonatomic, strong) UIView *titleView;//标题view
@property (nonatomic, strong) UILabel *titleLabel;//标题


@property int type;//0 添加 1编辑

///当前编辑的地址
@property (nonatomic, strong) OutAddressBody *editModel;

@end
