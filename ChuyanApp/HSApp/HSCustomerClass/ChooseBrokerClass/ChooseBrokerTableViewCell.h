//
//  ChooseBrokerTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "LHRatingView.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"


#define ChooseBrokerCellHeigth 120.0

@protocol ChooseBrokerDelegate <NSObject>

///选择经纪人
- (void)chooseBrokerWithModel:(Out_GetOrderBrokerBody*)model;

///头像点击
- (void)headImgClickWithModel:(Out_GetOrderBrokerBody*)model;


@end

@interface ChooseBrokerTableViewCell : UITableViewCell<ratingViewDelegate>

@property (nonatomic, strong) id<ChooseBrokerDelegate>delegate;

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *levelLabel;//等级，成就点
@property (nonatomic, strong) LHRatingView * starView;
@property (nonatomic, strong) UILabel *userVoiceLabel;//宣言
@property (nonatomic, strong) UILabel *distanceLabel;//距离
@property (nonatomic, strong) UIButton *chooseBtn;//选择

@property (nonatomic, strong) Out_GetOrderBrokerBody *tempModel;

+ (CGFloat)cellHeight;

- (void)setBrokerContentWithModel:(Out_GetOrderBrokerBody*)model;

@end
