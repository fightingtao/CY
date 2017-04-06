//
//  LMoneyReportTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LMoneyReportTableViewCell.h"

@implementation LMoneyReportTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        

        if (!_totalMoneyLabel) {
            _totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,SCREEN_WIDTH-40,50)];
            _totalMoneyLabel.backgroundColor = [UIColor clearColor];
            _totalMoneyLabel.font = LargeFont;
            _totalMoneyLabel.textColor = TextMainCOLOR;
//            _totalMoneyLabel.text = @"当日应收金额：0.00元";
//            NSString *strone = [NSString stringWithFormat:@"%0.2f",model.totalmoney];
            NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:@"当日应收金额：0.00元"];
            [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
            [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, attributedTextString.length-7)];
            _totalMoneyLabel.attributedText = attributedTextString;
            _totalMoneyLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_totalMoneyLabel];
        }
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
            _line.backgroundColor = LineColor;
            [self addSubview:_line];
        }
        
        if (!_correctImgview) {
            _correctImgview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 10, 10)];
            _correctImgview.contentMode = UIViewContentModeScaleAspectFill;
            _correctImgview.image = [UIImage imageNamed:@"green"];
            [self addSubview:_correctImgview];
        }
        
        if (!_correctMoneyLabel) {
            _correctMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,50,SCREEN_WIDTH-50,50)];
            _correctMoneyLabel.backgroundColor = [UIColor clearColor];
            _correctMoneyLabel.font = LargeFont;
            _correctMoneyLabel.textColor = TextMainCOLOR;
//            _correctMoneyLabel.text = @"已收金额：0.00元";
            NSMutableAttributedString * attributedTextString2 = [[NSMutableAttributedString alloc] initWithString:@"已收金额：0.00元"];
            [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
            [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5, attributedTextString2.length-5)];
            _correctMoneyLabel.attributedText = attributedTextString2;
            _correctMoneyLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _correctMoneyLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_correctMoneyLabel];
        }
        
        if (!_AlreadyBtn){
            _AlreadyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _AlreadyBtn.frame = CGRectMake(35, 50, SCREEN_WIDTH, 50);
            [_AlreadyBtn addTarget:self action:@selector(BigAndSmall) forControlEvents:UIControlEventTouchUpInside];
            _isState = YES;
            [self addSubview:_AlreadyBtn];
        }
        if (!_imgv) {
            _imgv = [[UIImageView alloc]init];
            _imgv.backgroundColor=[UIColor clearColor];
            _imgv.image=[UIImage imageNamed:@"sanjiao"];
            _imgv.frame = CGRectMake(SCREEN_WIDTH - 40,70, 15, 15);
            [self addSubview:_imgv];
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BigAndSmall)];
            tap.numberOfTapsRequired=1;
            [_imgv addGestureRecognizer:tap];
        }
        
        if (!_line2) {
            _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0.5)];
            _line2.backgroundColor = LineColor;
            [self addSubview:_line2];
        }
        
        
        if (!_alipayLabel) {
            _alipayLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,100,(SCREEN_WIDTH-40)-60,50)];
            _alipayLabel.backgroundColor = [UIColor clearColor];
            _alipayLabel.font = LargeFont;
            _alipayLabel.textColor = TextMainCOLOR;
//            _alipayLabel.text = @"支付宝：0.00元";
            NSMutableAttributedString * attributedTextString4 = [[NSMutableAttributedString alloc] initWithString: @"当面付支付宝：0.00元"];
            [attributedTextString4 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
            [attributedTextString4 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(7, attributedTextString4.length-7)];
            _alipayLabel.attributedText = attributedTextString4;
            _alipayLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _alipayLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_alipayLabel];
        }
        
        if (!_lineThree) {
            _lineThree = [[UIView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 0.5)];
            _lineThree.backgroundColor = LineColor;
            [self addSubview:_lineThree];
        }
        if (!_cashLabel) {
            _cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,150,(SCREEN_WIDTH-40)/2,50)];
            _cashLabel.backgroundColor = [UIColor clearColor];
            _cashLabel.font = LargeFont;
            _cashLabel.textColor = TextMainCOLOR;
//            _cashLabel.text = @"现金：100元";
            NSMutableAttributedString * attributedTextString5 = [[NSMutableAttributedString alloc] initWithString: @"现金：0.00元"];
            [attributedTextString5 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 3)];
            [attributedTextString5 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(3, attributedTextString5.length-3)];
            _cashLabel.attributedText =attributedTextString5;

            _cashLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _cashLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_cashLabel];
        }
        
        if (!_line3) {
            _line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 0.5)];
            _line3.backgroundColor = LineColor;
            [self addSubview:_line3];
        }
        
        
        if (!_posCardLabel) {
            _posCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,200,SCREEN_WIDTH-40,50)];
            _posCardLabel.backgroundColor = [UIColor clearColor];
            _posCardLabel.font = LargeFont;
            _posCardLabel.textColor = [UIColor greenColor];
