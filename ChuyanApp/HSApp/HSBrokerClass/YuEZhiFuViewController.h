//
//  YuEZhiFuViewController.h
//  HSApp
//
//  Created by cbwl on 16/5/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetModel.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@interface YuEZhiFuViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) Out_RedPacketBody *redModel;

@property (nonatomic,retain) Out_ReadyPayDetailBody *tempModel;

@property (nonatomic,retain) NSDictionary *ReturnDic;

@property (nonatomic,copy) NSString *orderid;

@property int type;//1 支付宝 2微信

@property (nonatomic,assign) id delegate;

@end

@protocol YuEZhiFuViewControllerDelegate <NSObject>

- (void)ConfirmOver;

@end
