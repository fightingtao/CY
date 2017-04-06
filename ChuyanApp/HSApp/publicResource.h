//
//  publicResource.h
//  Shipper
//
//  Created by xc on 15/9/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

//#ifndef Shipper_publicResource_h
//#define Shipper_publicResource_h
//
//
//#endif
/*!
 *   @author XC, 15-09-07 18:09:14
 *
 *   @brief  主要存放公共参数及固定参数
 *
 *   @since 1。0
 */
//#ifdef DEBUG
//#ifndef DLog
//#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
//#endif
//#ifndef ELog
//#   define ELog(err) {if(err) DLog(@"%@", err)}
//#endif
//#else
//#ifndef DLog
//#   define DLog(...)
//#endif
//#ifndef ELog
//#   define ELog(err)
//#endif
//#endif


#ifdef DEBUG
#define DLog(FORMAT, ...) fprintf(stderr,"类名:%s-行数:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NSSLog(...)

#endif

//屏幕宽度和高度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//主色调
#define MAINCOLOR [UIColor colorWithRed:235.0/255.0 green:97.0/255.0 blue:59.0/255.0 alpha:1]
//textmaincolor
#define TextMainCOLOR [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1]

//textdetailcolor
#define TextDetailCOLOR [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1]

//textdetailcolor
#define OrderTextCOLOR [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1]

#define ButtonBGCOLOR [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1]

//view背景色
#define ViewBgColor   [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]

#define LineColor   [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0]

#define WhiteBgColor  [UIColor whiteColor]

#define DaiSongColor  [UIColor colorWithRed:255.0/255.0 green:157.0/255.0 blue:44.0/255.0 alpha:1]
#define DaiGouColor  [UIColor colorWithRed:57.0/255.0 green:173.0/255.0 blue:54.0/255.0 alpha:1]
#define DaiBanColor  [UIColor colorWithRed:27.0/255.0 green:107.0/255.0 blue:165.0/255.0 alpha:1]



//雏燕个人端 (雇主和经纪人) 地址
//#define HOSTURL @"http://114.55.4.51:8082/hsconsumer/"  // 开发

//#define HOSTURL @"http://172.16.18.250:8082/hsconsumer/"  // Y 内网
#define HOSTURL @"http://120.27.186.69:8082/hsconsumer/"   // W 外网
//#define HOSTURL @"http://120.55.97.31:8082/hsconsumer/"   // 阿里云

//雏燕企业 (工作) 地址
//#define LogisticsHOSTURL @"http://172.168.35.252:8082/hs-deliveryconsumer"  // L
#define LogisticsHOSTURL @"http://118.178.32.241:8082/hs-deliveryconsumer"  // W
//#define LogisticsHOSTURL @"http://120.55.97.31:8082/hs-deliveryconsumer"  // 阿里云

//修改企业认证密码
//#define changePswHOSTURL @"120.55.66.176:8080/hs-deliveryserver/user/updateThirdPasswordForApp"  // W

//雏燕经纪人管理制度网络请求地址
#define BrokerInstitutionTURL @"http://172.16.18.88/hsdata/institution"

//雏燕用户成就网络请求地址
#define UserAchieveURL @"http://172.16.18.88/hsdata/success?userid="
/*
#pragma mark ********************************************
#pragma mark 对接接口

#pragma mark ********************************************

 */
#define PLACEHOLDERIMG @"home_def_head-portrait"          //占位图
#define PlaceHoldHeadImg(a) [UIImage imageNamed:a]

//字体
#define LargeFont   [UIFont systemFontOfSize:16.0]
#define MiddleFont   [UIFont systemFontOfSize:15.0]
#define LittleFont   [UIFont systemFontOfSize:14.0]
#define WideFont [UIFont fontWithName:@"Helvetica-Bold" size:15.0]


//推送
#define PushNotifyName     @"Push"
#import "NetModel.h"
#import "communcation.h"
#import "UIView+SDAutoLayout.h"

///版本号
#define kVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

