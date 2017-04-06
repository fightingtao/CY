//
//  CommentBrokerContentTableViewCell.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "LHRatingView.h"


#define CBrokerContentCellHeigth 175.0

@protocol CommentContentDelegate <NSObject>

- (void)StarScore:(CGFloat)score;
- (void)commentContent:(NSString*)content;

@end

@interface CommentBrokerContentTableViewCell : UITableViewCell<UITextViewDelegate,ratingViewDelegate>
@property (nonatomic, strong) id<CommentContentDelegate>delegate;

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) LHRatingView * starView;
@property (nonatomic, strong) UITextView *demandTextView;//文字需求内容
@property (nonatomic,strong) UILabel *placeLabel;//默认内容


+ (CGFloat)cellHeight;

@end
