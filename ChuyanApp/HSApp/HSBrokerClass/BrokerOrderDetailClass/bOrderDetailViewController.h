//
//  bOrderDetailViewController.h
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "HSAlertShowViewController.h"

#import "VoiceConverter.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, OrderStatus)//订单状态类型（通过这个判断是否加载用户信息）
{
    OrderStatus_WJD,//订单状态类型-未接单
    OrderStatus_YJD,//订单状态类型-已接单
};


@interface bOrderDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>


@property (nonatomic, assign) OrderStatus nowStatus;//当前订单状态

@property (nonatomic, strong) NSString *orderId;

///获取订单详情
- (void)getOrderDetail;
@end
