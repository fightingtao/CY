//
//  BOrderDetailOrderTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

#define OrderCellHeigth 50.0


@protocol DetailOrderContentDelegate <NSObject>

///展示订单图片
- (void)showOrderImgWithModel:(Out_OrderDetailBody*)model AndIndex:(int)index;
///播放语音
- (void)playVoiceWithModel:(Out_OrderDetailBody*)model;

@end

@interface BOrderDetailOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) id<DetailOrderContentDelegate>delegate;

@property (nonatomic, strong) UILabel *orderTypeLabel;//订单类型（代购，代送，代办）
@property (nonatomic, strong) UILabel *orderContentLabel;//订单文字内容
@property (nonatomic, strong) UIButton *orderVoiceBtn;//订单语音


@property (nonatomic, strong) Out_OrderDetailBody *tempModel;

+ (CGFloat)cellHeightWithModel:(Out_OrderDetailBody*)model;

- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model;

@end
