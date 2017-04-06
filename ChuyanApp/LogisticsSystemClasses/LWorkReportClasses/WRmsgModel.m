//
//  WRmsgModel.m
//  HSApp
//
//  Created by cbwl on 16/5/19.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "WRmsgModel.h"

@implementation WRmsgModel
-(void)getmasgWithArray:(NSDictionary *)dic{
    self.totalcount=[dic objectForKey:@"alipay"];
    
////        self.totalmoney=(double)[dic objectForKey:@"cash"];
//    self.checkedmoney=(double)[dic objectForKey:@"checkedmoney"];
//    self.exptcount=[dic objectForKey:@"exptcount"];
////        self.totalcount=[dic objectForKey:@"paybackfee"];
////        self.totalcount=[dic objectForKey:@"payedfee"];
//        self.payfee=[dic objectForKey:@"payfee"];
////    self.totalcount=[dic objectForKey:@"pos"];
////    self.totalcount=[dic objectForKey:@"successcount"];
////        self.totalcount=[dic objectForKey:@"totalcount"];
//    
//    self.totalmoney=[dic objectForKey:@"totalmoney"];
//    self.uncheckedmoney=[dic objectForKey:@"uncheckedmoney"];
////    self.totalcount=[dic objectForKey:@"yifuTuiFee"];
//    
//    
    /*
     
     @property int totalcount;
     @property int successcount;
     @property int exptcount;
     @property double totalmoney;
     @property double checkedmoney;
     @property double uncheckedmoney;
     @property double payfee;
     @property double yifuTuiFee;
     @property double payedFee;*/
}
@end
