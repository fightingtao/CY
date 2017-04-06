//
//  COrderPayTypeChooseTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

@interface COrderPayTypeChooseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgview;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *detailLable;
@property (nonatomic, strong) UILabel *contentLable;
@property (nonatomic, strong) UIImageView *arrowImg;

@property (nonatomic, strong) UILabel *balanceLable;//钱包余额，（支付宝和微信不显示）

@end
