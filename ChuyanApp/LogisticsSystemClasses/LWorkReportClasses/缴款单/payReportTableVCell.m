//
//  payReportTableVCell.m
//  HSApp
//
//  Created by cbwl on 16/10/30.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "payReportTableVCell.h"

@implementation payReportTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.willPay.delegate=self;
    self.payOrderId.delegate=self;
    self.remark.delegate=self;
}
- (IBAction)payWaykind:(id)sender {
    [self.delegate payWayKindClick:(UIButton *)sender];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // 1 缴款金额  2 交易流水号  3 备注
    if (textField==self.willPay) {
        if ([self.delegate respondsToSelector:@selector(diEndTextInPut:kind:)]) {
            [self.delegate diEndTextInPut:textField.text kind:1];

        }

    }
    else if (textField==self.payOrderId){
        if ([self.delegate respondsToSelector:@selector(diEndTextInPut:kind:)]) {
        [self.delegate diEndTextInPut:textField.text kind:2];
        }
    }
    else if (textField==self.remark){
        if ([self.delegate respondsToSelector:@selector(diEndTextInPut:kind:)]) {
        [self.delegate diEndTextInPut:textField.text kind:3];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
