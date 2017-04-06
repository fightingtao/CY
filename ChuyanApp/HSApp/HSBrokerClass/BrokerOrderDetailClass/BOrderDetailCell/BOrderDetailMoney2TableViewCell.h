//
//  BOrderDetailMoney2TableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"


#define OrderDetailPay2CellHeight 84.0

@interface BOrderDetailMoney2TableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *tipsMoneyLabel;//小费金额

@property (nonatomic, strong) UILabel *payMoneyLabel;

+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model;

@end
