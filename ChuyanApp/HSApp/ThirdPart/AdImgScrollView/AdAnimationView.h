//
//  AdAnimationView.h
//  MaTang
//
//  Created by iosdev on 15/6/10.
//  Copyright (c) 2015年 cudatec. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AD_PLACEHOLDERIMAGE_LARGE  [UIImage imageNamed:@"bg_logo.png"]
#define CHANGE_IMAGE_TIMEINTERVAL   3


@interface AdAniMationModel : NSObject //这个得根据相应系统做model
@property int advertid;
@property (nonatomic, strong) NSString *desc;
@property int type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *pic_path;
@property (nonatomic, strong) NSString *cityname;

@end

@protocol AdAnimationViewDelegate <NSObject>
//点击的哪一个返回
- (void)adHasSelect:(AdAniMationModel *)model;

@end

@interface AdAnimationView : UIView <UIGestureRecognizerDelegate>
{
    int _currentIndex;
    CATransition *transition;
}

@property (nonatomic, assign) id<AdAnimationViewDelegate> delegate;
@property (nonatomic, strong) NSArray   *modelArray;//这个可能需要根据接口返回数据，进行变更，要显示的广告集合

- (void)refreshShowWith:(NSArray *)showArray;//可能需要变更


@end
