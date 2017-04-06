//
//  COrderDetailStatusTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

#define OrderDetailStatusCellHeight 65.0

@interface COrderDetailStatusTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *contentImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_OrderDetailStatusBody*)model;

@end
