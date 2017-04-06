//
//  DSTableViewCell.m
//  HSApp
//
//  Created by cbwl on 16/5/3.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "DSTableViewCell.h"

#import "publicResource.h"

@implementation DSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_OrderIdLable) {
            _OrderIdLable = [[UILabel alloc] initWithFrame:CGRectMake(22,0, SCREEN_WIDTH, 50)];
            _OrderIdLable.backgroundColor = [UIColor clearColor];
            _OrderIdLable.font = LittleFont;
            _OrderIdLable.textColor = TextMainCOLOR;
            _OrderIdLable.text = @"订单号:";
            _OrderIdLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _OrderIdLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_OrderIdLable];
        }
        
        
        if (!_LineOne) {
            _LineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
            _LineOne.backgroundColor = LineColor;
            [self addSubview:_LineOne];
        }

        if (!_WaitLable) {
            _WaitLable = [[UILabel alloc] initWithFrame:CGRectMake(22,50, SCREEN_WIDTH/2, 50)];
            _WaitLable.backgroundColor = [UIColor clearColor];
            _WaitLable.font = LittleFont;
            _WaitLable.textColor = TextMainCOLOR;
            _WaitLable.text = @"待付款:";
            _WaitLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _WaitLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_WaitLable];
        }
        
        if (!_LineTwo) {
            _LineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0.5)];
            _LineTwo.backgroundColor = LineColor;
            [self addSubview:_LineTwo];
        }
        
        if (!_YuELable) {
            _YuELable = [[UILabel alloc] initWithFrame:CGRectMake(22,100, SCREEN_WIDTH/2, 50)];
            _YuELable.backgroundColor = [UIColor clearColor];
            _YuELable.font = LittleFont;
            _YuELable.textColor = TextMainCOLOR;
            _YuELable.text = @"余额:";
            _YuELable.lineBreakMode = NSLineBreakByTruncatingTail;
            _YuELable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_YuELable];
        }
        
        if (!_LineThree) {
            _LineThree = [[UIView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 0.5)];
            _LineThree.backgroundColor = LineColor;
            [self addSubview:_LineThree];
        }
        
        if (!_NeedLable) {
            _NeedLable = [[UILabel alloc] initWithFrame:CGRectMake(22,150, SCREEN_WIDTH/2, 50)];
            _NeedLable.backgroundColor = [UIColor clearColor];
            _NeedLable.font = LittleFont;
            _NeedLable.textColor = TextMainCOLOR;
            _NeedLable.text = @"还需支付:";
            _NeedLable.lineBreakMode = NSLineBreakByTruncatingTail;
            _NeedLable.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_NeedLable];
//            NSDictionary *dic;
                   }
        
    }
    return self;
}

- (void)ReturnDataWithDic:(NSDictionary *)Dic WithOrderid:(NSString *)orderid{
    
    _OrderIdLable.text = [NSString stringWithFormat:@"订单号:        %@",orderid];
    _WaitLable.text = [NSString stringWithFormat:@"待付款:        %0.2f元",[[[Dic objectForKey:@"data"]objectForKey:@"totalFee"] floatValue]];
    _YuELable.text = [NSString stringWithFormat:@"余额:        %0.2f元",[[[Dic objectForKey:@"data"]objectForKey:@"balance"] floatValue]];
    
    NSString *str = [NSString stringWithFormat:@"%@",[[Dic objectForKey:@"data"]objectForKey:@"balance"]];
    NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还需付款:        %0.2f元",[[[Dic objectForKey:@"data"]objectForKey:@"balance"] floatValue]]];
                                                        
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(5, str.length+12 )];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(5,  str.length+12)];
    _NeedLable.attributedText = attributedTextString;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
