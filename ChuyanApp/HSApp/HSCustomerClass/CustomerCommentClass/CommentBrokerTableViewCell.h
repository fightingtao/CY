//
//  CommentBrokerTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "LHRatingView.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"


#define CBrokerCellHeigth 120.0

@interface CommentBrokerTableViewCell : UITableViewCell<ratingViewDelegate>


@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *levelLabel;//等级，成就点
@property (nonatomic, strong) LHRatingView * starView;
@property (nonatomic, strong) UILabel *userVoiceLabel;//宣言

+ (CGFloat)cellHeight;

- (void)setOrderContentWithModel:(Out_CommentUserBody*)model;

@end
