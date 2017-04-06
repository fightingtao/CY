//
//  BOrderDetailMoneyTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#define OrderDetailPayCellHeight 124.0

@interface BOrderDetailMoneyTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *goodsLabel;
@property (nonatomic, strong) UILabel *goodsMoneyLabel;//商品金额

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *tipsMoneyLabel;//小费金额

@property (nonatomic, strong) UILabel *payMoneyLabel;

+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model;
@end
