//
//  COrderDetailPay2TableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"


#define OrderDetailPay2CellHeight 124.0

@interface COrderDetailPay2TableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *tipsMoneyLabel;//小费金额

@property (nonatomic, strong) UILabel *redPacketsLabel;
@property (nonatomic, strong) UILabel *redPacketsMoneyLabel;//红包金额

@property (nonatomic, strong) UILabel *payMoneyLabel;

+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model;

@end
