//
//  CustomerCommentViewController.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "communcation.h"

@protocol CommentSuccessDelegate <NSObject>

- (void)commentSuccessBackRefresh;

@end

@interface CustomerCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) id<CommentSuccessDelegate>delegate;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *orderId;
@end
