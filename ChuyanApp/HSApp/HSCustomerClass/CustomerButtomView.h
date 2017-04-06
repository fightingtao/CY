//
//  CustomerButtomView.h
//  HSApp
//
//  Created by xc on 15/11/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

@protocol PublishDemandDelegate <NSObject>

- (void)publishTextDemand;
- (void)startVoiceDemand;
- (void)endVoiceDemand;
- (void)cancelVoiceDemand;
@end

@interface CustomerButtomView : UIView

@property (nonatomic, strong) id<PublishDemandDelegate>delegate;

@property (nonatomic, strong) UIImageView *textImgView;//文字需求图片
@property (nonatomic, strong) UIImageView *voiceImgView;//语音需求图片
@property (nonatomic, strong) UILabel *tipLabel;//文字需求提示
@property (nonatomic, strong) UIButton *textDemandBtn;//文字需求按钮
@property (nonatomic, strong) UIButton *voiceDemandBtn;//语音需求按钮

@end
