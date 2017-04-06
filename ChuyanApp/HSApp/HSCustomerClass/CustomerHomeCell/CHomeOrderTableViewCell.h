//
//  CHomeOrderTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

#define OrderCellHeigth 146.0


@protocol CHomeOrderDelegate <NSObject>
///点击头像
- (void)headImgClickWithModel:(OutHomeListBody*)model;
///展示订单图片
- (void)showOrderImgWithModel:(OutHomeListBody*)model AndIndex:(int)index;
///播放语音内容
- (void)playOrderVoiceWithModel:(OutHomeListBody*)model;
///订单点赞
- (void)praiseOrderWithModel:(OutHomeListBody*)model;
///订单评价
- (void)commentOrderWithModel:(OutHomeListBody*)model;

@end

@interface CHomeOrderTableViewCell : UITableViewCell
@property (nonatomic, strong) id<CHomeOrderDelegate>delegate;

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
@property (nonatomic, strong) UIButton *commentBtn;//评论按钮
@property (nonatomic, strong) UILabel *commentCountLabel;//评论数
@property (nonatomic, strong) UIButton *praiseBtn;//点赞按钮
@property (nonatomic, strong) UILabel *praiseCountLabel;//点赞数

@property (nonatomic, strong) OutHomeListBody *tempOrderModel;

///刷新cell高度
+ (CGFloat)cellHeightWithModel:(OutHomeListBody*)model;
///刷新cell数据
- (void)setOrderContentWithModel:(OutHomeListBody*)model;

@end
