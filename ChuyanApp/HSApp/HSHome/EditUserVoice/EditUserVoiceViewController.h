//
//  EditUserVoiceViewController.h
//  HSApp
//
//  Created by xc on 15/11/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "communcation.h"
#import "UserInfoSaveModel.h"
#import "iToast.h"
#import "MBProgressHUD.h"

@interface EditUserVoiceViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) UITextView *demandTextView;//文字需求内容
@property (nonatomic,strong) UILabel *placeLabel;//默认内容

@end
