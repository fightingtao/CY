//
//  LGoodsListTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/25.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LGoodsListTableViewCell.h"

@implementation LGoodsListTableViewCell
@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,15,200,20)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = LittleFont;
            _timeLabel.textColor = TextDetailCOLOR;
            _timeLabel.text = @"2016-01-22";
            _timeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _timeLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_timeLabel];
        }
        
        if (!_meterLabel) {
            _meterLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100,15,80,20)];
            _meterLabel.backgroundColor = [UIColor clearColor];
            _meterLabel.font = LittleFont;
            _meterLabel.textColor = TextMainCOLOR;
            _meterLabel.text = @"500m";
            _meterLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _meterLabel.textAlignment = NSTextAlignmentRight;
            //            [self addSubview:_meterLabel];
        }
        
        if (!_shopImgview) {
            _shopImgview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 45, 20, 20)];
            _shopImgview.contentMode = UIViewContentModeScaleAspectFill;
            _shopImgview.image = [UIImage imageNamed:@"橙色-2@2x"];
            [self addSubview:_shopImgview];
        }
        
        if (!_shopNameLabel) {
            _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,45,200,20)];
            _shopNameLabel.backgroundColor = [UIColor clearColor];
            _shopNameLabel.font = MiddleFont;
            _shopNameLabel.textColor = TextMainCOLOR;
            _shopNameLabel.text = @"天猫";
            _shopNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _shopNameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_shopNameLabel];
        }
        
        if (!_orderNumLabel) {
            _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,70,SCREEN_WIDTH-40,20)];
            _orderNumLabel.backgroundColor = [UIColor clearColor];
            _orderNumLabel.font = MiddleFont;
            _orderNumLabel.textColor = TextMainCOLOR;
            _orderNumLabel.text = @"订单号:DJFI32094223";
            _orderNumLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderNumLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_orderNumLabel];
        }
        
        if (!_orderAddressLabel) {
            _orderAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,95,SCREEN_WIDTH-20,20)];
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
        
        if (!_receiverNameLabel) {
            _receiverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,125,160,20)];
            _receiverNameLabel.backgroundColor = [UIColor clearColor];
            _receiverNameLabel.font = MiddleFont;
            _receiverNameLabel.textColor = TextMainCOLOR;
            _receiverNameLabel.text = @"收货人:呼送科技";
            _receiverNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _receiverNameLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_receiverNameLabel];
        }
        
        
        if (!_phoneBtn) {
            _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _phoneBtn.frame = CGRectMake(200,125,SCREEN_WIDTH-215,20);
            [_phoneBtn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
            [_phoneBtn setTitle:@"15239589232" forState:UIControlStateNormal];
            [_phoneBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            _phoneBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
            _phoneBtn.titleLabel.font = MiddleFont;
            [self addSubview:_phoneBtn];
        }
        
        if (!_phoneImgview) {
            _phoneImgview = [[UIImageView alloc] initWithFrame:CGRectMake(_phoneBtn.frame.origin.x-15, 125, 15, 15)];
            _phoneImgview.contentMode = UIViewContentModeScaleAspectFill;
            _phoneImgview.image = [UIImage imageNamed:@"btn_phone"];
            [self addSubview:_phoneImgview];
        }
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 145, SCREEN_WIDTH, 0.5)];
            _line.backgroundColor = LineColor;
            [self addSubview:_line];
        }
        
        if (!_PayStatusLabel) {
            _PayStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,145,SCREEN_WIDTH-100,40)];
            _PayStatusLabel.backgroundColor = [UIColor clearColor];
            _PayStatusLabel.font = MiddleFont;
            _PayStatusLabel.textColor = MAINCOLOR;
            _PayStatusLabel.text = @"已付款";
            _PayStatusLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _PayStatusLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_PayStatusLabel];
        }
        
        if (!_orderStatusLabel) {
            _orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100,145,80,40)];
            _orderStatusLabel.backgroundColor = [UIColor clearColor];
            _orderStatusLabel.font = MiddleFont;
            _orderStatusLabel.textColor = MAINCOLOR;
            _orderStatusLabel.text = @"待签收";
            _orderStatusLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderStatusLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_orderStatusLabel];
        }
    }
    return self;
}

