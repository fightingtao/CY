//
//  CustomerHeadView.m
//  HSApp
//
//  Created by xc on 15/11/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CustomerHeadView.h"

@interface CustomerHeadView ()



//呼单子菜单
@property (nonatomic, strong) UIButton *orderIngBtn;//呼单中
@property (nonatomic, strong) UIButton *historyOrderBtn;//历史订单
//评价子菜单
@property (nonatomic, strong) UIButton *toBrokerCommentBtn;//我的评价
@property (nonatomic, strong) UIButton *toUserCommentBtn;//对我评价

@end

@implementation CustomerHeadView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!_orderListBtn) {
        _orderListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderListBtn setTitle:@"呼单圈" forState:UIControlStateNormal];
        [_orderListBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _orderListBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*3)/4,0, FuncButtonWidth, 40);
        [_orderListBtn addTarget:self action:@selector(orderListBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _orderListBtn.titleLabel.font = MiddleFont;
        [self addSubview:_orderListBtn];
    }
    if (!_orderWorkBtn) {
        _orderWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderWorkBtn setTitle:@"我的呼单" forState:UIControlStateNormal];
        [_orderWorkBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderWorkBtn.frame = CGRectMake((SCREEN_WIDTH-FuncButtonWidth*3)/4*2+FuncButtonWidth,0, FuncButtonWidth+5, 40);
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
    
    if (!_orderIngBtn) {
        _orderIngBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderIngBtn setTitle:@"呼单中" forState:UIControlStateNormal];
        [_orderIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectZero;
        _orderIngBtn.titleLabel.font = MiddleFont;
        [_orderIngBtn addTarget:self action:@selector(cDetailOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_orderIngBtn];
    }
    
    if (!_historyOrderBtn) {
        _historyOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyOrderBtn setTitle:@"历史呼单" forState:UIControlStateNormal];
        [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _historyOrderBtn.frame = CGRectZero;
        _historyOrderBtn.titleLabel.font = MiddleFont;
        [_historyOrderBtn addTarget:self action:@selector(cDetailHistoryClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_historyOrderBtn];
    }
    
    if (!_toBrokerCommentBtn) {
        _toBrokerCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toBrokerCommentBtn setTitle:@"我对经纪人" forState:UIControlStateNormal];
        [_toBrokerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toBrokerCommentBtn.frame = CGRectZero;
        _toBrokerCommentBtn.titleLabel.font = MiddleFont;
        [_toBrokerCommentBtn addTarget:self action:@selector(cDetailToBrokerClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_toBrokerCommentBtn];
    }
    
    
    if (!_toUserCommentBtn) {
        _toUserCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toUserCommentBtn setTitle:@"经纪人对我" forState:UIControlStateNormal];
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

    _nowType = CFuncType_List;
    return self;
}

- (void)orderListBtnClick
{
    if (_nowType == CFuncType_List) {
        return;
    }else
    {
        [self.delegate headOrderListClick];
        //主菜单处理
        [_orderListBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [_orderWorkBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        [_commentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        
        _nowType = CFuncType_List;
    }
}


- (void)orderWorkBtnClick
{
    if (_nowType == CFuncType_Work) {
        return;
    }else
    {
        [self.delegate headOrderWorkClick];
        
        //子菜单处理
        [_orderIngBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3, 40, 80, 40);
        
        [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _historyOrderBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3*2+80, 40, 80, 40);
        
        [_toBrokerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toBrokerCommentBtn.frame = CGRectZero;
        
        [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toUserCommentBtn.frame = CGRectZero;
        
        _nowType = CFuncType_Work;

    }
}


- (void)commentBtnClick
{
    if (_nowType == CFuncType_Comment) {
        return;
    }else
    {

        //子菜单处理
        [_orderIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _orderIngBtn.frame = CGRectZero;
        
        [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _historyOrderBtn.frame = CGRectZero;
        
        [_toBrokerCommentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        _toBrokerCommentBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3, 40, 80, 40);
        
        [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
        _toUserCommentBtn.frame = CGRectMake((SCREEN_WIDTH-80*2)/3*2+80, 40, 80, 40);
        
        
        [self.delegate headOrderCommentClick];
        _nowType = CFuncType_Comment;
    }
    
}


- (void)cDetailOrderClick
{
    [_orderIngBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_historyOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate cDetailFuncClick:CDetailFuncType_Order];
}


- (void)cDetailHistoryClick
{
    [_orderIngBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_historyOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.delegate cDetailFuncClick:CDetailFuncType_History];
}


- (void)cDetailToBrokerClick
{
    [_toBrokerCommentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [_toUserCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [self.delegate cDetailFuncClick:CDetailFuncType_ToBrokerComment];
}


- (void)cDetailToUserClick
{
    [_toBrokerCommentBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
    [_toUserCommentBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.delegate cDetailFuncClick:CDetailFuncType_ToUserComment];
}

@end
