//
//  LNotificationTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#import "communcation.h"

@interface LNotificationTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)setDataWithModel:(Out_LNotificationBody*)model;

@end