- (CGFloat)CellHeightWithModel:(Out_LOrderListBody*)model{
    
    //20,95,SCREEN_WIDTH-20,20
    CGRect rect = [model.consigneeaddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    _orderAddressLabel.frame = CGRectMake(20, 95, SCREEN_WIDTH-20, rect.size.height);
    
    _receiverNameLabel.frame = CGRectMake(20, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+5, 160, 20);
    _phoneBtn.frame = CGRectMake(20, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+5, SCREEN_WIDTH-215, 20);
    _phoneImgview.frame = CGRectMake(_phoneBtn.frame.origin.x-15, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+5, 15, 15);
    
    _line.frame = CGRectMake(0, _phoneBtn.frame.origin.y+_phoneBtn.frame.size.height+5, SCREEN_WIDTH, 0.5);
    
    _PayStatusLabel.frame = CGRectMake(20 , _line.frame.origin.y+_line.frame.size.height, SCREEN_WIDTH-100, 40);
    _orderStatusLabel.frame = CGRectMake(SCREEN_WIDTH-100, _line.frame.origin.y+_line.frame.size.height, 80, 35);
    
    return _orderStatusLabel.frame.origin.y+_orderStatusLabel.frame.size.height +5;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(Out_LOrderListBody*)model
{
    _tempModel = model;
    _timeLabel.text = model.deliverytime;
    if ([model.distance  floatValue]< 1000) {
        _meterLabel.text =[NSString stringWithFormat:@"%0.2fm",[model.distance floatValue]];
    }else
    {
        _meterLabel.text = [NSString stringWithFormat:@"%0.2fKm",[model.distance floatValue]/1000];
    }
    _shopNameLabel.text = model.dssnname;
    _orderNumLabel.text = [NSString stringWithFormat:@"订单号:%@",model.cwb];
    
    CGRect rect = [model.consigneeaddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    _orderAddressLabel.frame = CGRectMake(20, 95, SCREEN_WIDTH-20, rect.size.height);
    
    _receiverNameLabel.frame = CGRectMake(20, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+5, 160, 20);
    _phoneBtn.frame = CGRectMake(200, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+5, SCREEN_WIDTH-215, 20);
    
    _phoneImgview.frame = CGRectMake(_phoneBtn.frame.origin.x-15, _orderAddressLabel.frame.origin.y+_orderAddressLabel.frame.size.height+5, 15, 15);
    
    _line.frame = CGRectMake(0, _phoneBtn.frame.origin.y+_phoneBtn.frame.size.height+5, SCREEN_WIDTH, 0.5);
    
    _PayStatusLabel.frame = CGRectMake(20 , _line.frame.origin.y+_line.frame.size.height, SCREEN_WIDTH-100, 35);
    _orderStatusLabel.frame = CGRectMake(SCREEN_WIDTH-100, _line.frame.origin.y+_line.frame.size.height, 80, 35);
    
    _orderAddressLabel.text = [NSString stringWithFormat:@"收件地址:%@",model.consigneeaddress];
    _receiverNameLabel.text = [NSString stringWithFormat:@"收货人:%@",model.consigneename];
    [_phoneBtn setTitle:model.consigneemobile forState:UIControlStateNormal];
    
    if ([_tempModel.cwbordertypeid intValue] ==1) {
        _orderStatusLabel.text = @"配送";
    }
    if ([_tempModel.cwbordertypeid intValue]==2) {
        _orderStatusLabel.text = @"上门退";
    }
    if ([_tempModel.cwbordertypeid intValue]==3) {
        _orderStatusLabel.text = @"上门换";
    }
    
    
    if (_KindType == 1)
    {
        if ([model.cwbordertypeid intValue ]==1) {
            if ([model.cod floatValue] -[model.paybackfee floatValue] ==0.00) {
                _PayStatusLabel.text = @"已付款";
            }else
            {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",([model.cod floatValue] -[model.paybackfee floatValue])];
            }
        }
        if ([model.cwbordertypeid intValue]==2) {
            if ([model.cod floatValue] -[model.paybackfee floatValue]==0.00) {
                _PayStatusLabel.text = @"待退款:0.00元";
            }
            else if ([model.cod floatValue] -[model.paybackfee floatValue]>0.00) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待退款:%0.2f元",([model.cod floatValue] -[model.paybackfee floatValue])];
            }
            else if ([model.cod floatValue] -[model.paybackfee floatValue]<0.00)
            {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待退款:%0.2f元",-([model.cod floatValue] -[model.paybackfee floatValue])];
            }
            
        }
        if ([model.cwbordertypeid intValue] ==3) {
            if ([model.cod floatValue] -[model.paybackfee floatValue] == 0) {
                _PayStatusLabel.text = @"已付款";
            }
            if ([model.cod floatValue] -[model.paybackfee floatValue] < 0) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待退款:%0.2f元",-([model.cod floatValue] -[model.paybackfee floatValue] )];
            }
            if ([model.cod floatValue] -[model.paybackfee floatValue] > 0) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",[model.cod floatValue] -[model.paybackfee floatValue] ];
            }
            _orderStatusLabel.text = @"上门换";
            
        }
    }
    if (_KindType ==2) {
        if ([model.cwbordertypeid intValue] ==1) {
            _PayStatusLabel.text = [NSString stringWithFormat:@"已收款:%0.2f元",[model.cod floatValue]];
        }
        if ([model.cwbordertypeid intValue] ==2) {
            _PayStatusLabel.text = [NSString stringWithFormat:@"已退款:%0.2f元",[model.paybackfee floatValue]];
        }
        if ([model.cwbordertypeid intValue] ==3) {
            if ([model.cod floatValue] -[model.paybackfee floatValue]==0.00) {
                _PayStatusLabel.text = @"已付款";
            }
            if ([model.cod floatValue] -[model.paybackfee floatValue] < 0) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"已退款:%0.2f元",-([model.cod floatValue] -[model.paybackfee floatValue])];
            }
            if ([model.cod floatValue] -[model.paybackfee floatValue] > 0) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"已收款:%0.2f元",[model.cod floatValue] -[model.paybackfee floatValue]];
            }
        }
    }
    if (_KindType ==3) {
        if ([model.cwbordertypeid  intValue]==1) {
            if ([model.cod floatValue] -[model.paybackfee floatValue]==0.00) {
                _PayStatusLabel.text = @"已付款";
            }else
            {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",[model.cod floatValue]];
            }
        }
        if ([model.cwbordertypeid intValue]==2) {
            if ([model.cod floatValue] -[model.paybackfee floatValue]==0.00) {
                _PayStatusLabel.text = @"已退款";
            }else
            {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待退款:%0.2f元",[model.paybackfee floatValue]];
            }
        }
        if ([model.cwbordertypeid intValue]==3) {
            if ([model.cod floatValue] -[model.paybackfee floatValue] ==0.00) {
                _PayStatusLabel.text = @"已付款";
            }
            if ([model.cod floatValue] -[model.paybackfee floatValue]< 0) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待退款:%0.2f元",-([model.cod floatValue] -[model.paybackfee floatValue])];
            }
            if ([model.cod floatValue] -[model.paybackfee floatValue] > 0) {
                _PayStatusLabel.text = [NSString stringWithFormat:@"待收款:%0.2f元",[model.cod floatValue] -[model.paybackfee floatValue]];
            }
        }
    }
}


- (void)phoneClick
{
    [self.delegate callPhoneWithModel:_tempModel];
}

@end
