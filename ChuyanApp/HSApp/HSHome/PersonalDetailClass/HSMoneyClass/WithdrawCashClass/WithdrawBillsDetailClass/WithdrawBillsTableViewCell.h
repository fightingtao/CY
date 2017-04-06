//
//  WithdrawBillsTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

@interface WithdrawBillsTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *moneyLabel;


- (void)setBillsWithModel:(Out_BillsDetailBody*)model;
@end
