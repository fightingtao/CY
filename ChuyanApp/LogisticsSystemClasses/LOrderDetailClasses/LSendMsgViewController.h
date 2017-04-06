//
//  LSendMsgViewController.h
//  HSApp
//
//  Created by xc on 16/2/16.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#import "communcation.h"
#import "iToast.h"
#import "MBProgressHUD+Add.h"
#import "UserInfoSaveModel.h"
@interface LSendMsgViewController : UIViewController<UITextViewDelegate>

//发送短信的手机号码和用户名
@property (nonatomic, strong) NSString *mobileStr;
@property (nonatomic, strong) NSString *nameStr;

@end
