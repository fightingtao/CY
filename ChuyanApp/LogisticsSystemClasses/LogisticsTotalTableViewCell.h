//
//  LogisticsTotalTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/18.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import <QuartzCore/QuartzCore.h>
#import "communcation.h"

@interface LogisticsTotalTableViewCell : UITableViewCell


@property (nonatomic, assign) id delegate;

- (void)setModel:(Out_LogisticsHomeBody*)model;

@end

@protocol LogisticsTotalTableViewCellDelegate <NSObject>

- (void)JumpPage;

@end
