//
//  LOrderDetailTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LOrderDetailTableViewCell.h"

@implementation LOrderDetailTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,200,40)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = MiddleFont;
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"2016-01-22";
            _timeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_timeLabel];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = LineColor;
        [self addSubview:line];
        
        if (!_shopImgview) {
            _shopImgview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 20, 20)];
            _shopImgview.contentMode = UIViewContentModeScaleAspectFill;
            _shopImgview.image = [UIImage imageNamed:@"橙色-2@2x"];
            [self addSubview:_shopImgview];
        }
        
        if (!_shopNameLabel) {
            _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,40,SCREEN_WIDTH-70,40)];
            _shopNameLabel.backgroundColor = [UIColor clearColor];
            _shopNameLabel.font = MiddleFont;
            _shopNameLabel.textColor = TextMainCOLOR;
            _shopNameLabel.text = @"天猫";
            _shopNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _shopNameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_shopNameLabel];
        }
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
        line2.backgroundColor = LineColor;
        [self addSubview:line2];
        
        if (!_orderNumLabel) {
            _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,80,SCREEN_WIDTH-40,40)];
            _orderNumLabel.backgroundColor = [UIColor clearColor];
            _orderNumLabel.font = MiddleFont;
            _orderNumLabel.textColor = TextMainCOLOR;
            _orderNumLabel.text = @"订单号:DJFI32094223";
            _orderNumLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderNumLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_orderNumLabel];
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 0.5)];
        line3.backgroundColor = LineColor;
        [self addSubview:line3];
        
        if (!_PayStatusLabel) {
            _PayStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,120,SCREEN_WIDTH-40,40)];
            _PayStatusLabel.backgroundColor = [UIColor clearColor];
            _PayStatusLabel.font = MiddleFont;
            _PayStatusLabel.textColor = TextMainCOLOR;
            _PayStatusLabel.text = @"支付方式:在线支付";
            _PayStatusLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _PayStatusLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_PayStatusLabel];
        }
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 0.5)];
        line4.backgroundColor = LineColor;
        [self addSubview:line4];
        
        if (!_CodLabel) {
            _CodLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,160,SCREEN_WIDTH - 40,40)];
            _CodLabel.backgroundColor = [UIColor clearColor];
            _CodLabel.font = MiddleFont;
            _CodLabel.textColor = MAINCOLOR;
            _CodLabel.text = @"支付金额:0.00元";
            _CodLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _CodLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_CodLabel];
        }
        
        UIView *linefour = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 0.5)];
        linefour.backgroundColor = LineColor;
        [self addSubview:linefour];
        
        if (!_OrderType) {
            _OrderType = [[UILabel alloc] initWithFrame:CGRectMake(20,200,SCREEN_WIDTH - 40,40)];
            _OrderType.backgroundColor = [UIColor clearColor];
            _OrderType.font = MiddleFont;
            _OrderType.textColor = TextMainCOLOR;
            _OrderType.text = @"订单类型:－－　";
            _OrderType.lineBreakMode = NSLineBreakByCharWrapping;
            _OrderType.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_OrderType];
        }
        
        UIView *linefive = [[UIView alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, 0.5)];
        linefive.backgroundColor = LineColor;
        [self addSubview:linefive];
        
        
        if (!_receiverNameLabel) {
            _receiverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,240,SCREEN_WIDTH - 40,40)];
            _receiverNameLabel.backgroundColor = [UIColor clearColor];
            _receiverNameLabel.font = MiddleFont;
            _receiverNameLabel.textColor = TextMainCOLOR;
            _receiverNameLabel.text = @"收货人:雏燕科技";
            _receiverNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _receiverNameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_receiverNameLabel];
        }
        
        UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 0.5)];
        line5.backgroundColor = LineColor;
        [self addSubview:line5];
        
        if (!_phoneLabel) {
            _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,280,SCREEN_WIDTH-40,40)];
            _phoneLabel.backgroundColor = [UIColor clearColor];
            _phoneLabel.font = MiddleFont;
            _phoneLabel.textColor = TextMainCOLOR;
            _phoneLabel.text = @"联系电话:151543534";
            _phoneLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _phoneLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_phoneLabel];
        }
        
        
        UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, 0.5)];
        line6.backgroundColor = LineColor;
        [self addSubview:line6];
        
        if (!_orderAddressLabel) {
            _orderAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,320,SCREEN_WIDTH-40,40)];
            _orderAddressLabel.backgroundColor = [UIColor clearColor];
            _orderAddressLabel.font = MiddleFont;
            _orderAddressLabel.textColor = TextMainCOLOR;
            _orderAddressLabel.text = @"收件地址:长江贸易大楼";
            _orderAddressLabel.numberOfLines = 0;
            _orderAddressLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderAddressLabel.textAlignment = NSTextAlignmentLeft;
            
            //_orderAddressLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_orderAddressLabel];
        }
        
        if (!_orderStatusLabel) {
            _orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100,0,80,40)];
            _orderStatusLabel.backgroundColor = [UIColor clearColor];
            _orderStatusLabel.font = MiddleFont;
            _orderStatusLabel.textColor = MAINCOLOR;
            _orderStatusLabel.text = @"已签收";
            _orderStatusLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderStatusLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_orderStatusLabel];
        }
        
        _line7 = [[UIView alloc] initWithFrame:CGRectMake(0, 360, SCREEN_WIDTH, 0.5)];
        _line7.backgroundColor = LineColor;
        [self addSubview:_line7];
        
        if (!_problemStatusLabel) {
            _problemStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,360,SCREEN_WIDTH-40,40)];
            _problemStatusLabel.backgroundColor = [UIColor clearColor];
            _problemStatusLabel.numberOfLines=0;
            //            _problemStatusLabel.font = [UIFont systemFontOfSize:15 weight:5];
            _orderStatusLabel.font = MiddleFont;
            _problemStatusLabel.textColor = MAINCOLOR;
            _problemStatusLabel.text = @"异常原因:2月6号再次配送";
            //            _problemStatusLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _problemStatusLabel.textAlignment = NSTextAlignmentLeft;
            //            _problemStatusLabel.backgroundColor=[UIColor redColor];
            [self addSubview:_problemStatusLabel];
        }
    }
    return self;
}

