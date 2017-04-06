//
//  ImgBrowser.h
//  ImageBrowser
//
//  Created by 1217 on 15/11/10.
//  Copyright © 2015年 路. All rights reserved.
//

#define TITLELABELFONT 17                           //标题字体大小。
#define BLACKVIEWALPHA 1                            //黑色背景透明度。
#define ANIMATIONDURATION 0.2                       //弹出动画时间
#define HIDDENANIMATIONDURATION 0.2                 //隐藏IB动画时间。
#define SHOWPLACEHOLDERIMG @"bg_logo.png"                          //占位图
#define Img(a) [UIImage imageNamed:a]

#import <UIKit/UIKit.h>

@protocol ImgBrowserDelegate <NSObject>

- (void)browsefinish:(UIImage *)selectImg;

@end

@interface ImgBrowser : UIView <UIScrollViewDelegate>

///图片url数组
@property (nonatomic,retain)NSArray *imgaeArray;
///点击图片index
@property (nonatomic,assign)int currentIndex;


@property (nonatomic,retain)id <ImgBrowserDelegate>delegate;

- (id)init;
- (void)show;
- (void)setImgaeArray:(NSArray *)imgaeArray AndType:(int)type;

@end

