//
//  LGoodsListTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"


@protocol LOrderListDelegate <NSObject>

- (void)callPhoneWithModel:(Out_LOrderListBody*)model;

@end

@interface LGoodsListTableViewCell : UITableViewCell

@property (nonatomic, strong) id<LOrderListDelegate>delegate;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *meterLabel;
@property (nonatomic, strong) UIImageView *shopImgview;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *orderAddressLabel;
@property (nonatomic, strong) UILabel *receiverNameLabel;
@property (nonatomic, strong) UIImageView *phoneImgview;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *PayStatusLabel;
@property (nonatomic, strong) UILabel *orderStatusLabel;
@property int KindType;

@property (nonatomic, strong) Out_LOrderListBody *tempModel;

- (void)setModel:(Out_LOrderListBody*)model;

- (CGFloat)CellHeightWithModel:(Out_LOrderListBody*)model;

@end
