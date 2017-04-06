//
//  LScannerViewController.h
//  HSApp
//
//  Created by xc on 16/1/19.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "iToast.h"
#import <AVFoundation/AVFoundation.h>

#import "communcation.h"
#import "iToast.h"
#import "MBProgressHUD+Add.h"

@interface LScannerViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
    
}



@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic,assign) int type;// 2 领货 4到货

@end
