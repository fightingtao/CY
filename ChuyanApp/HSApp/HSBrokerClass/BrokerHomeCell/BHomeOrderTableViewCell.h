//
//  BHomeOrderTableViewCell.h
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
#import "AppDelegate.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>

#define OrderCellHeigth 146.0

@protocol BHomeOrderDelegate <NSObject>
///抢单
- (void)getOrderDelegateWithModel:(OutWaitOrderListBody*)model;
///展示订单图片
- (void)showOrderImgWithModel:(OutWaitOrderListBody*)model AndIndex:(int)index;
///播放语音内容
- (void)playOrderVoiceWithModel:(OutWaitOrderListBody*)model;
///点击头像
- (void)headImgClickWithModel:(OutWaitOrderListBody*)model;
@end


@interface BHomeOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) id<BHomeOrderDelegate>delegate;

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
@property (nonatomic, strong) UIImageView *distanceImg;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIButton *getOrderBtn;//评论按钮

@property (nonatomic, strong) OutWaitOrderListBody *tempOrderModel;

+ (CGFloat)cellHeightWithModel:(OutWaitOrderListBody*)model;

- (void)setOrderContentWithModel:(OutWaitOrderListBody*)model;

@end