//            _posCardLabel.text = @"POS刷卡：0.00元";
            NSMutableAttributedString * attributedTextString6 = [[NSMutableAttributedString alloc] initWithString: @"POS刷卡：0.00元"];
            [attributedTextString6 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 6)];
            [attributedTextString6 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6, attributedTextString6.length-6)];
            _posCardLabel.attributedText =attributedTextString6;
            
            _posCardLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _posCardLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_posCardLabel];
        }
        
        if (!_line4) {
            _line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 0.5)];
            _line4.backgroundColor = LineColor;
            [self addSubview:_line4];
        }
        
//        if (!_problemImgview) {
//            _problemImgview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 270, 10, 10)];
////            _problemImgview.frame = CGRectMake(20, 120, 10, 10);
////            _problemImgview.backgroundColor=[UIColor redColor];
//            _problemImgview.contentMode = UIViewContentModeScaleAspectFill;
//            _problemImgview.image = [UIImage imageNamed:@"green"];
////            [self addSubview:_problemImgview];
//        }
        
        if (!_problemMoneyLabel) {
            _problemMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,250,SCREEN_WIDTH-40,50)];
            _problemMoneyLabel.backgroundColor = [UIColor clearColor];
            _problemMoneyLabel.font = LargeFont;
            _problemMoneyLabel.textColor = TextMainCOLOR;
//            _problemMoneyLabel.text = @"异常金额：0.00元";
            NSMutableAttributedString * attributedTextString3 = [[NSMutableAttributedString alloc] initWithString:@"商家扫码：0.00元"];
            [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
            [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5, attributedTextString3.length-5)];
            _problemMoneyLabel.attributedText =attributedTextString3;

            _problemMoneyLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _problemMoneyLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_problemMoneyLabel];
        }
    }
    [self BigAndSmall];

    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataWithModl:(CYNSObject*)model
{
    if (!model) {
        return;
    }
    
//    NSString *strone = [NSString stringWithFormat:@"%0.2f",model.data.totalmoney];
    NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当日应收金额：%0.2f元",model.data.totalmoney]];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, attributedTextString.length-7)];
    _totalMoneyLabel.attributedText = attributedTextString;
    
//    NSString *strtwo = [NSString stringWithFormat:@"%0.2f",model.data.checkedmoney];
    NSMutableAttributedString * attributedTextString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已收金额：%0.2f元",model.data.checkedmoney]];
    [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
    [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5, attributedTextString2.length-5)];
    _correctMoneyLabel.attributedText = attributedTextString2;
    
    NSMutableAttributedString * attributedTextString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当面付支付宝：%0.2f元",model.data.alipay]];
    [attributedTextString4 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
    [attributedTextString4 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(7, attributedTextString4.length-7)];
    _alipayLabel.attributedText = attributedTextString4;
    
    NSMutableAttributedString * attributedTextString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"现金：%0.2f元",model.data.cash]];
    [attributedTextString5 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 3)];
    [attributedTextString5 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(3, attributedTextString5.length-3)];
    _cashLabel.attributedText =attributedTextString5;

    NSMutableAttributedString * attributedTextString6 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"POS刷卡：%0.2f元",model.data.pos]];
    [attributedTextString6 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
    [attributedTextString6 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5, attributedTextString6.length-5)];
    _posCardLabel.attributedText =attributedTextString6;

    NSMutableAttributedString * attributedTextString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"商家扫码：%0.2f元",model.data.paybackfee]];
    [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
    [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5, attributedTextString3.length-5)];
    _problemMoneyLabel.attributedText =attributedTextString3;

}

- (void)BigAndSmall{
    
    if (_isState) {


        _alipayLabel.hidden = YES;
        _lineThree.hidden = YES;
        _cashLabel.hidden = YES;
        _line3.hidden = YES;
        _posCardLabel.hidden = YES;
        _line4.hidden = YES;
        _problemMoneyLabel.hidden=YES;
//        _problemImgview.frame = CGRectMake(20, 120, 10, 10);
        _problemMoneyLabel.frame = CGRectMake(35,100,SCREEN_WIDTH-40,50);
        _imgv.transform = CGAffineTransformIdentity;

        _isState = NO;

        [self.delegate CellHeightWithState:NO];

    }else
    {
        _imgv.transform = CGAffineTransformMakeRotation((270.0f * M_PI) / 180.0f);

        _problemMoneyLabel.hidden=NO;

        _alipayLabel.hidden = NO;
        _lineThree.hidden = NO;
        _cashLabel.hidden = NO;
        _line3.hidden = NO;
        _posCardLabel.hidden = NO;
        _line4.hidden = NO;
        
//        _problemImgview.frame= CGRectMake(20, 270, 10, 10);
        _problemMoneyLabel.frame= CGRectMake(35,250,SCREEN_WIDTH-40,50);

        _isState = YES;

        [self.delegate CellHeightWithState:YES];

    }

}

@end
