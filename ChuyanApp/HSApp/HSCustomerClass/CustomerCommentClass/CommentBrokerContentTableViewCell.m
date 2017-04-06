//
//  CommentBrokerContentTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CommentBrokerContentTableViewCell.h"

@implementation CommentBrokerContentTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        self.contentView.backgroundColor = ViewBgColor;
        if (!_menuView) {
            _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
            _menuView.backgroundColor = WhiteBgColor;
            [self addSubview:_menuView];
        }
        
        if (!_tipLabel) {
            _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,5, 30, 20)];
            _tipLabel.backgroundColor = [UIColor clearColor];
            _tipLabel.font = LittleFont;
            _tipLabel.textColor = TextMainCOLOR;
            _tipLabel.text = @"评价";
            _tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _tipLabel.textAlignment = NSTextAlignmentLeft;
            [_menuView addSubview:_tipLabel];
        }
        
        
        if (!_starView) {
            _starView = [[LHRatingView alloc]initWithFrame:CGRectMake(50, 5, 95, 20)];
            _starView.enbleEdit = YES;
            _starView.score = 5.0;
            _starView.delegate = self;
            [_menuView addSubview:_starView];
            
        }
        
        if (!_demandTextView) {
            _demandTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 25, SCREEN_WIDTH-40, 150)];
            _demandTextView.textColor = TextMainCOLOR;//设置textview里面的字体颜色
            _demandTextView.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
            _demandTextView.delegate = self;//设置它的委托方法
            _demandTextView.backgroundColor = WhiteBgColor;//设置它的背景颜色
            _demandTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
            _demandTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
            _demandTextView.scrollEnabled = NO;//是否可以拖动
            _demandTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [_menuView addSubview:_demandTextView];
        }
        
        if (!_placeLabel) {
            _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 28, SCREEN_WIDTH-40, 40)];
            _placeLabel.numberOfLines = 2;
            _placeLabel.backgroundColor = [UIColor clearColor];
            _placeLabel.textAlignment = NSTextAlignmentLeft;
            _placeLabel.font = LittleFont;
            _placeLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
            _placeLabel.text = @"你可以写下对经纪人的这次呼单服务的评价！字数在140字以内哦！";
            [_menuView addSubview:_placeLabel];
        }

        //end
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

+ (CGFloat)cellHeight
{
    return CBrokerContentCellHeigth;
}

#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    [self.delegate StarScore:score];
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [self.demandTextView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.demandTextView.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            _placeLabel.hidden=NO;//隐藏文字
        }else{
            _placeLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.demandTextView.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                _placeLabel.hidden=NO;
            }else{//不是删除
                _placeLabel.hidden=YES;
            }
        }else{//长度不为1时候
            _placeLabel.hidden=YES;
        }
    }
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    [self.delegate commentContent:_demandTextView.text];
}

@end
