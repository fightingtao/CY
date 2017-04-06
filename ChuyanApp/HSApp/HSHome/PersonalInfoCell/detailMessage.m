//
//  detailMessage.m
//  HSApp
//
//  Created by cbwl on 16/5/29.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "detailMessage.h"

@implementation detailMessage
-(void)getMessageWithDic:(NSDictionary *)dic{
//    @property int code;
//    @property (nonatomic, strong) NSString <Optional>*message;
//    @property (nonatomic, strong) Out_LOrderDetailBody  *data;
    
    Out_LOrderDetailModel *model=[[Out_LOrderDetailModel alloc]init];
    model.code=[[dic objectForKey:@"code"] intValue];
    
}
@end
