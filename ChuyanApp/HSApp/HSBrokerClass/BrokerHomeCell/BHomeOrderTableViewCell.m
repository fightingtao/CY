//
//  BHomeOrderTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/20.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BHomeOrderTableViewCell.h"

@implementation BHomeOrderTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
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
            [self addSubview:_orderTypeLabel];
        }
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 20, 50, 50)];
            _headImgView.contentMode = UIViewContentModeScaleToFill;
            _headImgView.layer.cornerRadius = 25;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            _headImgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)];
            [_headImgView addGestureRecognizer:singleTap1];
            [self addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, 120, 30)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_nameLabel];
        }
        
        if (!_orderContentLabel) {
            _orderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,15, SCREEN_WIDTH-140, 20)];
            _orderContentLabel.backgroundColor = [UIColor clearColor];
            _orderContentLabel.font = LittleFont;
            _orderContentLabel.textColor = TextMainCOLOR;
            _orderContentLabel.text = @"呼：";
            _orderContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _orderContentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_orderContentLabel];
        }
        
        if (!_orderVoiceBtn) {
            _orderVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _orderVoiceBtn.frame = CGRectMake(150, 15, 20, 20);
            [_orderVoiceBtn addTarget:self action:@selector(voicePlayClick) forControlEvents:UIControlEventTouchUpInside];
            [_orderVoiceBtn setImage:[UIImage imageNamed:@"btn_voice"] forState:UIControlStateNormal];
            [self addSubview:_orderVoiceBtn];
        }
        if (!_getAddressLabel) {
            _getAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,45, SCREEN_WIDTH-140, 20)];
            _getAddressLabel.backgroundColor = [UIColor clearColor];
            _getAddressLabel.font = LittleFont;
            _getAddressLabel.textColor = TextMainCOLOR;
            _getAddressLabel.text = @"取：长江贸易大楼";
            _getAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _getAddressLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_getAddressLabel];
        }
        
        if (!_sendAddressLabel) {
            _sendAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,75, SCREEN_WIDTH-140, 20)];
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.font = LittleFont;
            _sendAddressLabel.textColor = TextMainCOLOR;
            _sendAddressLabel.text = @"送：长江贸易大楼";
            _sendAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_sendAddressLabel];
        }
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, 1)];
            _line.backgroundColor = LineColor;
            [self addSubview:_line];
        }
        if (!_line2) {
            _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 169, SCREEN_WIDTH, 1)];
            _line2.backgroundColor = LineColor;
            _line2.hidden = YES;
            [self addSubview:_line2];
        }
        
        if (!_detailView) {
            _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, OrderCellHeigth-36, SCREEN_WIDTH, 36)];
            _detailView.backgroundColor = WhiteBgColor;
            [self addSubview:_detailView];
        }
        
        if (!_tipsLabel) {
            _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(21,0, 100, 36)];
            _tipsLabel.backgroundColor = [UIColor clearColor];
            _tipsLabel.font = LittleFont;
            _tipsLabel.textColor = [UIColor redColor];
            _tipsLabel.text = @"小费200元";
            _tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _tipsLabel.textAlignment = NSTextAlignmentLeft;
            [_detailView addSubview:_tipsLabel];
        }
        
        
        if (!_distanceImg) {
            _distanceImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 8, 12, 20)];
            _distanceImg.image = [UIImage imageNamed:@"btn_location"];
            [_detailView addSubview:_distanceImg];
        }
        
        if (!_distanceLabel) {
            _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,0, 80, 36)];
            _distanceLabel.backgroundColor = [UIColor clearColor];
            _distanceLabel.font = LittleFont;
            _distanceLabel.textColor = TextMainCOLOR;
            _distanceLabel.text = @"4000m";
            _distanceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _distanceLabel.textAlignment = NSTextAlignmentLeft;
            [_detailView addSubview:_distanceLabel];
        }
        
        if (!_getOrderBtn) {
            _getOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _getOrderBtn.frame = CGRectMake(SCREEN_WIDTH-80,4, 60, 28);
            [_getOrderBtn addTarget:self action:@selector(getOrderClick) forControlEvents:UIControlEventTouchUpInside];
            [_getOrderBtn setTitle:@"抢单" forState:UIControlStateNormal];
            [_getOrderBtn setBackgroundColor:WhiteBgColor];
            [_getOrderBtn setTitleColor:TextMainCOLOR forState:UIControlStateNormal];
            _getOrderBtn.titleLabel.font = LittleFont;
            _getOrderBtn.layer.borderColor = [UIColor blackColor].CGColor;
            _getOrderBtn.layer.borderWidth = 0.5;
            _getOrderBtn.layer.cornerRadius = 5;
            [_detailView addSubview:_getOrderBtn];
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


+ (CGFloat)cellHeightWithModel:(OutWaitOrderListBody*)mode
{
    if (mode.picpaths&&[mode.picpaths count] > 0) {
        return OrderCellHeigth+60;
    }
    return OrderCellHeigth;
}


- (void)setOrderContentWithModel:(OutWaitOrderListBody*)model
{
    _tempOrderModel = model;
    
    if (model.picpaths&&[model.picpaths count] > 0) {
        _detailView.frame = CGRectMake(0, OrderCellHeigth-36+60, SCREEN_WIDTH, 36);
        _line2.hidden = NO;
        
        for (int i = 0; i < [model.picpaths count]; i++)
        {
            NSString *imgString = [model.picpaths objectAtIndex:i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), OrderCellHeigth-26, 40, 40);
            [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgString]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
        }
    }else
    {
        _detailView.frame = CGRectMake(0, OrderCellHeigth-36, SCREEN_WIDTH, 36);
        _line2.hidden = YES;
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
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CLLocationCoordinate2D coors1;
    CLLocationCoordinate2D coors2;
    coors1.latitude = app.staticlat;
    coors1.longitude = app.staticlng;
    
    coors2.latitude = [model.lat floatValue];
    coors2.longitude = [model.lng floatValue];
    
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(coors1);
    BMKMapPoint point2 = BMKMapPointForCoordinate(coors2);
    
    // 计算距离
    CLLocationDistance meters= BMKMetersBetweenMapPoints(point1, point2);
    if (meters > 1000) {
        meters = meters/1000;
        _distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",meters];
    }else
    {
        _distanceLabel.text = [NSString stringWithFormat:@"%.1fm",meters];
    }

}

//语音播放
- (void)voicePlayClick
{
    [self.delegate playOrderVoiceWithModel:_tempOrderModel];
}

//抢单
- (void)getOrderClick
{
    [self.delegate getOrderDelegateWithModel:_tempOrderModel];
}

//头像点击
- (void)headClick
{
    [self.delegate headImgClickWithModel:_tempOrderModel];
}


- (void)btnClick:(UIButton *)btn
{
    [self.delegate showOrderImgWithModel:_tempOrderModel AndIndex:btn.tag];
}

@end
