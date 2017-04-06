//
//  AlreadyAndNeedTableViewCell.m
//  HSApp
//
//  Created by cbwl on 16/5/2.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "AlreadyAndNeedTableViewCell.h"
#import "publicResource.h"

@implementation AlreadyAndNeedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        if (!_AlreadyBack) {
            _AlreadyBack = [[UILabel alloc] initWithFrame:CGRectMake(20,0,SCREEN_WIDTH-40,50)];
            _AlreadyBack.backgroundColor = [UIColor clearColor];
            _AlreadyBack.font = LargeFont;
            _AlreadyBack.textColor = TextMainCOLOR;
            _AlreadyBack.text = @"已付退款: 0元";
            _AlreadyBack.lineBreakMode = NSLineBreakByCharWrapping;
            _AlreadyBack.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_AlreadyBack];
        }
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
            _line.backgroundColor = LineColor;
            [self addSubview:_line];
        }
        
        if (!_NeedLabel) {
            _NeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,50,SCREEN_WIDTH-40,50)];
            _NeedLabel.backgroundColor = [UIColor clearColor];
            _NeedLabel.font = LargeFont;
            _NeedLabel.textColor = TextMainCOLOR;
            _NeedLabel.text = @"当日已缴金额: 0元";
            _NeedLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _NeedLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_NeedLabel];
        }
        
        if (!_line2) {
            _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0.5)];
            _line2.backgroundColor = LineColor;
            [self addSubview:_line2];
        }
        
    }
    return self;
}
- (void)setDataWithMode:(CYNSObject*)model;
{
    if (!model) {
        return;
    }
//    NSString *strone = [NSString stringWithFormat:@"已付退款:0000%0.2f元",model.data.totalmoney];


//    if (strone.length>0){
        NSMutableAttributedString * attributedTextString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已付退款：%0.2f元",model.data.yifuTuiFee]];
        [attributedTextString addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 5)];
        [attributedTextString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, attributedTextString.length-5)];
        _AlreadyBack .attributedText = attributedTextString;
    

//    }

    NSMutableAttributedString * attributedTextString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当日已缴金额：%0.2f元",model.data.payedfee]];
    [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:TextMainCOLOR range:NSMakeRange(0, 7)];
    [attributedTextString3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, attributedTextString3.length-7)];
    _NeedLabel.attributedText=attributedTextString3;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
