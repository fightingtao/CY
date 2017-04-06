//
//  BalanceDetailViewController.h
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"


#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@interface BalanceDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property int type;//1 支付宝 2微信

@end
