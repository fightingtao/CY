//
//  ChooseBrokerViewController.h
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"

@protocol ChooseBrokerCompleteDelegate <NSObject>

- (void)completeAndRefresh;

@end

@interface ChooseBrokerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) id<ChooseBrokerCompleteDelegate>delegate;


- (void)getBrokerListWithOrderId:(NSString*)orderId;


@end
