//
//  MixedPayTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#define MixedPayCellHeight 160.0


@interface MixedPayTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *orderInfoView;

@property (nonatomic, strong) UILabel *numTitleLabel;
@property (nonatomic, strong) UILabel *orderNumLabel;

@property (nonatomic, strong) UILabel *payTitleLabel;
@property (nonatomic, strong) UILabel *realPayLabel;

@property (nonatomic, strong) UILabel *balanceTitleLabel;
@property (nonatomic, strong) UILabel *balanceLabel;


@property (nonatomic, strong) UILabel *mixedTitleLabel;
@property (nonatomic, strong) UILabel *mixedPayLabel;

+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(NSString*)model;

@end
