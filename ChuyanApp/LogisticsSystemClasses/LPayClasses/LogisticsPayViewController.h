//
//  LogisticsPayViewController.h
//  HSApp
//
//  Created by xc on 16/1/27.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "NetModel.h"

@interface LogisticsPayViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

{
    UIAlertView *AlertViewOne;
}

@property (nonatomic,strong) Out_LOrderDetailBody *tempModel;
@property (nonatomic, copy) NSString *signmanOther;
@property (nonatomic, assign) int signmanTypeOther;
@property (nonatomic,assign )int signType;//1 benrbe本人  2 他人签收 3 自提柜
@end
