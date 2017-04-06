//
//  RedPacketTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

@interface RedPacketTableViewCell : UITableViewCell


@property (nonatomic,strong) UIImageView *sideImageView;
@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *endLabel;

@property (nonatomic, strong) UILabel *redMoneyLabel;
@property (nonatomic, strong) UILabel *userfulDayLabel;
@property (nonatomic, strong) UILabel *userfulTimeLabel;
@property (nonatomic, strong) UILabel *redTitleLabel;
@property (nonatomic, strong) UILabel *redTipLabel;
- (NSString*)getDateWith:(long)tempdate;

- (void)setRedDataWithModel:(Out_RedPacketBody*)model;

@end
