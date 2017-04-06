//
//  RewardRecommendViewController.h
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "communcation.h"
#import "MBProgressHUD.h"
#import "iToast.h"


@interface RewardRecommendViewController : UIViewController


@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UITextView *tipTxtView;
@property (nonatomic, strong) UIView *dealView;
@property (nonatomic, strong) UIButton *inviteBtn;

@end
