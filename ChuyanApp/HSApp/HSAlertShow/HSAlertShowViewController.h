//
//  HSAlertShowViewController.h
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "communcation.h"

@protocol AlertShowDelegate <NSObject>

- (void)confirmBtnClick;
- (void)cancelBtnClick;

@end


@interface HSAlertShowViewController : UIViewController

@property (nonatomic, strong) id<AlertShowDelegate>delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancelBtn;


- (void)setDataWithTitle:(NSString*)title andDetail:(NSString*)detail andConfirmBtnTitle:(NSString*)confirmBtnTitle andCancelBtnTitle:(NSString*)cancelBtnTitle;

@end
