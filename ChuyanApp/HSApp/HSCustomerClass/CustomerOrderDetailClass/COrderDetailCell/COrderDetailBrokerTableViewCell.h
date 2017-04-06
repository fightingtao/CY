//
//  COrderDetailBrokerTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

@protocol DetailOrderBrokerDelegate <NSObject>

///拨打电话
- (void)callPhoneWithModel:(Out_OrderDetailBody*)model;

@end

@interface COrderDetailBrokerTableViewCell : UITableViewCell

@property (nonatomic, strong) id<DetailOrderBrokerDelegate>delegate;

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UIImageView *phoneImgView;
@property (nonatomic, strong) UILabel *statusLabel;


@property (nonatomic, strong) Out_OrderDetailBody *tempModel;


///0 是加载雇主信息   1是加载经纪人信息
- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model AndType:(int)type;

@end
