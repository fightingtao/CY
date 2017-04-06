//
//  BOrderDetailAddressTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#define OrderAddCellHeigth 115.0

@protocol DetailOrderAddressDelegate <NSObject>

- (void)callAddressPhoneWithModel:(Out_OrderDetailBody*)model AndType:(int)type;


@end

@interface BOrderDetailAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) id<DetailOrderAddressDelegate>delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIImageView *userTipImg;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *phoneTipImg;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) UIImageView *addressTipImg;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *callBtn;

@property (nonatomic, strong) Out_OrderDetailBody *tempModel;
@property int type;

+ (CGFloat)cellHeightWithModel:(NSString*)model;
- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model AndType:(int)type;

@end
