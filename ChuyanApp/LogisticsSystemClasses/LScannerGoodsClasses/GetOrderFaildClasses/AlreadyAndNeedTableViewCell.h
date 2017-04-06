//
//  AlreadyAndNeedTableViewCell.h
//  HSApp
//
//  Created by cbwl on 16/5/2.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetModel.h"
#import "DataModels.h"
@interface AlreadyAndNeedTableViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *AlreadyBack;

@property (nonatomic, strong) UILabel *NeedLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *line2;
@property (nonatomic, assign) id delegate;

- (void)setDataWithMode:(CYNSObject*)model;


@end
