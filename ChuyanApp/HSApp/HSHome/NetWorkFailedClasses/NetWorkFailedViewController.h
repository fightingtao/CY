//
//  NetWorkFailedViewController.h
//  HSApp
//
//  Created by xc on 16/2/1.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "publicResource.h"
#import "communcation.h"


@protocol NetWorkReloadDelegate <NSObject>

- (void)netWorkReload;

@end

@interface NetWorkFailedViewController : UIViewController

@property (nonatomic, strong) id<NetWorkReloadDelegate>delegate;

@property (nonatomic, strong) UIImageView *errorImgview;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *reloadBtn;

@end
