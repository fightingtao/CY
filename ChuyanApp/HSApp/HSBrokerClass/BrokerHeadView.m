//
//  BrokerHeadView.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BrokerHeadView.h"

@interface BrokerHeadView ()

@property (nonatomic, strong) UIButton *getOrderBtn;
@property (nonatomic, strong) UIButton *orderWorkBtn;
@property (nonatomic, strong) UIButton *commentBtn;

//抢单子菜单
@property (nonatomic, strong) UIButton *getAllOrderBtn;
@property (nonatomic, strong) UIButton *getDGOrderBtn;
@property (nonatomic, strong) UIButton *getDBOrderBtn;
@property (nonatomic, strong) UIButton *getDSOrderBtn;

//呼单子菜单
@property (nonatomic, strong) UIButton *orderIngBtn;//呼单中
@property (nonatomic, strong) UIButton *historyOrderBtn;//历史订单
//评价子菜单
@property (nonatomic, strong) UIButton *toCustomerCommentBtn;//我的评价
@property (nonatomic, strong) UIButton *toUserCommentBtn;//对我评价

@end


@implementation BrokerHeadView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!_getOrderBtn) {
        _getOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getOrderBtn setTitle:@"抢单▼" forState:UIControlStateNormal];
        [_getOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _getOrderBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*3)/4,0, FuncButtonWidth, 40);
        [_getOrderBtn addTarget:self action:@selector(orderListBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _getOrderBtn.titleLabel.font = MiddleFont;
        [self addSubview:_getOrderBtn];
    }
    
    if (!_orderWorkBtn) {
        _orderWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderWorkBtn setTitle:@"我的任务" forState:UIControlStateNormal];
        [_orderWorkBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderWorkBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*3)/4*2+FuncButtonWidth,0, FuncButtonWidth, 40);
        _orderWorkBtn.titleLabel.font = MiddleFont;
        [_orderWorkBtn addTarget:self action:@selector(orderWorkBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_orderWorkBtn];
    }
    
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _commentBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*3)/4*3+FuncButtonWidth*2,0, FuncButtonWidth, 40);
        _commentBtn.titleLabel.font = MiddleFont;
        [_commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentBtn];
    }
    
    
    if (!_getAllOrderBtn) {
        _getAllOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getAllOrderBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_getAllOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectZero;
        _getAllOrderBtn.titleLabel.font = MiddleFont;
        [_getAllOrderBtn addTarget:self action:@selector(getAllOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getAllOrderBtn];
    }
    
    if (!_getDGOrderBtn) {
        _getDGOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getDGOrderBtn setTitle:@"代购" forState:UIControlStateNormal];
        [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDGOrderBtn.frame = CGRectZero;
        _getDGOrderBtn.titleLabel.font = MiddleFont;
        [_getDGOrderBtn addTarget:self action:@selector(getDGOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getDGOrderBtn];
    }
    
    
    if (!_getDSOrderBtn) {
        _getDSOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getDSOrderBtn setTitle:@"代送" forState:UIControlStateNormal];
        [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDSOrderBtn.frame = CGRectZero;
        _getDSOrderBtn.titleLabel.font = MiddleFont;
        [_getDSOrderBtn addTarget:self action:@selector(getDSOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getDSOrderBtn];
    }
    
    if (!_getDBOrderBtn) {
        _getDBOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getDBOrderBtn setTitle:@"代办" forState:UIControlStateNormal];
        [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDBOrderBtn.frame = CGRectZero;
        _getDBOrderBtn.titleLabel.font = MiddleFont;
        [_getDBOrderBtn addTarget:self action:@selector(getDBOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getDBOrderBtn];
    }
    
    
    
    if (!_orderIngBtn) {
        _orderIngBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderIngBtn setTitle:@"任务中" forState:UIControlStateNormal];
        [_orderIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectZero;
        _orderIngBtn.titleLabel.font = MiddleFont;
        [_orderIngBtn addTarget:self action:@selector(cDetailOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_orderIngBtn];
    }
    
    if (!_historyOrderBtn) {
        _historyOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyOrderBtn setTitle:@"历史任务" forState:UIControlStateNormal];
        [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _historyOrderBtn.frame = CGRectZero;
        _historyOrderBtn.titleLabel.font = MiddleFont;
        [_historyOrderBtn addTarget:self action:@selector(cDetailHistoryClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_historyOrderBtn];
    }
    
    if (!_toCustomerCommentBtn) {
        _toCustomerCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toCustomerCommentBtn setTitle:@"我对雇主" forState:UIControlStateNormal];
        [_toCustomerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toCustomerCommentBtn.frame = CGRectZero;
        _toCustomerCommentBtn.titleLabel.font = MiddleFont;
        [_toCustomerCommentBtn addTarget:self action:@selector(cDetailToBrokerClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_toCustomerCommentBtn];
    }
    
    
    if (!_toUserCommentBtn) {
        _toUserCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toUserCommentBtn setTitle:@"雇主对我" forState:UIControlStateNormal];
        [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toUserCommentBtn.frame = CGRectZero;
        _toUserCommentBtn.titleLabel.font = MiddleFont;
        [_toUserCommentBtn addTarget:self action:@selector(cDetailToUserClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_toUserCommentBtn];
    }
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
        _line.backgroundColor = LineColor;
        [self addSubview:_line];
    }
    
    [_getAllOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _getAllOrderBtn.frame = CGRectMake((SCREEN_WIDTH-50*4)/5, 40, FuncButtonWidth, 40);
    
    [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _getDGOrderBtn.frame = CGRectMake((SCREEN_WIDTH-50*4)/5*2+FuncButtonWidth, 40, FuncButtonWidth, 40);
    
    [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _getDSOrderBtn.frame = CGRectMake((SCREEN_WIDTH-50*4)/5*3+FuncButtonWidth*2, 40, FuncButtonWidth, 40);
    
    [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _getDBOrderBtn.frame = CGRectMake((SCREEN_WIDTH-50*4)/5*4+FuncButtonWidth*3, 40, FuncButtonWidth, 40);
    
    _nowType = BFuncType_GetOrder;
    _nowDetailType = BDetailFuncType_GetAll;
    return self;
}


- (void)orderListBtnClick
{
    [self.delegate headOrderListClick];
    
    //主菜单处理
    [_getOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_orderWorkBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_commentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    
    //子菜单处理
    [_getAllOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _getAllOrderBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*4)/5, 40, FuncButtonWidth, 40);
    
    [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _getDGOrderBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*4)/5*2+FuncButtonWidth, 40, FuncButtonWidth, 40);
    
    [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _getDSOrderBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*4)/5*3+FuncButtonWidth*2, 40, FuncButtonWidth, 40);
    
    [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _getDBOrderBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*4)/5*4+FuncButtonWidth*3, 40, FuncButtonWidth, 40);
    
    [_orderIngBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _orderIngBtn.frame = CGRectZero;
    
    [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _historyOrderBtn.frame = CGRectZero;
    
    [_toCustomerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _toCustomerCommentBtn.frame = CGRectZero;
    
    [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    _toUserCommentBtn.frame = CGRectZero;
    
    _nowType = BFuncType_GetOrder;
    _nowDetailType = BDetailFuncType_GetAll;
}


- (void)orderWorkBtnClick
{
    if (_nowType == BFuncType_OrderIng) {
        return;
    }else
    {
        
        [self.delegate headOrderWorkClick];
        
        //主菜单处理
        [_getOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_orderWorkBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [_commentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        
        //子菜单处理
        
        [_getAllOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _getAllOrderBtn.frame = CGRectZero;
        
        [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDGOrderBtn.frame = CGRectZero;
        
        [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDSOrderBtn.frame = CGRectZero;
        
        [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDBOrderBtn.frame = CGRectZero;

        
        [_orderIngBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3, 40, 80, 40);
        
        [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _historyOrderBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3*2+80, 40, 80, 40);
        
        [_toCustomerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toCustomerCommentBtn.frame = CGRectZero;
        
        [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toUserCommentBtn.frame = CGRectZero;

        _nowType = BFuncType_OrderIng;
        _nowDetailType = BDetailFuncType_OrderIng;
        
    }
}


- (void)commentBtnClick
{
    if (_nowType == BFuncType_Comment) {
        return;
    }else
    {
        [self.delegate headOrderCommentClick];
        
        //主菜单处理
        [_getOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_orderWorkBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_commentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        
        
        //子菜单处理
        
        [_getAllOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _getAllOrderBtn.frame = CGRectZero;
        
        [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDGOrderBtn.frame = CGRectZero;
        
        [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDSOrderBtn.frame = CGRectZero;
        
        [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _getDBOrderBtn.frame = CGRectZero;
        
        [_orderIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectZero;
        
        [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _historyOrderBtn.frame = CGRectZero;
        
        [_toCustomerCommentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _toCustomerCommentBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3, 40, 80, 40);
        
        [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toUserCommentBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3*2+80, 40, 80, 40);

        _nowType = BFuncType_Comment;
        _nowDetailType = BDetailFuncType_ToCustomerComment;
    }
    
}

//获取全部订单
- (void)getAllOrderClick
{
    [_getAllOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];

    [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];

    [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_GetAll];
}

//获取代购订单
- (void)getDGOrderClick
{
    [_getAllOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDGOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_GetDG];
}

//获取代送订单
- (void)getDSOrderClick
{
    [_getAllOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDSOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    [_getDBOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_GetDS];
}

//获取代办订单
- (void)getDBOrderClick
{
    [_getAllOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDGOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDSOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    
    [_getDBOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_GetDB];
}

//获取任务中
- (void)cDetailOrderClick
{
    [_orderIngBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_OrderIng];
}

//获取历史订单
- (void)cDetailHistoryClick
{
    [_orderIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_historyOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_History];
}

//获取我对雇主评价
- (void)cDetailToBrokerClick
{
    [_toCustomerCommentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_ToCustomerComment];
}

//获取对我评价
- (void)cDetailToUserClick
{
    [_toCustomerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_toUserCommentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.delegate bDetailFuncClick:BDetailFuncType_ToUserComment];
}


@end
