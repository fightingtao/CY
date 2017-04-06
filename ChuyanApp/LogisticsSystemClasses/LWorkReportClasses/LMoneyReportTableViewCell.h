//
//  LMoneyReportTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "DataModels.h"
@interface LMoneyReportTableViewCell : UITableViewCell


@property (nonatomic ,strong) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UIImageView *correctImgview;
@property (nonatomic, strong) UILabel *correctMoneyLabel;
@property (nonatomic, strong) UILabel *alipayLabel;
@property (nonatomic, strong) UILabel *cashLabel;
@property (nonatomic, strong) UILabel *posCardLabel;

//@property (nonatomic, strong) UIImageView *problemImgview;
@property (nonatomic, strong) UILabel *problemMoneyLabel;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) UIButton *AlreadyBtn;
@property (nonatomic, strong) UIImageView *imgv;
@property (nonatomic, assign) BOOL isState;

@property (nonatomic, assign) id delegate;

- (void)setDataWithModl:(CYNSObject*)model;

@end

@protocol LMoneyReportTableViewCellDelegate <NSObject>

- (void)CellHeightWithState:(BOOL)state;

@end
