//
//  LFailedOrderTableViewCell.h
//  HSApp
//
//  Created by xc on 16/1/29.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

@interface LFailedOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *reasonLabel;


- (void)setModel:(Out_LScanFailureBody*)model;

@end
