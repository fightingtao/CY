//
//  OrderTypeChooseViewController.h
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "UserInfoSaveModel.h"
#import "communcation.h"

@protocol OrderTypeChooseDelegate <NSObject>

- (void)cancelTypeChoose;
- (void)chooseTypeWithModel:(OutTypeBody*)model;

@end

@interface OrderTypeChooseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) id<OrderTypeChooseDelegate>delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancalBtn;

@end
