//
//  LOrderReportTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "DataModels.h"
@interface LOrderReportTableViewCell : UITableViewCell


@property (nonatomic ,strong) UILabel *totalOrderLabel;
@property (nonatomic, strong) UIImageView *correctImgview;
@property (nonatomic, strong) UILabel *correctOrderLabel;
@property (nonatomic, strong) UIImageView *problemImgview;
@property (nonatomic, strong) UILabel *problemOrderLabel;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;

- (void)setDataWithModel:(CYNSObject*)model;

@end
