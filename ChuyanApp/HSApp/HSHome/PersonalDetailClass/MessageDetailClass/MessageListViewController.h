//
//  MessageListViewController.h
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "communcation.h"
#import "iToast.h"

typedef NS_ENUM(NSInteger, MsgType)//消息类型
{
    MsgType_Dynamic,//消息类型-动态
    MsgType_Notice,//消息类型-通知
};

@interface MessageListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) MsgType nowType;

@end
