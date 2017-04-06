//
//  CHomeOrderIngTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CHomeOrderIngTableViewCell.h"

@interface CHomeOrderIngTableViewCell()

@property (nonatomic, strong) UIButton *chooseBrokerBtn;
@property (nonatomic, strong) UIButton *callBrokerBtn;
@property (nonatomic, strong) UIButton *moreFeesBtn;
@property (nonatomic, strong) UIButton *cancelOrderBtn;
@property (nonatomic, strong) UIButton *commetnBtn;
@property (nonatomic, strong) UIButton *payOrderBtn;
@property (nonatomic, strong) UIButton *confirmOrderBtn;

@end

@implementation CHomeOrderIngTableViewCell

@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_headView) {
            _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
            _headView.backgroundColor = ViewBgColor;
            [self addSubview:_headView];
        }
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, SCREEN_WIDTH/2-20, 20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:12];
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"2015-10-11";
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [_headView addSubview:_timeLabel];
        }
        
        if (!_statusLabel) {
            _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,0, SCREEN_WIDTH/2-20, 20)];
            _statusLabel.backgroundColor = [UIColor clearColor];
            _statusLabel.font = [UIFont systemFontOfSize:12];
            _statusLabel.textColor = TextDetailCOLOR;
            _statusLabel.text = @"已抢单";
            _statusLabel.textAlignment = NSTextAlignmentRight;
            [_headView addSubview:_statusLabel];
        }
        
        
