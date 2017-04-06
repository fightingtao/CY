//
//  DynamicOrderCommentTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

#define CommentCellHeight 65.0

@interface DynamicOrderCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel *contentLabel;//评论内容
@property (nonatomic, strong) UIButton *commentBtn;//评论按钮

+ (CGFloat)cellHeightWithModel:(NSString*)model;
- (void)setOrderContentWithModel:(Out_OrderDynamicCommentBody*)model;
@end
