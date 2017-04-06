//
//  COrderDynamicViewController.h
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "MJRefresh.h"

#import "VoiceConverter.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface COrderDynamicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *orderId;

///是否是抢单
@property BOOL isGetOrder;


- (void)commentFromList;


@end
