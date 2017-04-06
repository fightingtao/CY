//
//  COrderDetailPayTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#define OrderDetailPayCellHeight 204.0

@interface COrderDetailPayTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *goodsLabel;
@property (nonatomic, strong) UILabel *goodsMoneyLabel;//商品金额

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *tipsMoneyLabel;//小费金额

@property (nonatomic, strong) UILabel *discountLabel;
@property (nonatomic, strong) UILabel *disMoneyLabel;//优惠金额

@property (nonatomic, strong) UILabel *redPacketsLabel;
@property (nonatomic, strong) UILabel *redPacketsMoneyLabel;//红包金额

@property (nonatomic, strong) UILabel *disTotalLabel;
@property (nonatomic, strong) UILabel *payMoneyLabel;

+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model;

@end
