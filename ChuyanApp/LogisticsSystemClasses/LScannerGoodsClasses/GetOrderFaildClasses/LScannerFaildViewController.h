//
//  LScannerFaildViewController.h
//  HSApp
//
//  Created by xc on 16/1/29.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"


#import "communcation.h"
#import "iToast.h"
#import "MBProgressHUD+Add.h"

@interface LScannerFaildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) Out_LScanGoodsBody *tempModel;

@end
