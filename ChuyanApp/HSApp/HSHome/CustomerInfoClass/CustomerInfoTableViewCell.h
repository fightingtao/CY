//
//  CustomerInfoTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "LHRatingView.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"


#define CHomeCommentCellHeigth 170.0

@interface CustomerInfoTableViewCell : UITableViewCell<ratingViewDelegate>

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) LHRatingView * starView;
@property (nonatomic, strong) UILabel *levelLabel;//等级，成就点
@property (nonatomic, strong) UILabel *userVoiceLabel;//宣言


+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_CheckUserInfoBody*)model;

@end
