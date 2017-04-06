//
//  MegDynamicTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"
#import "UIImageView+MJWebCache.h"
#import "UIButton+WebCache.h"

#define MsgDynamicCellHeight 65.0

@interface MegDynamicTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

+(CGFloat)cellHeightWithModel:(NSString*)model;
- (void)setMsgWithModel:(Out_HSMessageBody*)model;

@end