- (CGFloat)CellHeight:(Out_LOrderDetailBody*)model{
    
    NSString *strTemp=[NSString stringWithFormat: @"收货地址:%@",model.consigneeaddress];
    CGRect rect = [strTemp boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    _orderAddressLabel.frame = CGRectMake(20, 320+10, SCREEN_WIDTH-40, rect.size.height);
    _orderAddressLabel.text = [NSString stringWithFormat:@"收件地址:%@",model.consigneeaddress];
    
    if ([model.exptmsg isEqualToString:@""]){
        
        _line7.hidden = YES;
        _problemStatusLabel.hidden=YES;
        return _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+20;
        
    }
    else{
        _problemStatusLabel.hidden=NO;
        _line7.hidden = NO;
        
        _line7.frame = CGRectMake(0, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+10, SCREEN_WIDTH, 0.5);
        
        CGRect rect2 = [model.exptmsg boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        CGRect rect3 = [model.exptmsg boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        DLog(@"地址长度%f    %f",rect2.size.height,rect3.size.height);
        _problemStatusLabel.frame = CGRectMake(20, _line7.frame.origin.y+_line7.frame.size.height+5, SCREEN_WIDTH-40, rect2.size.height+40);
        _problemStatusLabel.text = [NSString stringWithFormat:@"异常原因:%@",model.exptmsg];
        
        return _problemStatusLabel.frame.origin.y+_problemStatusLabel.frame.size.height+15;
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setModel:(Out_LOrderDetailBody*)model
{
    if (!model) {
        return;
    }
    DLog(@"订单详情cell属性设置%@",model);
    _timeLabel.text = model.deliverytime;
    _shopNameLabel.text = model.dssnname;
    _orderNumLabel.text = [NSString stringWithFormat:@"订单号:%@",model.cwb];
    //支付方式（1现金 2pos刷卡 3支付宝扫码支付 4微信支付 5其它）
    if ([model.payway  intValue] == 1) {
        _PayStatusLabel.text = [NSString stringWithFormat:@"支付方式:现金支付"];
    }else if ([model.payway intValue] == 2)
    {
        _PayStatusLabel.text = [NSString stringWithFormat:@"支付方式:POS刷卡"];
    }else if ([model.payway intValue] == 3)
    {
        _PayStatusLabel.text = [NSString stringWithFormat:@"支付方式:支付宝支付"];
    }else if ([model.payway intValue] == 4)
    {
        _PayStatusLabel.text = [NSString stringWithFormat:@"支付方式:微信支付"];
    }else if ([model.payway intValue] == 5)
    {
        _PayStatusLabel.text = [NSString stringWithFormat:@"支付方式:其它支付"];
    }else
    {
        _PayStatusLabel.text = [NSString stringWithFormat:@"支付方式:其它支付"];
    }
    _receiverNameLabel.text =[NSString stringWithFormat:@"收货人:%@",model.consigneename];
    _phoneLabel.text = [NSString stringWithFormat:@"联系电话:%@",model.consigneemobile];
    
    NSString *strAddress=[NSString stringWithFormat:@"收货地址:%@",model.consigneeaddress];
    CGRect rect = [strAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    _orderAddressLabel.frame = CGRectMake(20, 320+10, SCREEN_WIDTH-40, rect.size.height);
    _orderAddressLabel.text = [NSString stringWithFormat:@"收件地址:%@",model.consigneeaddress];
    
    if ([model.state isEqualToString:@"2"]||[model.state isEqualToString:@"1"]||[model.state isEqualToString:@"5"]||[model.state isEqualToString:@"8"]){
        
        _line7.hidden = YES;
        _problemStatusLabel.hidden=YES;
    }
    else{
        
        _line7.hidden = NO;
        _problemStatusLabel.hidden=NO;
        _line7.frame = CGRectMake(0, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+10, SCREEN_WIDTH, 0.5);
        
        CGRect rect2 = [model.exptmsg boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        _problemStatusLabel.frame = CGRectMake(20, _line7.frame.origin.y+_line7.frame.size.height+10, SCREEN_WIDTH-40, rect2.size.height+40);
        _problemStatusLabel.text = [NSString stringWithFormat:@"异常原因:%@",model.exptmsg];
        
    }
    
    //订单状态 （-1失效订单 0导入数据 1领货 2配送成功 3滞留 4拒收）
    
    
    if ([model.cwbordertypeid    intValue]==1) {
        _OrderType.text = @"订单类型:  配送";
    }
    if ([model.cwbordertypeid    intValue] ==2) {
        _OrderType.text = @"订单类型:  上门退";
    }
    if ([model.cwbordertypeid  intValue] ==3) {
        _OrderType.text = @"订单类型:  上门换";
        
    }
    
    if (_KindType ==1) {
        //        [self setStatusWithModel:model];
        if ([model.cwbordertypeid  intValue] ==1) { //正常配送中
            if ([model.cod  floatValue] ==0.00) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]];
            }
            else{
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]];
            }
        }
        if ([model.cwbordertypeid  intValue] ==2) {//配送中>>>上门退
            //            if ([[model.paybackfee  floatValue]  floatValue]>0) {
            //                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.paybackfee  floatValue]];
            //            }
            if ([model.cod  floatValue] -[model.paybackfee  floatValue] ==0.00) {
                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",[model.paybackfee  floatValue]];
            }
            else   if (([model.cod  floatValue]-[model.paybackfee  floatValue])<0){
                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",-([model.cod  floatValue]-[model.paybackfee  floatValue])];
            }
            else{
                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",-([model.cod  floatValue]-[model.paybackfee  floatValue])];
            }
            
        }
        if ([model.cwbordertypeid  intValue] ==3) { //配送中>>>上门换
            
            
            if ([model.cod floatValue]-[model.paybackfee  floatValue] >0) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]-[model.paybackfee  floatValue]];
            }
            else if ([model.cod floatValue]-[model.paybackfee  floatValue]==0.00) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]-[model.paybackfee  floatValue]];
            }
            else  if ([model.cod floatValue]-[model.paybackfee  floatValue] <0) {
                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",-([model.cod floatValue]-[model.paybackfee  floatValue])];
                
            }
        }
        _orderStatusLabel.text = @"配送中";
        
    }
    if (_KindType ==2) { //配送成功
     
        if ([model.cwbordertypeid  intValue] ==1) {
            _orderStatusLabel.text = @"配送成功";
            _CodLabel.text = [NSString stringWithFormat:@"已收金额:  %0.2f元",[model.cod floatValue]];
        }
        if ([model.cwbordertypeid  intValue] ==2) {
            _orderStatusLabel.text = @"上门退成功";
            _CodLabel.text = [NSString stringWithFormat:@"已退金额:  %0.2f元",[model.paybackfee  floatValue]];
        }
        if ([model.cwbordertypeid  intValue] ==3) {
            _orderStatusLabel.text = @"上门换成功";
            if ([model.cod floatValue]-[model.paybackfee  floatValue] >0) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]-[model.paybackfee  floatValue]];
            }
            else if ([model.cod floatValue]-[model.paybackfee  floatValue]==0.00) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]-[model.paybackfee  floatValue]];
            }
            else  if ([model.cod floatValue]-[model.paybackfee  floatValue] <0) {
                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",-([model.cod floatValue]-[model.paybackfee  floatValue])];
                
            }
        }
        
    }
    
    if (_KindType ==3) {
        [self setStatusWithModel:model];
        
        if ([model.cwbordertypeid  intValue] ==1) {
            _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]];
            //            if ([model.paybackfee  floatValue] ==0) {
            //                _CodLabel.text = [NSString stringWithFormat:@"已退金额:  %0.2f元",[model.paybackfee  floatValue]];
            //            }
            //            else{
            //                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",[model.paybackfee  floatValue]];
            //            }
            //            _orderStatusLabel.text = @"配送失败";
            
        }
        
        if ([model.cwbordertypeid  intValue] ==2) {
            //          if ([model.paybackfee  floatValue] ==0) {
            _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",[model.paybackfee  floatValue]];
            //            }
            //            else{
            //            _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",[model.paybackfee  floatValue]];
            //                }
            //            _orderStatusLabel.text = @"上门退失败";
            
        }
        if ([model.cwbordertypeid  intValue] ==3) {
            
            //            if ([model.paybackfee  floatValue] ==0) {
            //                _CodLabel.text = [NSString stringWithFormat:@"已退金额:  %0.2f元",[model.paybackfee  floatValue]];
            //            }
            //            else{
            //                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",[model.paybackfee  floatValue]];
            
            
            
            if ([model.cod floatValue]-[model.paybackfee  floatValue] >0) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]-[model.paybackfee  floatValue]];
            }
            else if ([model.cod floatValue]-[model.paybackfee  floatValue]==0.00) {
                _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.cod floatValue]-[model.paybackfee  floatValue]];
            }
            else  if ([model.cod floatValue]-[model.paybackfee  floatValue] <0) {
                _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",-([model.cod floatValue]-[model.paybackfee  floatValue])];
                
            }
            
        }
        //            订单状态 （-1失效订单 0导入数据 1领货 2配送成功 3滞留 4拒收 5上门退成功 6上门退滞留 7上门退拒退 8上门换成功 9上门换滞留 10上门换拒换）
        //            if ([model.state intValue]==3){
        //                _orderStatusLabel.text = @"上门换滞留";
        //
        //            }
        //            else if ([model.state intValue]==3){
        //                 _orderStatusLabel.text = @"上门换拒收";
        //
        //            _orderStatusLabel.text = @"上门换失败";
        //            }
        
        
        
        //    }
        //    if ([model.cwbordertypeid  intValue] ==2) {
        //        if ([model.cwbordertypeid  intValue] ==0.00) {
        //            _CodLabel.text = [NSString stringWithFormat:@"已退金额:  %0.2f元",[model.paybackfee  floatValue]];
        //        }
        //        else{
        //            _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",[model.paybackfee  floatValue]];
        //        }
        //    }
        //    if ([model.cwbordertypeid  intValue] ==3) {
        //        if ([model.paybackfee  floatValue] >0) {
        //            _CodLabel.text = [NSString stringWithFormat:@"待收金额:  %0.2f元",[model.paybackfee  floatValue]];
        //        }
        //        if ([model.paybackfee  floatValue] ==0.00) {
        //            _CodLabel.text = [NSString stringWithFormat:@"已退金额:  %0.2f元",[model.paybackfee  floatValue]];
        //        }
        //        if ([model.paybackfee  floatValue] <0) {
        //            _CodLabel.text = [NSString stringWithFormat:@"待退金额:  %0.2f元",-[model.paybackfee  floatValue]];
        //        }
    }
}
-(void)setStatusWithModel:(Out_LOrderDetailBody*)model{
    
    if ([model.state intValue] == 1)
    {
        if ([model.cwbordertypeid  intValue] ==1) {
            _orderStatusLabel.text = @"配送失败";
        }
        else  if ([model.cwbordertypeid  intValue] ==2) {
            _orderStatusLabel.text = @"上门退失败";
        }
        else  if ([model.cwbordertypeid  intValue] ==3) {
            _orderStatusLabel.text = @"上门换失败";
        }
        
        
    }
    else if ([model.state  intValue]== 2)
    {
        _orderStatusLabel.text = @"已签收";
        
    }else if ([model.state intValue] == 3)
    {
        _orderStatusLabel.text = @"滞留";
    }else if ([model.state intValue] == 4)
    {
        _orderStatusLabel.text = @"拒收";
    }
    else if ([model.state intValue] == 5)
    {
        _orderStatusLabel.text = @"上门退成功";
    }
    else if ([model.state intValue] == 6)
    {
        _orderStatusLabel.text = @"上门退滞留";
    }
    
    else if ([model.state intValue] == 7)
    {
        _orderStatusLabel.text = @"上门退拒退";
    }
    else if ([model.state intValue] == 8)
    {
        _orderStatusLabel.text = @"上门换成功";
    }
    else if ([model.state intValue] == 9)
    {
        _orderStatusLabel.text = @"上门换滞留";
    }
    else if ([model.state intValue] == 10)
    {
        _orderStatusLabel.text = @"上门换拒换";
    }
    
}
@end
