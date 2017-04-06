//
//  ScannerListTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/21.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "ScannerListTableViewCell.h"


@implementation ScannerListTableViewCell
@synthesize delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_orderNumLabel) {
            _orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,50)];
            _orderNumLabel.backgroundColor = [UIColor clearColor];
            _orderNumLabel.font = [UIFont systemFontOfSize:15];
            _orderNumLabel.textColor = TextMainCOLOR;
            _orderNumLabel.text = @"";
            _orderNumLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderNumLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_orderNumLabel];
        }
        
        
        if (!_cancelOrderBtn) {
            _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _cancelOrderBtn.frame = CGRectMake(SCREEN_WIDTH-50,15,20,20);
            [_cancelOrderBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
            [_cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"redx"] forState:UIControlStateNormal];
//            [self addSubview:_cancelOrderBtn];
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cancelClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [self.delegate cancelOrderWithIndex:btn.tag];
}
@end
