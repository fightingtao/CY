//
//  BtnAndLabelView.h
//  Parking
//
//  Created by iosdev on 15/5/31.
//  Copyright (c) 2015年 cudatec. All rights reserved.
//
#define TextColor   [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]

#import <UIKit/UIKit.h>

@class BtnAndLabelView;

@protocol BtnAndLableDelegate <NSObject>

- (void)btnAndLabelClicked:(BtnAndLabelView *)selectView;

@end

@interface BtnAndLabelView :UIView
{

}
@property (nonatomic, strong) UIImageView *btnImage;
@property (nonatomic, strong) UILabel   *btnTitleLabel;
@property (nonatomic, assign) id<BtnAndLableDelegate> delegate;

- (void)setImgWith:(UIImage *)img WithTitle:(NSString *)title;
@end
