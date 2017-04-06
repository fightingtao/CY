//
//  DSTableViewCell.h
//  HSApp
//
//  Created by cbwl on 16/5/3.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *OrderIdLable;
@property (nonatomic, strong) UILabel *WaitLable;
@property (nonatomic, strong) UILabel *YuELable;
@property (nonatomic, strong) UILabel *NeedLable;

@property (nonatomic, strong) UIView *LineOne;
@property (nonatomic, strong) UIView *LineTwo;
@property (nonatomic, strong) UIView *LineThree;

- (void)ReturnDataWithDic:(NSDictionary *)Dic WithOrderid:(NSString *)orderid;

@end
