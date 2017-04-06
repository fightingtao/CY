//
//  UserInfoTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "LHRatingView.h"

#define UserInfoCellHeigth 140.0

@interface UserInfoTableViewCell : UITableViewCell<ratingViewDelegate>

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *levelLabel;//等级，成就点
@property (nonatomic, strong) LHRatingView * starView;


+ (CGFloat)cellHeight;

- (void)setOrderContentWithModel:(NSString*)model;

@end
