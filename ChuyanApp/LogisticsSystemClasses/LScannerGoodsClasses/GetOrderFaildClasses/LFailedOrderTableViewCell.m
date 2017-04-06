//
//  LFailedOrderTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/29.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LFailedOrderTableViewCell.h"

@implementation LFailedOrderTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_orderNumLabel) {
            _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,SCREEN_WIDTH-40,40)];
            _orderNumLabel.backgroundColor = [UIColor clearColor];
            _orderNumLabel.font = [UIFont systemFontOfSize:15];
            _orderNumLabel.textColor = TextMainCOLOR;
            _orderNumLabel.text = @"订单号：FJDLSF23498324";
            _orderNumLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderNumLabel.textAlignment = NSTextAlignmentLeft;
            _orderNumLabel.numberOfLines=0;

            [self addSubview:_orderNumLabel];
        }
        
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
            _line.backgroundColor = LineColor;
            [self addSubview:_line];
        }
        
        if (!_reasonLabel) {
            _reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,40,SCREEN_WIDTH-40,60)];
            _reasonLabel.backgroundColor = [UIColor clearColor];
            _reasonLabel.font = [UIFont systemFontOfSize:15];
            _reasonLabel.numberOfLines=0;

            _reasonLabel.textColor = TextMainCOLOR;
            _reasonLabel.text = @"失败原因：订单错误";
            _reasonLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _reasonLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_reasonLabel];
        }
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


- (void)setModel:(Out_LScanFailureBody*)model
{
    _orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.cwb];
    NSString *failedString = [NSString stringWithFormat:@"失败原因：%@",model.reasonmsg];
    NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",failedString]];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, failedString.length - 5)];
    _reasonLabel.attributedText = attributedTextString;
}

@end
