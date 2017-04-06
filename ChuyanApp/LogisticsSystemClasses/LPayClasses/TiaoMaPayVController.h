//
//  TiaoMaPayVController.h
//  HSApp
//
//  Created by cbwl on 16/10/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import  "publicResource.h"
#import "iToast.h"

@interface TiaoMaPayVController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
}


@property (nonatomic,copy)NSString *signName;

@property (nonatomic,copy)NSString *dataImage;
@property (nonatomic,assign)float money;
@property (nonatomic,assign)int signType;//1 本人签收 2他人签收 3自提柜
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic,strong) Out_LOrderDetailBody *tempModel;

@end
