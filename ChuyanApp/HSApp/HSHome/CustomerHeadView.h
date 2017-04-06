//
//  CustomerHeadView.h
//  HSApp
//
//  Created by xc on 15/11/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "publicResource.h"

#define FuncButtonWidth 60.0

typedef NS_ENUM(NSInteger, CFuncType)//雇主功能类型
{
    CFuncType_List,//雇主功能类型-呼单圈
    CFuncType_Work,//雇主功能类型-呼单
    CFuncType_Comment,//雇主功能类型-评价
};

typedef NS_ENUM(NSInteger, CDetailFuncType)//雇主功能类型
{
    CDetailFuncType_Order,//子菜单功能类型-呼单中
    CDetailFuncType_History,//子菜单功能类型-呼单历史
    CDetailFuncType_ToBrokerComment,//子菜单功能类型-我对经纪人评价
    CDetailFuncType_ToUserComment,//子菜单功能类型-经纪人对我评价
};

@protocol CustomerHeadDelegate <NSObject>

- (void)headOrderListClick;
- (void)headOrderWorkClick;
- (void)headOrderCommentClick;

- (void)cDetailFuncClick:(CDetailFuncType)type;

@end

@interface CustomerHeadView : UIView


@property (nonatomic, strong) UIButton *orderListBtn;
@property (nonatomic, strong) UIButton *orderWorkBtn;
@property (nonatomic, strong) UIButton *commentBtn;


@property (nonatomic, assign) CFuncType nowType;//当前雇主功能类型
@property (nonatomic, strong) id<CustomerHeadDelegate>delegate;
@property (nonatomic, strong) UIView *line;
@end
