//
//  BrokerTestViewController.h
//  HSApp
//
//  Created by xc on 15/12/7.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "communcation.h"

@protocol CompleteTestDelegate <NSObject>

- (void)completeTestWithStatus:(int)status;//0是未通过，1是通过

@end

@interface BrokerTestViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) id<CompleteTestDelegate>delegate;

@property int testAnswer;

@property (nonatomic, strong) NSString *questionString;
@property int correctString;
@property int index;
@property BOOL allCorrect;

@end
