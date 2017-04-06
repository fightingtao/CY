//
//  payReportTableVCell.h
//  HSApp
//
//  Created by cbwl on 16/10/30.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol payReportDelegate <NSObject>

-(void)payWayKindClick:(UIButton *)btn;
-(void)diEndTextInPut:(NSString *)text kind:(int)kind;

@end

@interface payReportTableVCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *alreadyMoney;
@property (weak, nonatomic) IBOutlet UIButton *payKindbtn;
@property (weak, nonatomic) IBOutlet UILabel *allmoney;
@property (weak, nonatomic) IBOutlet UITextField *willPay;
@property (weak, nonatomic) IBOutlet UITextField *payOrderId;
@property (weak, nonatomic) IBOutlet UITextField *remark;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (strong,nonatomic) id <payReportDelegate> delegate;
@end
