//
//  OrderAddressChooseViewController.h
//  HSApp
//
//  Created by xc on 15/11/17.
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

@protocol OrderAddressChooseDelegate <NSObject>

//获取地址代理，type是地址类型，是代购，代办时是1，代送是2
- (void)getOrderAddressWithModel:(OutAddressBody*)model AndType:(int)type;

@end

@interface OrderAddressChooseViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService* _locService;
    
}
@property (nonatomic, strong) id<OrderAddressChooseDelegate>delegate;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *addAddressView;
@property (nonatomic, strong) UILabel *nameTipLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UILabel *phoneTipLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UILabel *addressTipLabel;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UILabel *tipTitileLabel;

@property int addressType;

@end
