//
//  ApplyBrokerViewController.h
//  HSApp
//
//  Created by xc on 15/11/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"
#import "AppDelegate.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "communcation.h"


#import <TAESDK/TAESDK.h>
#import <ALBBMediaService/ALBBMediaService.h>
#import <ALBBMediaService/ALBBMediaServiceProtocol.h>

@interface ApplyBrokerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property BOOL isRootVC;

@end
