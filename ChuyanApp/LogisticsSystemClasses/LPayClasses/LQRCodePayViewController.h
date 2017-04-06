//
//  LQRCodePayViewController.h
//  HSApp
//
//  Created by xc on 16/2/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

@interface LQRCodePayViewController : UIViewController <UIAlertViewDelegate>
@property (nonatomic,copy)NSString *signName;

@property (nonatomic,copy)NSString *dataImage;
@property (nonatomic,assign)float money;
@property (nonatomic,assign)int signType;//1 本人签收 2他人签收 3自提柜
@property (nonatomic,strong) Out_LOrderDetailBody *tempModel;

@end
