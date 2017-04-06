//
//  CHomeCommentTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "LHRatingView.h"

#import "communcation.h"

#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

#define CHomeCommentCellHeigth 110.0

@interface CHomeCommentTableViewCell : UITableViewCell<ratingViewDelegate>

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) LHRatingView * starView;
@property (nonatomic, strong) UILabel *contentLabel;//评论内容
@property (nonatomic, strong) UILabel *timeLabel;//时间


+ (CGFloat)cellHeightWithModel:(NSString*)model;

- (void)setOrderContentWithModel:(Out_CommentListBody*)model;

@end
