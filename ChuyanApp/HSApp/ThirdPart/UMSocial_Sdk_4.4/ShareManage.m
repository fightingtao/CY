//
//  ShareManage.m
//  KONKA_MARKET
//
//  Created by wxxu on 14/12/18.
//  Copyright (c) 2014年 archon. All rights reserved.
//  分享管理

#import "ShareManage.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "AppDelegate.h"

@implementation ShareManage {
    UIViewController *_viewC;
}

static ShareManage *shareManage;

+ (ShareManage *)shareManage
{
    @synchronized(self)
    {
        if (shareManage == nil) {
            shareManage = [[self alloc] init];
        }
        return shareManage;
    }
}

#pragma mark 注册友盟分享微信
- (void)shareConfig
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMeng_APIKey];
    [UMSocialData openLog:YES];
    
    //注册微信
    [WXApi registerApp:WX_APP_KEY];
    //设置图文分享
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
}

#pragma mark 微信分享
- (void)wxShareWithViewControll
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
//    NSURL *iconURl=[NSURL URLWithString:imagePath];
   [UMSocialData defaultData].extConfig.wechatSessionData.title =  @"推荐一款让生活神马都能轻松的APP";
   [UMSocialData defaultData].extConfig.wechatSessionData.url  = @"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"享受明星生活，搭理生活琐事，就上云马闪配！" image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];

    
}

#pragma mark 新浪微博分享
- (void)wbShareWithViewControll
{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
//    //    NSURL *iconURl=[NSURL URLWithString:imagePath];
//    // [UMSocialData defaultData].extConfig.wechatTimelineData.title =  @"推荐一款让生活神马都能轻松的APP";
////    [UMSocialData defaultData].extConfig.sinaData.url  = @"https://itunes.apple.com/cn/app/yun-ma-shan-pei/id1121964709?mt=8";
//    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"推荐一款让生活神马都能轻松的APP 享受明星生活，搭理生活琐事，就上云马闪配！" image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
//        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
//        }
//    }];
    [UMSocialData openLog:YES];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
    //    NSURL *iconURl=[NSURL URLWithString:imagePath];
     [UMSocialData defaultData].extConfig.tencentData.title =  @"推荐一款让生活神马都能轻松的APP";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];

//    [UMSocialData defaultData].extConfig.tencentData.urlResource  = urlResource;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"推荐一款让生活神马都能轻松的APP 享受明星生活，搭理生活琐事，就上雏燕App！" image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];

 
}

#pragma mark 微信朋友圈分享
- (void)wxpyqShareWithViewControll
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
    //    NSURL *iconURl=[NSURL URLWithString:imagePath];
    // [UMSocialData defaultData].extConfig.wechatTimelineData.title =  @"推荐一款让生活神马都能轻松的APP";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url  = @"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"推荐一款让生活神马都能轻松的APP 享受明星生活，搭理生活琐事，就上雏燕App！" image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

#pragma mark QQ分享
- (void)QQShareWithViewControll
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
//    NSString *imagePath=@"http://image.baidu.com/detail/newindex?pid=34581995272&from=2&user_id=609919416&aid=412264399&column=&tag=&pn=0&is_album=1";
    //    NSURL *iconURl=[NSURL URLWithString:imagePath];
    [UMSocialData defaultData].extConfig.title = @"推荐一款让生活神马都能轻松的APP";
    [UMSocialData defaultData].extConfig.qqData.url = @"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"享受明星生活，搭理生活琐事，就上雏燕App！" image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
    
}
- (void)tensentShareWithViewControll
{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
    NSString *imagePath=@"http://image.baidu.com/detail/newindex?pid=34581995272&from=2&user_id=609919416&aid=412264399&column=&tag=&pn=0&is_album=1";

    //    NSURL *iconURl=[NSURL URLWithString:imagePath];
    [UMSocialData defaultData].extConfig.title = @"推荐一款让生活神马都能轻松的APP";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"https://itunes.apple.com/cn/app/chu-yan/id1102695904?mt=8";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imagePath];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"推荐一款让生活神马都能轻松的APP 享受明星生活，搭理生活琐事，就上雏燕App！" image:[UIImage imageNamed:@"icon.png"] location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
        
    }];

}
#pragma mark 短信的代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [_viewC dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MessageComposeResultCancelled:
            
            break;
        case MessageComposeResultSent:
            //@"感谢您的分享!"
            break;
        case MessageComposeResultFailed:
            
            break;
        default:
            break;
    }
}

- (void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.navigationBar.tintColor = [UIColor blackColor];
    //    picker.recipients = [NSArray arrayWithObject:@"10086"];
    picker.body = share_content;
    [_viewC presentViewController:picker animated:YES completion:nil];
}
@end
