//
//  BHomeOrderIngTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/20.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

#define OrderIngCellHeigth 166.0

@protocol BHomeOrderIngCellDelegate <NSObject>
///拨打雇主电话
- (void)OrderIngCallCustomerWithModel:(Out_OrderIngListBody*)model;
///确认购买
- (void)orderIngConfirmOrderWithModel:(Out_OrderIngListBody*)model;
///评价雇主
- (void)orderIngCommentCustomerWithModel:(Out_OrderIngListBody*)model;
///点击头像
- (void)orderIngHeaderClickWithModel:(Out_OrderIngListBody*)model;
///展示订单图片
- (void)orderIngshowOrderImgWithModel:(Out_OrderIngListBody*)model AndIndex:(int)index;
///播放语音内容
- (void)orderIngplayOrderVoiceWithModel:(Out_OrderIngListBody*)model;
@end


@interface BHomeOrderIngTableViewCell : UITableViewCell

@property (nonatomic, strong) id<BHomeOrderIngCellDelegate>delegate;

@property (nonatomic, strong) UIView *menuView;//主要内容
@property (nonatomic, strong) UIView *headView;//头部时间和状态

@property (nonatomic, strong) UILabel *timeLabel;//订单时间
@property (nonatomic, strong) UILabel *statusLabel;//订单状态

@property (nonatomic, strong) UILabel *orderTypeLabel;//订单类型（代购，代送，代办）
@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *orderContentLabel;//订单文字内容
@property (nonatomic, strong) UIButton *orderVoiceBtn;//订单语音
@property (nonatomic, strong) UILabel *getAddressLabel;//订单取地址
@property (nonatomic, strong) UILabel *sendAddressLabel;//订单送地址
@property (nonatomic, strong) UIView *line;//横线
@property (nonatomic, strong) UIView *line2;//横线
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) UILabel *tipsLabel;//小费内容

@property (nonatomic, strong) Out_OrderIngListBody *tempOrderModel;

- (void)timerFireMethod:(NSTimer *)timer;

+ (CGFloat)cellHeightWithModel:(Out_OrderIngListBody*)model;

- (void)setOrderContentWithModel:(Out_OrderIngListBody*)model;

@end
