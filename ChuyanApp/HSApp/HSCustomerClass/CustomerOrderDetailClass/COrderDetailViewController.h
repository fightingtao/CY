//
//  COrderDetailViewController.h
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#import "VoiceConverter.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"

#import "AppDelegate.h"

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, OrderStatus)//订单状态类型（通过这个判断是否加载经纪人信息）
{
    OrderStatus_WJD,//订单状态类型-未接单
    OrderStatus_YJD,//订单状态类型-已接单
};

typedef NS_ENUM(NSInteger, OrderInfoType)//展示订单信息类型
{
    OrderInfoType_Detail,//展示订单详情
    OrderInfoType_Status,//展示订单状态
};

@interface COrderDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) OrderStatus nowStatus;//当前订单状态
@property (nonatomic, assign) OrderInfoType nowInfoType;//当前展示信息类型

///订单id
@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, assign) id delegate;

///获取订单详情
- (void)getOrderDetail;

@end

@protocol COrderDetailViewControllerDelegate <NSObject>

- (void)ConfirmOver;

@end
