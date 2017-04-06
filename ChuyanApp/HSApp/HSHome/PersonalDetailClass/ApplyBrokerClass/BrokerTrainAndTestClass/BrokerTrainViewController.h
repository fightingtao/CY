//
//  BrokerTrainViewController.h
//  HSApp
//
//  Created by xc on 15/12/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"

@protocol CompleteTrainDelegate <NSObject>

- (void)completeTrainWithStatus:(int)status;//0是未通过，1是通过

@end

@interface BrokerTrainViewController : UIViewController

@property (nonatomic, strong) id<CompleteTrainDelegate>delegate;

@end
