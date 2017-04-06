//
//  COrderDetailOrderTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#define OrderCellHeigth 110.0

@interface COrderDetailOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderTypeLabel;//订单类型（代购，代送，代办）
@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *orderContentLabel;//订单文字内容
@property (nonatomic, strong) UIButton *orderVoiceBtn;//订单语音
@property (nonatomic, strong) UILabel *getAddressLabel;//订单取地址
@property (nonatomic, strong) UILabel *sendAddressLabel;//订单送地址


+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(NSString*)model;
@end
