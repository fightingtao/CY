//
//  RechargePacketViewController.h
//  HSApp
//
//  Created by xc on 15/12/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "UserInfoSaveModel.h"
#import "communcation.h"

@protocol RechargeChooseDelegate <NSObject>

- (void)cancelTypeChoose;
- (void)chooseTypeWithModel:(Out_RechargeMoneyBody*)model;

@end

@interface RechargePacketViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) id<RechargeChooseDelegate>delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancalBtn;

@end
