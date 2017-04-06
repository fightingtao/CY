//
//  COrderPayTypeChooseViewController.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"


#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@protocol PaySuccessBackDelegate <NSObject>

- (void)paySuccessBackRefresh;

- (void)refreshtableview;

@end

@interface COrderPayTypeChooseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) id<PaySuccessBackDelegate>delegate;
@property (nonatomic,copy) NSString *tmpOrderId;

@property (nonatomic, strong) NSString *orderId;
@property int orderType;//代办，代购，代送

@property int type;//1 支付宝 2微信

- (void)getOrderPayDetail;
@end
