//
//  DynamicPersonCommentTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#define CommentCellHeight 50.0

@interface DynamicPersonCommentTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *headImgView;//头像
@property (nonatomic, strong) UILabel *nameLabel;//用户名
@property (nonatomic, strong) UILabel *contentLabel;//评论内容

+ (CGFloat)cellHeightWithModel:(NSString*)model;
- (void)setOrderContentWithModel:(NSString*)model;
@end
