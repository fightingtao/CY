//
//  CommonAddressTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/17.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "NetModel.h"

@interface CommonAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameAndPhoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

- (void)setAddressDataWithModel:(OutAddressBody*)model;

@end
