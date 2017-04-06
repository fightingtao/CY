//
//  PersonalListTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#define PersonalListCellHeight 40.0

@interface PersonalListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *contentLable;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UILabel *ThreeTiShi;
@property (nonatomic, strong) UILabel *BrokerLable;
@property (nonatomic, strong) UILabel *QiYeLable;

- (void)YuAndHongAndTi;
- (void)BrokerLableWithMessage:(int)IntState;
- (void)QiYeLableWithMessage:(int)IntState;

@end
