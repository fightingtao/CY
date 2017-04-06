//
//  CustomerInfoViewController.h
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "MBProgressHUD.h"
#import "iToast.h"
#import "communcation.h"
#import "MJRefresh.h"


@interface CustomerInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *userId;
///评论类型
@property int commentType;

@end
