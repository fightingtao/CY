//
//  WithdrawBillsDetailViewController.h
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "communcation.h"
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, MoneyDetailType)//金额详细类型
{
    //1.代购，2.小费 3.提现 4.全部(接口类型)
    MoneyDetailType_All,//金额详细类型-全部
    MoneyDetailType_Buy,//金额详细类型-代购
    MoneyDetailType_Tips,//金额详细类型-小费
    MoneyDetailType_Withdraw,//金额详细类型-提现
};


@interface WithdrawBillsDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign) MoneyDetailType detailType;


@end
