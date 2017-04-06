//
//  PublishOrderViewController.h
//  HSApp
//
//  Created by xc on 15/11/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "DoImagePickerController.h"
#import "iToast.h"
#import "AssetHelper.h"
#import "ImgBrowser.h"
#import "communcation.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

#import <AVFoundation/AVFoundation.h>
#import "VoiceConverter.h"

#import <TAESDK/TAESDK.h>
#import <ALBBMediaService/ALBBMediaService.h>
#import <ALBBMediaService/ALBBMediaServiceProtocol.h>


typedef NS_ENUM(NSInteger, OrderPublishType)//呼单类型
{
    OrderPublishType_TxtOrder,//呼单类型-文字
    OrderPublishType_VoiceOrder,//呼单类型-语音
};

typedef NS_ENUM(NSInteger, OrderType)//呼单类型
{
    OrderType_DaiG,//呼单类型-代购
    OrderType_DaiS,//呼单类型-代送
    OrderType_DaiB,//呼单类型-代办
};

@interface PublishOrderViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) OrderPublishType publishType;

@property (nonatomic, strong) NSString *voicePath;
@property int voiceTime;

@property int type;

@property (nonatomic, strong)NSString *placeString;
@property (nonatomic,strong) UILabel *placeLabel;//默认内容
@property (nonatomic, strong) OutTypeBody *tempDefaultType;//默认内容的类型

@end
