//
//  ScanningViewController.h
//  CXScanning
//
//  Created by artifeng on 16/1/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "publicResource.h"

@protocol ScannerSearchDelegate <NSObject>

- (void)scannerSearchWithResult:(NSString*)result;

@end


@interface ScanningViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
}

@property (nonatomic, strong) id<ScannerSearchDelegate>delegate;

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;



@end
