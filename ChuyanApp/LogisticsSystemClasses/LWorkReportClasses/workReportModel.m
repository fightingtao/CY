//
//  workReportModel.m
//  HSApp
//
//  Created by cbwl on 16/5/19.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "workReportModel.h"

@implementation workReportModel
-(void)getMessageWithdic:(NSDictionary *)dic{
    if (dic) {
        self.code=(int)[dic objectForKey:@"code"];
        self.data=[dic objectForKey:@"data"];
        
    }
    
}
@end
