//
//  LPersonalViewController.h
//  HSApp
//
//  Created by xc on 16/1/27.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#import "iToast.h"
#import "MBProgressHUD+Add.h"
#import "UserInfoSaveModel.h"

#import "UIImageView+MJWebCache.h"
@protocol BackHomeDelegate <NSObject>

- (void)backToHomeDelegate;

@end

@interface LPersonalViewController : UIViewController

@property (nonatomic, strong) id<BackHomeDelegate>delegate;

@end
