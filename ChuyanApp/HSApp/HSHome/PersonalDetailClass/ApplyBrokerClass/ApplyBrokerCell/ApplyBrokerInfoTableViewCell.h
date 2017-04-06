//
//  ApplyBrokerInfoTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#define CellViewHeight 150.0
#define LeftBackViewHeight 20.0*(SCREEN_WIDTH/320.0)


@protocol ApplyInfoDelegate <NSObject>

- (void)setAgentInfo:(NSString *)string andType:(int)type;

@end

@interface ApplyBrokerInfoTableViewCell : UITableViewCell<UITextFieldDelegate>


@property (nonatomic, strong) id<ApplyInfoDelegate>delegate;
+(CGFloat)cellHeight;

@end
