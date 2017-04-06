//
//  CustomerInfoCommentTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"
#define CommentCellHeight 65.0

@interface CustomerInfoCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel *contentLabel;//评论内容
@property (nonatomic, strong) UIButton *commentBtn;//评论按钮

+ (CGFloat)cellHeightWithModel:(NSString*)model;
- (void)setOrderContentWithModel:(Out_CommentListBody*)model;

@end
