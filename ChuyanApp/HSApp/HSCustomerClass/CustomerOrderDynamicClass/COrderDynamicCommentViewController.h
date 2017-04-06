//
//  COrderDynamicCommentViewController.h
//  HSApp
//
//  Created by xc on 16/1/6.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"

@protocol DynamicCommentDelegate <NSObject>

- (void)cancelDynamicComment;
- (void)addDynamciCommentWithContent:(NSString*)content AndParent_comment_id:(NSString*)parent_comment_id;

@end

@interface COrderDynamicCommentViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) id<DynamicCommentDelegate>delegate;

@property (nonatomic, strong) UITextView *demandTextView;//文字内容
@property (nonatomic,strong) UILabel *placeLabel;//默认内容
@property (nonatomic, strong) UIButton *cancelComment;
@property (nonatomic, strong) UIButton *publishComment;

@property (nonatomic, strong) NSString *parent_comment_id;
@property (nonatomic, strong) NSString *placeString;

@end
