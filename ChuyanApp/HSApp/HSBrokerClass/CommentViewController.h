//
//  CommentViewController.h
//  HSApp
//
//  Created by cbwl on 16/5/2.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetModel.h"
#import "IQKeyboardManager.h"

@interface CommentViewController : UIViewController <UITextViewDelegate>

@property (nonatomic,retain) OutHomeListBody *model;

@property (nonatomic,retain) Out_OrderDynamicBody *tempModel;

@property (nonatomic, strong) UITextView *demandTextView;//文字内容
@property (nonatomic,strong) UILabel *placeLabel;//默认内容
@property (nonatomic, strong) UIButton *cancelComment;
@property (nonatomic, strong) UIButton *publishComment;


@end
