//
//  RedPacketViewController.h
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "communcation.h"

@protocol PayChooseRedDelegate <NSObject>

- (void)getTheRedWithModel:(Out_RedPacketBody*)model;

@end

@interface RedPacketViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) id<PayChooseRedDelegate>delegate;
@property int type;//1 是可用红包 2是所有红包

@end
