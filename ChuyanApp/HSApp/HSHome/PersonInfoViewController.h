//
//  PersonInfoViewController.h
//  HSApp
//
//  Created by xc on 15/11/6.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "UserInfoSaveModel.h"

#import "UIImageView+MJWebCache.h"

@interface PersonInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (void)getPersonalInfo;

@end
