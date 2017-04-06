//
//  WithdrawCashTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#define WithdrawCashCellHeight 220.0

@protocol MoneyDetailDelegate <NSObject>

- (void)showBuyDetail;
- (void)showTipsDetail;
- (void)showWithdrawDetail;

@end

@interface WithdrawCashTableViewCell : UITableViewCell

@property (nonatomic, strong) id<MoneyDetailDelegate>delegate;

@property (nonatomic,strong) UILabel *tipLabel1;
@property (nonatomic, strong) UILabel *enableMoneyLabel;

@property (nonatomic, strong) UILabel *tipLabel2;
@property (nonatomic, strong) UILabel *buyTotalLabel;
@property (nonatomic, strong) UILabel *tipLabel3;
@property (nonatomic, strong) UILabel *tipsTotalLabel;
@property (nonatomic, strong) UILabel *tipLabel4;
@property (nonatomic, strong) UILabel *withdrawMoneyLabel;

@property (nonatomic, strong) UIButton *buyDetailBtn;
@property (nonatomic, strong) UIButton *tipsDetailBtn;
@property (nonatomic, strong) UIButton *withdrawDetailBtn;

+(CGFloat)cellHeight;
- (void)setCashWithModel:(Out_MoneyBody*)model;

@end
