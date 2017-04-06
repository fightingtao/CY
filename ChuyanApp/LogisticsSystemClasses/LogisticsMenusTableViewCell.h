//
//  LogisticsMenusTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/18.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

@protocol MenusDelegate <NSObject>

- (void)getPacketClickDelegate;
- (void)sendPacketClickDelegate;
- (void)messageClickDelegate;
- (void)workClickDelegate;
- (void)personClickDelegate;
- (void)JiaoKuanClickDelegate;//jiao缴款单
@end

@interface LogisticsMenusTableViewCell : UITableViewCell

@property (nonatomic, strong) id<MenusDelegate>delegate;
-(void)setCellFrame:(Out_LogisticsHomeBody *)model;
@end
