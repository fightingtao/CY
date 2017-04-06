//
//  workReportModel.h
//  HSApp
//
//  Created by cbwl on 16/5/19.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "workReportModel.h"
@interface workReportModel : NSObject
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) int code;
-(void)getMessageWithdic:(NSDictionary *)dic;
@end
