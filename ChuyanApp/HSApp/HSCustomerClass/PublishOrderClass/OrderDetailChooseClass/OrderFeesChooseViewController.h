//
//  OrderFeesChooseViewController.h
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "UserInfoSaveModel.h"

@protocol OrderFeesChooseDelegate <NSObject>

- (void)cancelFeesChoose;
- (void)chooseFeesWithModel:(OutTipsBody*)model;

@end

@interface OrderFeesChooseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) id<OrderFeesChooseDelegate>delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancalBtn;

@property (nonatomic, strong) NSString *tempOrderId;

@end
