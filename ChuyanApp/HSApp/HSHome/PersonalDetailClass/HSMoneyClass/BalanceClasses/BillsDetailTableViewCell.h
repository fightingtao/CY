//
//  BillsDetailTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

@interface BillsDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *tipImg;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

- (void)setBillsWithModel:(Out_PacketBillsBody*)model;

@end
