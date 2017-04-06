//
//  LOrderDetailTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#import "communcation.h"

@interface LOrderDetailTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *shopImgview;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *PayStatusLabel;
@property (nonatomic, strong) UILabel *receiverNameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *orderAddressLabel;
@property (nonatomic, strong) UILabel *orderStatusLabel;
@property (nonatomic, strong) UILabel *CodLabel;
@property (nonatomic, strong) UILabel *OrderType;


@property (nonatomic, strong) UIView *line7;


@property (nonatomic, strong) UILabel *problemStatusLabel;

@property int KindType;


- (void)setModel:(Out_LOrderDetailBody*)model;

- (CGFloat)CellHeight:(Out_LOrderDetailBody*)model;

@end
