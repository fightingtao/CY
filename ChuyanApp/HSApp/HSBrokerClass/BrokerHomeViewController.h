//
//  BrokerHomeViewController.h
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "MJRefresh.h"

#import "BrokerHeadView.h"
#import "AppDelegate.h"

#import "VoiceConverter.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"

#import <AVFoundation/AVFoundation.h>

@interface BrokerHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign) BFuncType nowType;
@property (nonatomic, strong) UIView *btipView;//经纪人小提示view
@property (nonatomic, strong) UILabel *bTipLabel;//经纪人小提示



- (void)getWaitOrderlist;
@end
