//
//  LogisticsTotalTableViewCell.m
//  HSApp
//
//  Created by xc on 16/1/18.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "LogisticsTotalTableViewCell.h"
#import "LSendGoodsViewController.h"
@interface LogisticsTotalTableViewCell ()


@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *todayOrderTipLabel;
@property (nonatomic, strong) UIButton *todayOrderNumLabel;
@property (nonatomic, strong) UILabel *todayMoneyTipLabel;
@property (nonatomic, strong) UILabel *todayMoneyNumLabel;
@property (nonatomic, strong) UILabel *OrderLabel;





@end

@implementation LogisticsTotalTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = MAINCOLOR;
        self.contentView.alpha = 0.9;
        if (!_line) {
            //_line = [[UIView alloc] initWithFrame:CGRectMake(0, 228, SCREEN_WIDTH, 0.5)];
            _line = [[UIView alloc]init];
            _line.backgroundColor = WhiteBgColor;
            [self addSubview:_line];
        }
        //各项控件初始化 start
        if (!_todayOrderNumLabel) {

            _todayOrderNumLabel = [UIButton buttonWithType:UIButtonTypeCustom];
            _todayOrderNumLabel.backgroundColor = MAINCOLOR;
            [_todayOrderNumLabel setTitleColor:WhiteBgColor forState:UIControlStateNormal];
            [_todayOrderNumLabel addTarget:self action:@selector(todayOrderBtn) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_todayOrderNumLabel];
            
        }
        
        if (!_OrderLabel) {
            _OrderLabel = [[UILabel alloc]init];
            _OrderLabel.textColor = WhiteBgColor;
            _OrderLabel.text = @"0.0";
            [self addSubview:_OrderLabel];
        }
        
        if (!_todayOrderTipLabel) {
            //_todayOrderTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,40,SCREEN_WIDTH , 30)];
            _todayOrderTipLabel = [[UILabel alloc]init];
            _todayOrderTipLabel.backgroundColor = [UIColor clearColor];
            _todayOrderTipLabel.font = [UIFont systemFontOfSize:16];
            _todayOrderTipLabel.textColor = WhiteBgColor;
            _todayOrderTipLabel.text = @"今日待配送(单)";
            _todayOrderTipLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _todayOrderTipLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_todayOrderTipLabel];
            

        }
        
        if (!_todayMoneyTipLabel) {
            //_todayMoneyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,270,SCREEN_WIDTH , 30)];
            _todayMoneyTipLabel = [[UILabel alloc]init];
            _todayMoneyTipLabel.backgroundColor = [UIColor clearColor];
            _todayMoneyTipLabel.font = [UIFont systemFontOfSize:16];
            _todayMoneyTipLabel.textColor = WhiteBgColor;
            _todayMoneyTipLabel.text = @"今日待收款(元)";
            _todayMoneyTipLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _todayMoneyTipLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_todayMoneyTipLabel];
        }
        
        if (!_todayMoneyNumLabel) {
            //_todayMoneyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,300,SCREEN_WIDTH , 60)];
            _todayMoneyNumLabel = [[UILabel alloc]init];
            _todayMoneyNumLabel.backgroundColor = [UIColor clearColor];
            _todayMoneyNumLabel.font = [UIFont systemFontOfSize:55];
            _todayMoneyNumLabel.textColor = WhiteBgColor;
            _todayMoneyNumLabel.text = @"0.0";
            _todayMoneyNumLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _todayMoneyNumLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_todayMoneyNumLabel];
        }
        if (SCREEN_HEIGHT ==480) {
            
            _line.frame = CGRectMake(0, 120, SCREEN_WIDTH, 0.5);
            _todayOrderNumLabel.frame = CGRectMake((SCREEN_WIDTH-130)/2,11,130 , 130);
            _todayOrderTipLabel.frame = CGRectMake(0,40,SCREEN_WIDTH , 30);
            _todayMoneyTipLabel.frame = CGRectMake(0,145,SCREEN_WIDTH , 30);
            _todayMoneyNumLabel.frame = CGRectMake(0,167,SCREEN_WIDTH , 60);
    
            _todayOrderNumLabel.layer.borderColor = WhiteBgColor.CGColor;
            _todayOrderNumLabel.layer.borderWidth = 0.5;
            _todayOrderNumLabel.layer.cornerRadius = 65.0f;
            _todayOrderNumLabel.clipsToBounds = YES;
    
            _OrderLabel.font = [UIFont systemFontOfSize:55];
            _OrderLabel.frame = CGRectMake(0, 65, SCREEN_WIDTH, 60);
            _OrderLabel.textAlignment = NSTextAlignmentCenter;
            
            _todayMoneyNumLabel.font = [UIFont systemFontOfSize:45];

        }
        else if (SCREEN_HEIGHT ==568){
            _line.frame = CGRectMake(0, 160, SCREEN_WIDTH, 0.5);
            _todayOrderNumLabel.frame = CGRectMake((SCREEN_WIDTH-175)/2,11,175 , 175);
            _todayOrderTipLabel.frame = CGRectMake(0,40,SCREEN_WIDTH , 30);
            _todayMoneyTipLabel.frame = CGRectMake(0,195,SCREEN_WIDTH , 30);
            _todayMoneyNumLabel.frame = CGRectMake(0,220,SCREEN_WIDTH , 60);
            
            _todayOrderNumLabel.layer.borderColor = WhiteBgColor.CGColor;
            _todayOrderNumLabel.layer.borderWidth = 0.5;
            _todayOrderNumLabel.layer.cornerRadius = 85.0f;
            _todayOrderNumLabel.clipsToBounds = YES;
            
            _OrderLabel.font = [UIFont systemFontOfSize:80];
            _OrderLabel.frame = CGRectMake(0, 80, SCREEN_WIDTH, 80);
            _OrderLabel.textAlignment = NSTextAlignmentCenter;
            
        }
        else if (SCREEN_HEIGHT ==667){
            _line.frame = CGRectMake(0, 228, SCREEN_WIDTH, 0.5);
            _todayOrderNumLabel.frame = CGRectMake((SCREEN_WIDTH-235)/2,11,235 , 235);
            _todayOrderTipLabel.frame = CGRectMake(0,50,SCREEN_WIDTH , 30);
            _todayMoneyTipLabel.frame = CGRectMake(0,270,SCREEN_WIDTH , 30);
            _todayMoneyNumLabel.frame = CGRectMake(0,300,SCREEN_WIDTH , 60);
            _todayOrderNumLabel.clipsToBounds = YES;
            
            _todayOrderNumLabel.layer.borderColor = WhiteBgColor.CGColor;
            _todayOrderNumLabel.layer.borderWidth = 0.5;
            _todayOrderNumLabel.layer.cornerRadius = 115.0f;
            
            _OrderLabel.font = [UIFont systemFontOfSize:110];
            _OrderLabel.frame = CGRectMake(0, 110, SCREEN_WIDTH, 80);
            _OrderLabel.textAlignment = NSTextAlignmentCenter;
            
            _todayOrderTipLabel.font = [UIFont systemFontOfSize:20];
            
        }
        else if (SCREEN_HEIGHT ==736){
            _line.frame = CGRectMake(0, 228, SCREEN_WIDTH, 0.5);
            _todayOrderNumLabel.frame = CGRectMake((SCREEN_WIDTH-235)/2,11,235 , 235);
            _todayOrderTipLabel.frame = CGRectMake(0,50,SCREEN_WIDTH , 30);
            _todayMoneyTipLabel.frame = CGRectMake(0,270,SCREEN_WIDTH , 30);
            _todayMoneyNumLabel.frame = CGRectMake(0,300,SCREEN_WIDTH , 60);
            _todayOrderNumLabel.clipsToBounds = YES;
            
            _todayOrderNumLabel.layer.borderColor = WhiteBgColor.CGColor;
            _todayOrderNumLabel.layer.borderWidth = 0.5;
            _todayOrderNumLabel.layer.cornerRadius = 115.0f;
            
            _OrderLabel.font = [UIFont systemFontOfSize:110];
            _OrderLabel.frame = CGRectMake(0, 110, SCREEN_WIDTH, 80);
            _OrderLabel.textAlignment = NSTextAlignmentCenter;
            
            _todayOrderTipLabel.font = [UIFont systemFontOfSize:20];
        }
        
        //end
    }
    return self;
}
- (void)todayOrderBtn{

    [self.delegate JumpPage];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Out_LogisticsHomeBody*)model{
    if (!model) {
        return;
    }
    _OrderLabel.text = [NSString stringWithFormat:@"%d",model.deliverycount];
    
    _todayMoneyNumLabel.text = [NSString stringWithFormat:@"%0.2f",model.deliverycod];

}

@end
