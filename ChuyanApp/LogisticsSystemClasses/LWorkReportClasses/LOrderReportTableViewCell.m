//
//  LOrderReportTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/26.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LOrderReportTableViewCell.h"

@implementation LOrderReportTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        if (!_totalOrderLabel) {
            _totalOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,SCREEN_WIDTH-40,50)];
            _totalOrderLabel.backgroundColor = [UIColor clearColor];
            _totalOrderLabel.font = LargeFont;
//            _totalOrderLabel.textColor = TextMainCOLOR;
            NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:@"当日订单总数：0单"];
            [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
            [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, attributedTextString.length-7)];

            _totalOrderLabel.attributedText = attributedTextString;
            _totalOrderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _totalOrderLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_totalOrderLabel];
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
        
        if (!_correctOrderLabel) {
            _correctOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,50,SCREEN_WIDTH-40,50)];
            _correctOrderLabel.backgroundColor = [UIColor clearColor];
            _correctOrderLabel.font = LargeFont;
            _correctOrderLabel.textColor = TextMainCOLOR;
//            _correctOrderLabel.text = @"妥投数：0单";
            NSMutableAttributedString * attributedTextString2 = [[NSMutableAttributedString alloc] initWithString:@"妥投数：0单"];
            [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 4)];
            [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(4, attributedTextString2.length-4)];
            _correctOrderLabel.attributedText = attributedTextString2;
            _correctOrderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _correctOrderLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_correctOrderLabel];
        }
        
        
        if (!_line2) {
            _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0.5)];
            _line2.backgroundColor = LineColor;
            [self addSubview:_line2];
        }
        
        if (!_problemImgview) {
            _problemImgview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 10, 10)];
            _problemImgview.contentMode = UIViewContentModeScaleAspectFill;
            _problemImgview.image = [UIImage imageNamed:@"red"];
            [self addSubview:_problemImgview];
        }
        
        if (!_problemOrderLabel) {
            _problemOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,100,SCREEN_WIDTH-40,50)];
            _problemOrderLabel.backgroundColor = [UIColor clearColor];
            _problemOrderLabel.font = LargeFont;
            _problemOrderLabel.textColor = TextMainCOLOR;
//            _problemOrderLabel.text = @"异常数：0单";
            NSMutableAttributedString * attributedTextString3 = [[NSMutableAttributedString alloc] initWithString:@"异常数：0单"];
            [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 4)];
            [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attributedTextString3.length-4)];
            _problemOrderLabel.attributedText = attributedTextString3 ;
            _problemOrderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _problemOrderLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_problemOrderLabel];
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

- (void)setDataWithModel:(CYNSObject*)model
{
    
    if (!model) {
        return;
    }
    
    NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当日订单总数：%d单",model.data.totalcount]];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
    [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, attributedTextString.length-7)];
    _totalOrderLabel.attributedText = attributedTextString;
    
    NSMutableAttributedString * attributedTextString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"妥投数：%d单",model.data.successcount]];
    [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 4)];
    [attributedTextString2 addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:NSMakeRange(4, attributedTextString2.length-4)];
    _correctOrderLabel.attributedText = attributedTextString2;
    
    NSMutableAttributedString * attributedTextString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"异常数：%d单",model.data.exptcount]];
    [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 4)];
    [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attributedTextString3.length-4)];
    _problemOrderLabel.attributedText = attributedTextString3 ;
}

@end