//--------------------------------------------------------------------------------------------
        if (!_menuView) {
            _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, OrderIngCellHeigth-20)];
            _menuView.backgroundColor = WhiteBgColor;
            [self addSubview:_menuView];
        }
        
        if (!_orderTypeLabel) {
            _orderTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0.5, 20, 20)];
            _orderTypeLabel.backgroundColor = [UIColor clearColor];
            _orderTypeLabel.font = [UIFont systemFontOfSize:12];
            _orderTypeLabel.textColor = DaiSongColor;
            _orderTypeLabel.text = @"送";
            _orderTypeLabel.layer.borderColor = DaiSongColor.CGColor;
            _orderTypeLabel.layer.borderWidth = 0.5;
            _orderTypeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderTypeLabel.textAlignment = NSTextAlignmentCenter;
            [_menuView addSubview:_orderTypeLabel];
        }
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 20, 50, 50)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            _headImgView.layer.cornerRadius = 25;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            _headImgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)];
            [_headImgView addGestureRecognizer:singleTap1];
            [_menuView addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, 120, 30)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            [_menuView addSubview:_nameLabel];
        }
        
        if (!_orderContentLabel) {
            _orderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,15, SCREEN_WIDTH-140, 20)];
            _orderContentLabel.backgroundColor = [UIColor clearColor];
            _orderContentLabel.font = LittleFont;
            _orderContentLabel.textColor = TextMainCOLOR;
            _orderContentLabel.text = @"呼：";
            _orderContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _orderContentLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_orderContentLabel];
        }
        
        if (!_orderVoiceBtn) {
            _orderVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _orderVoiceBtn.frame = CGRectMake(150, 15, 20, 20);
            [_orderVoiceBtn addTarget:self action:@selector(voicePlayClick) forControlEvents:UIControlEventTouchUpInside];
            [_orderVoiceBtn setImage:[UIImage imageNamed:@"btn_voice"] forState:UIControlStateNormal];
            [_menuView addSubview:_orderVoiceBtn];
        }
        if (!_getAddressLabel) {
            _getAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,45, SCREEN_WIDTH-140, 20)];
            _getAddressLabel.backgroundColor = [UIColor clearColor];
            _getAddressLabel.font = LittleFont;
            _getAddressLabel.textColor = TextMainCOLOR;
            _getAddressLabel.text = @"取：长江贸易大楼";
            _getAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _getAddressLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_getAddressLabel];
        }
        
        if (!_sendAddressLabel) {
            _sendAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,75, SCREEN_WIDTH-140, 20)];
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.font = LittleFont;
            _sendAddressLabel.textColor = TextMainCOLOR;
            _sendAddressLabel.text = @"送：长江贸易大楼";
            _sendAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_sendAddressLabel];
        }
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, 1)];
            _line.backgroundColor = LineColor;
            [_menuView addSubview:_line];
        }
        
        if (!_line2) {
            _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 169, SCREEN_WIDTH, 1)];
            _line2.backgroundColor = LineColor;
            _line2.hidden = YES;
            [_menuView addSubview:_line2];
        }
        
        if (!_detailView) {
            _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, _menuView.frame.size.height-36, SCREEN_WIDTH, 36)];
            _detailView.backgroundColor = WhiteBgColor;
            [_menuView addSubview:_detailView];
        }
        if (!_tipsLabel) {
            _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(31,0, SCREEN_WIDTH/2, 36)];
            _tipsLabel.backgroundColor = [UIColor clearColor];
            _tipsLabel.font = LittleFont;
            _tipsLabel.textColor = [UIColor redColor];
            _tipsLabel.text = @"小费20元";
            _tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _tipsLabel.textAlignment = NSTextAlignmentLeft;
            [_detailView addSubview:_tipsLabel];
        }
        
        
        if (!_chooseBrokerBtn) {
            _chooseBrokerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _chooseBrokerBtn.frame = CGRectZero;
            [_chooseBrokerBtn addTarget:self action:@selector(chooseBrokerClick) forControlEvents:UIControlEventTouchUpInside];
            [_chooseBrokerBtn setTitle:@"选择经纪人" forState:UIControlStateNormal];
            [_chooseBrokerBtn setBackgroundColor:WhiteBgColor];
            [_chooseBrokerBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            _chooseBrokerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            _chooseBrokerBtn.layer.borderColor = TextMainCOLOR.CGColor;
            _chooseBrokerBtn.layer.borderWidth = 0.5;
            _chooseBrokerBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_chooseBrokerBtn];
        }
        
        if (!_callBrokerBtn) {
            _callBrokerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _callBrokerBtn.frame = CGRectZero;
            [_callBrokerBtn addTarget:self action:@selector(callBrokerClick) forControlEvents:UIControlEventTouchUpInside];
            [_callBrokerBtn setImage:[UIImage imageNamed:@"btn_callphone@2x"] forState:UIControlStateNormal];
            [_callBrokerBtn setBackgroundColor:WhiteBgColor];
            _callBrokerBtn.layer.borderColor = TextMainCOLOR.CGColor;
            _callBrokerBtn.layer.borderWidth = 0.5;
            _callBrokerBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_callBrokerBtn];
        }
        
        if (!_confirmOrderBtn) {
            _confirmOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _confirmOrderBtn.frame = CGRectZero;
            [_confirmOrderBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
            [_confirmOrderBtn setTitle:@"确认完成" forState:UIControlStateNormal];
            [_confirmOrderBtn setBackgroundColor:WhiteBgColor];
            _confirmOrderBtn.layer.borderColor = TextMainCOLOR.CGColor;
            _confirmOrderBtn.layer.borderWidth = 0.5;
            _confirmOrderBtn.layer.cornerRadius = 5;
            _confirmOrderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [_confirmOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            [_detailView addSubview:_confirmOrderBtn];
        }
        
        if (!_moreFeesBtn) {
            _moreFeesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _moreFeesBtn.frame = CGRectZero;
            [_moreFeesBtn addTarget:self action:@selector(moreFeesClick) forControlEvents:UIControlEventTouchUpInside];
            [_moreFeesBtn setTitle:@"追加小费" forState:UIControlStateNormal];
            [_moreFeesBtn setBackgroundColor:WhiteBgColor];
            [_moreFeesBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            _moreFeesBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            _moreFeesBtn.layer.borderColor = TextMainCOLOR.CGColor;
            _moreFeesBtn.layer.borderWidth = 0.5;
            _moreFeesBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_moreFeesBtn];
        }
        
        if (!_cancelOrderBtn) {
            _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _cancelOrderBtn.frame = CGRectZero;
            [_cancelOrderBtn addTarget:self action:@selector(cancelOrderClick) forControlEvents:UIControlEventTouchUpInside];
            [_cancelOrderBtn setTitle:@"取消呼单" forState:UIControlStateNormal];
            [_cancelOrderBtn setBackgroundColor:WhiteBgColor];
            [_cancelOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            _cancelOrderBtn.layer.borderColor = TextMainCOLOR.CGColor;
            _cancelOrderBtn.layer.borderWidth = 0.5;
            _cancelOrderBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_cancelOrderBtn];
        }
        
        if (!_commetnBtn) {
            _commetnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _commetnBtn.frame = CGRectZero;
            [_commetnBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
            [_commetnBtn setTitle:@"立即评价" forState:UIControlStateNormal];
            [_commetnBtn setBackgroundColor:WhiteBgColor];
            [_commetnBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            _commetnBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            _commetnBtn.layer.borderColor = MAINCOLOR.CGColor;
            _commetnBtn.layer.borderWidth = 0.5;
            _commetnBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_commetnBtn];
        }
        
        if (!_payOrderBtn) {
            _payOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _payOrderBtn.frame = CGRectZero;
            [_payOrderBtn addTarget:self action:@selector(payOrderClick) forControlEvents:UIControlEventTouchUpInside];
            [_payOrderBtn setTitle:@"立即付款" forState:UIControlStateNormal];
            [_payOrderBtn setBackgroundColor:WhiteBgColor];
            [_payOrderBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            _payOrderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            _payOrderBtn.layer.borderColor = MAINCOLOR.CGColor;
            _payOrderBtn.layer.borderWidth = 0.5;
            _payOrderBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_payOrderBtn];
        }
        //end
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (CGFloat)cellHeightWithModel:(Out_OrderIngListBody*)mode
{
    if (mode.picpaths&&[mode.picpaths count] > 0) {
        return OrderIngCellHeigth+60;
    }
    return OrderIngCellHeigth;
    
}


- (void)setOrderContentWithModel:(Out_OrderIngListBody*)model
{
    _tempOrderModel = model;
     if (model.picpaths&&[model.picpaths count] > 0)
     {
         _menuView.frame = CGRectMake(0, 20, SCREEN_WIDTH, OrderIngCellHeigth-20+60);
         _detailView.frame = CGRectMake(0, _menuView.frame.size.height-36, SCREEN_WIDTH, 36);
         _line2.hidden = NO;
         
         for (int i = 0; i < [model.picpaths count]; i++)
         {
             NSString *imgString = [model.picpaths objectAtIndex:i];
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), _menuView.frame.size.height-89, 40, 40);
             [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgString]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
             btn.tag = i;
             [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
             [_menuView addSubview:btn];
             
         }
     }
    
    //1是文字，2是语音
    if (model.type == 1) {
        _orderContentLabel.hidden = NO;
        _orderVoiceBtn.hidden = YES;
        _orderContentLabel.text = [NSString stringWithFormat:@"呼：%@",model.desc];
    }else
    {
        _orderContentLabel.hidden = NO;
        _orderVoiceBtn.hidden = NO;
        _orderContentLabel.text = @"呼：";
    }
    //呼单类型，1：代办，2：代购，3：代送
    if (model.orderTypeId == 1) {
        _orderTypeLabel.textColor = DaiBanColor;
        _orderTypeLabel.text = @"办";
        _orderTypeLabel.layer.borderColor = DaiBanColor.CGColor;
        //判断地址是否存在
        _getAddressLabel.hidden = YES;
        _sendAddressLabel.hidden = NO;
        //设置地址
        _getAddressLabel.text = [NSString stringWithFormat:@"取：%@",model.fromAddress];
        _sendAddressLabel.text =[NSString stringWithFormat:@"送：%@",model.toAddress];
    }else if (model.orderTypeId == 2)
    {
        _orderTypeLabel.textColor = DaiGouColor;
        _orderTypeLabel.text = @"购";
        _orderTypeLabel.layer.borderColor = DaiGouColor.CGColor;
        //判断地址是否存在
        _getAddressLabel.hidden = YES;
        _sendAddressLabel.hidden = NO;
        //设置地址
        _getAddressLabel.text = [NSString stringWithFormat:@"取：%@",model.fromAddress];
        _sendAddressLabel.text =[NSString stringWithFormat:@"送：%@",model.toAddress];
    }else
    {
        _orderTypeLabel.textColor = DaiSongColor;
        _orderTypeLabel.text = @"送";
        _orderTypeLabel.layer.borderColor = DaiSongColor.CGColor;
        //判断地址是否存在
        _getAddressLabel.hidden = NO;
        _sendAddressLabel.hidden = NO;
        //设置地址
        _getAddressLabel.text = [NSString stringWithFormat:@"取：%@",model.fromAddress];
        _sendAddressLabel.text =[NSString stringWithFormat:@"送：%@",model.toAddress];
    }
    //设置小费
    _tipsLabel.text = [NSString stringWithFormat:@"小费%0.0f元",model.tip];

    //设置用户名和头像
    _nameLabel.text = model.uName;
    [_headImgView setImageURLStr:model.uHeader placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];
    
    //设置时间
    double unixTimeStamp = [model.createTime doubleValue]/1000;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *_date=[_formatter stringFromDate:date];
    _timeLabel.text = _date;
    
    if (model.statusId == 0) {
        _statusLabel.text = @"已取消";
        
    }else if (model.statusId == 1)
    {
        _statusLabel.text = @"待接单";
        _cancelOrderBtn.frame = CGRectMake(SCREEN_WIDTH-150, 4, 60, 28);
        _moreFeesBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
        //        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:AndDate:) userInfo:nil repeats:YES];
        //        [self timerFireMethodDate:_date];
    }else if (model.statusId == 2)
    {
        _statusLabel.text = @"已抢单";
        _cancelOrderBtn.frame = CGRectMake(SCREEN_WIDTH-170, 4, 60, 28);
        _chooseBrokerBtn.frame = CGRectMake(SCREEN_WIDTH-100, 4, 80, 28);
        //        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:AndDate:) userInfo:nil repeats:YES];
        //        [self timerFireMethodDate:_date];
    }else if (model.statusId == 3)
    {
        _statusLabel.text = @"已接单";
        _callBrokerBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
    }else if (model.statusId == 4)
    {
        _statusLabel.text = @"已购买";
        _confirmOrderBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
    }else if (model.statusId == 5)
    {
        _statusLabel.text = @"已取货";
        _confirmOrderBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
    }else if (model.statusId == 6)
    {
        _statusLabel.text = @"已办完";
        _confirmOrderBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
    }else if (model.statusId == 7)
    {
        _statusLabel.text = @"待付款";
        _payOrderBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
    }else if (model.statusId == 8)
    {
        _statusLabel.text = @"待评价";
        _commetnBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
    }else
    {
        _statusLabel.text = @"交易结束";
        if (model.isEvaluated == 0) {
            _statusLabel.text = @"待评价";
            _commetnBtn.frame = CGRectMake(SCREEN_WIDTH-80, 4, 60, 28);
        }else
        {
            _statusLabel.text = @"交易结束";
        }
    }
    
    //倒计时在timer的触发方法里完
    
    
}

//语音播放
- (void)voicePlayClick
{
    [self.delegate orderIngplayOrderVoiceWithModel:_tempOrderModel];
}

//选择经纪人
- (void)chooseBrokerClick
{
    [self.delegate chooseBrokerWithModel:_tempOrderModel];
}

//拨打经纪人电话
- (void)callBrokerClick
{
    [self.delegate callBrokerWithModel:_tempOrderModel];
}

//追加小费
- (void)moreFeesClick
{
    [self.delegate orderIngMoreTipsWithModel:_tempOrderModel];
}

//取消呼单
- (void)cancelOrderClick
{
    [self.delegate orderIngCancelOrderWithModel:_tempOrderModel];
}

//确认订单
- (void)confirmClick
{
    [self.delegate orderIngConfirmOrderWithModel:_tempOrderModel];
}


//立即评论
- (void)commentClick
{
    [self.delegate orderIngCommentCustomerWithModel:_tempOrderModel];
}

//立即付款
- (void)payOrderClick
{ 
    [self.delegate orderIngPayOrderWithModel:_tempOrderModel];
}

//头像点击
- (void)headClick
{
//    [self.delegate orderIngHeaderClickWithModel:_tempOrderModel];
}


- (void)timeDeal:(int)temptime
{
    __block int timeout= temptime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _statusLabel.text = @"已取消";
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 61;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSString *timeString = [NSString stringWithFormat:@"%d:%d后呼单取消",minutes,seconds];
                    NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:timeString];
                    [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, timeString.length-5)];
                    [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextDetailCOLOR range:NSMakeRange(timeString.length-5,5)];
                    if (minutes<0) {
                        _statusLabel.text = @"已取消";
                
                    }else
                    {
                        _statusLabel.attributedText = attributedTextString;
                    }
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

- (void)timerFireMethodDate:(NSString*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSString *tempDate = date;
    [components setYear:[[tempDate substringWithRange:NSMakeRange(0,4)] integerValue]];
    [components setMonth:[[tempDate substringWithRange:NSMakeRange(5,2)] integerValue]];
    [components setDay:[[tempDate substringWithRange:NSMakeRange(8,2)] integerValue]];
    [components setHour:[[tempDate substringWithRange:NSMakeRange(11,2)] integerValue]];
    [components setMinute:[[tempDate substringWithRange:NSMakeRange(14,2)] integerValue]];
    [components setSecond:[[tempDate substringWithRange:NSMakeRange(17,2)] integerValue]];
    NSDate *fireDate = [calendar dateFromComponents:components];//目标时间
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:fireDate toDate:today options:0];//计算时间差
    NSString *timeString = [NSString stringWithFormat:@"%ld:%ld后呼单取消",14-(long)[d minute], 59-(long)[d second]];//倒计时显示
    int time = (14-(int)[d minute])*60+59-(int)[d second];
    
    NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:timeString];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, timeString.length-5)];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextDetailCOLOR range:NSMakeRange(timeString.length-5,5)];
    if (14-(long)[d minute]<0) {
        _statusLabel.text = @"已取消";
        
    }else
    {
        [self timeDeal:time];
    }
}

- (void)btnClick:(UIButton *)btn
{
    [self.delegate orderIngshowOrderImgWithModel:_tempOrderModel AndIndex:btn.tag];
}

@end
