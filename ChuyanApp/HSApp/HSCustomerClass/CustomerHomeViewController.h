//
//  CustomerHomeViewController.h
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerHeadView.h"
#import "CustomerButtomView.h"

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "publicResource.h"
#import "AdAnimationView.h"
#import "MJRefresh.h"
#import "VoiceConverter.h"
#import "iToast.h"
#import "ImgBrowser.h"
#import "MBProgressHUD.h"
#import "communcation.h"


typedef NS_ENUM(NSInteger, MenuSelect)
{
    MenuSelect_Meishi,
    MenuSelect_Yinpin,
    MenuSelect_Chaoshi,
    MenuSelect_Xianhua,
    MenuSelect_Maicai,
    MenuSelect_Maiyao,
    MenuSelect_Banshi,
    MenuSelect_Songhuo,
    MenuSelect_Common,
};


@interface CustomerHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,AdAnimationViewDelegate,CustomerHeadDelegate,PublishDemandDelegate>


@property (nonatomic, assign) CFuncType ctype;//当前雇主功能类型

@property (nonatomic, strong) UIView *ctipView;//雇主小提示view
@property (nonatomic, strong) UILabel *cTipLabel;//雇主小提示


@end
