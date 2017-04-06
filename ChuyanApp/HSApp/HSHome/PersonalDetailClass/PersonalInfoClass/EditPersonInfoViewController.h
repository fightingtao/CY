//
//  EditPersonInfoViewController.h
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"

@protocol UpdateNameDelegate <NSObject>

- (void)updateUserNameWith:(NSString*)nameString;

@end

@interface EditPersonInfoViewController : UIViewController

@property (nonatomic, strong) id<UpdateNameDelegate>delegate;
@property (nonatomic, strong) UITextField *nickNameTxt;

@end
