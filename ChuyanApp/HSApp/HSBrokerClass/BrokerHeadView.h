//
//  BrokerHeadView.h
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#define FuncButtonWidth 60.0

typedef NS_ENUM(NSInteger, BFuncType)//经纪人功能类型
{
    BFuncType_GetOrder,//经纪人功能类型-呼单圈
    BFuncType_OrderIng,//经纪人功能类型-呼单
    BFuncType_Comment,//经纪人功能类型-评价
};

typedef NS_ENUM(NSInteger, BDetailFuncType)//经纪人子菜单功能类型
{
    BDetailFuncType_GetAll,//子菜单功能类型-全部订单
    BDetailFuncType_GetDG,//子菜单功能类型-代购订单
    BDetailFuncType_GetDB,//子菜单功能类型-代办订单
    BDetailFuncType_GetDS,//子菜单功能类型-代送订单
    BDetailFuncType_OrderIng,//子菜单功能类型-任务中
    BDetailFuncType_History,//子菜单功能类型-历史
    BDetailFuncType_ToCustomerComment,//子菜单功能类型-对用户评价
    BDetailFuncType_ToUserComment,//子菜单功能类型-对我评价
};

@protocol BrokerHeadDelegate <NSObject>

- (void)headOrderListClick;
- (void)headOrderWorkClick;
- (void)headOrderCommentClick;

- (void)bDetailFuncClick:(BDetailFuncType)temptype;

@end


@interface BrokerHeadView : UIView
@property (nonatomic, strong) id<BrokerHeadDelegate>delegate;
@property (nonatomic, assign) BFuncType nowType;//当前经纪人功能类型
@property (nonatomic, assign) BDetailFuncType nowDetailType;
@property (nonatomic, strong) UIView *line;

@end
