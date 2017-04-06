//
//  WRmsgModel.h
//  HSApp
//
//  Created by cbwl on 16/5/19.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRmsgModel : NSObject
@property int totalcount;
@property int successcount;
@property int exptcount;
@property double totalmoney;
@property double checkedmoney;
@property double uncheckedmoney;
@property double payfee;
@property double yifuTuiFee;
@property double payedFee;
-(void)getmasgWithArray:(NSDictionary *)dic;
@end
