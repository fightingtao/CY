//
//  LWorkReportViewController.h
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

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@interface LWorkReportViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>


- (void)beforPayMenoyGetTran;
@end
