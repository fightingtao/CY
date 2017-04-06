//
//  LOrderDetailViewController.h
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "iToast.h"
#import "MBProgressHUD+Add.h"
#import "UserInfoSaveModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface LOrderDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>


@property (nonatomic, strong) NSString *orderId;

@property int KindType;


@end
