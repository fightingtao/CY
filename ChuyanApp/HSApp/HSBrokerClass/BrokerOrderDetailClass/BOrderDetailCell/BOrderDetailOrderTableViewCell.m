//
//  BOrderDetailOrderTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BOrderDetailOrderTableViewCell.h"

@implementation BOrderDetailOrderTableViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //各项控件初始化 start
        if (!_orderTypeLabel) {
            _orderTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0.5, 20, 20)];
            _orderTypeLabel.backgroundColor = [UIColor clearColor];
            _orderTypeLabel.font = [UIFont systemFontOfSize:12];
            _orderTypeLabel.textColor = DaiSongColor;
            _orderTypeLabel.text = @"送";
            _orderTypeLabel.layer.borderColor = DaiSongColor.CGColor;
            _orderTypeLabel.layer.borderWidth = 0.5;
            _orderTypeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _orderTypeLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_orderTypeLabel];
        }
        
        if (!_orderContentLabel) {
            _orderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,20, SCREEN_WIDTH-40, 20)];
            _orderContentLabel.backgroundColor = [UIColor clearColor];
            _orderContentLabel.font = LittleFont;
            _orderContentLabel.textColor = TextMainCOLOR;
            _orderContentLabel.text = @"呼：";
            _orderContentLabel.numberOfLines = 0;
//            _orderContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _orderContentLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_orderContentLabel];
        }
        
        if (!_orderVoiceBtn) {
            _orderVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _orderVoiceBtn.frame = CGRectMake(40, 20, 20, 20);
            [_orderVoiceBtn addTarget:self action:@selector(voicePlayClick) forControlEvents:UIControlEventTouchUpInside];
            [_orderVoiceBtn setImage:[UIImage imageNamed:@"btn_voice"] forState:UIControlStateNormal];
            [self addSubview:_orderVoiceBtn];
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


+ (CGFloat)cellHeightWithModel:(Out_OrderDetailBody*)model;
{
    if (!model)
    {
        return OrderCellHeigth;
        
    }else
    {
        //1:文字，2：语音
        if (model.type == 2)
        {
            if (model.picpaths&&[model.picpaths count] > 0)
            {
                return OrderCellHeigth+60;
            }
            return OrderCellHeigth;
        }else
        {
            CGFloat cellHeight = 0.0;
            cellHeight = cellHeight + 20.0;
            if (model.desc)
            {
                CGSize textSize = CGSizeMake(SCREEN_WIDTH-40, CGFLOAT_MAX);
                NSString *text = model.desc;
                NSDictionary *attribute = @{NSFontAttributeName:LittleFont};
                CGSize sizeWithFont = [text boundingRectWithSize:textSize options:
                                       NSStringDrawingTruncatesLastVisibleLine |
                                       NSStringDrawingUsesLineFragmentOrigin |
                                       NSStringDrawingUsesFontLeading
                                                      attributes:attribute context:nil].size;
                
                CGFloat contentLabelHeight = 0.0f;
                
#if defined(__LP64__) && __LP64__
                contentLabelHeight = ceil(sizeWithFont.height);
#else
                contentLabelHeight =  ceilf(sizeWithFont.height);
#endif
                if (contentLabelHeight <20.0) {
                    cellHeight = cellHeight + 30.0;
                }else{
                    cellHeight = cellHeight + contentLabelHeight+10;
                }
                
                if (model.picpaths&&[model.picpaths count] > 0)
                {
                    return cellHeight+60;
                }
            }
            return cellHeight;
        }

    }
}


- (void)setOrderContentWithModel:(Out_OrderDetailBody*)model;
{
    _tempModel = model;
    if (!model) {
        
        
    }else
    {
        //呼单类型，1：代办，2：代购，3：代送
        if (model.orderTypeId == 1) {
            _orderTypeLabel.textColor = DaiBanColor;
            _orderTypeLabel.text = @"办";
            _orderTypeLabel.layer.borderColor = DaiBanColor.CGColor;
        }else if (model.orderTypeId == 2)
        {
            _orderTypeLabel.textColor = DaiGouColor;
            _orderTypeLabel.text = @"购";
            _orderTypeLabel.layer.borderColor = DaiGouColor.CGColor;
        }else{
            _orderTypeLabel.textColor = DaiSongColor;
            _orderTypeLabel.text = @"送";
            _orderTypeLabel.layer.borderColor = DaiSongColor.CGColor;
        }
        //1:文字，2：语音
        if (model.type == 1)
        {
            CGFloat cellHeight = 0.0;
            cellHeight = cellHeight + 20.0;
            if (model.desc)
            {
                CGSize textSize = CGSizeMake(SCREEN_WIDTH-40, CGFLOAT_MAX);
                NSString *text = model.desc;
                NSDictionary *attribute = @{NSFontAttributeName:LittleFont};
                CGSize sizeWithFont = [text boundingRectWithSize:textSize options:
                                       NSStringDrawingTruncatesLastVisibleLine |
                                       NSStringDrawingUsesLineFragmentOrigin |
                                       NSStringDrawingUsesFontLeading
                                                      attributes:attribute context:nil].size;
                
                CGFloat contentLabelHeight = 0.0f;
                
#if defined(__LP64__) && __LP64__
                contentLabelHeight = ceil(sizeWithFont.height);
#else
                contentLabelHeight =  ceilf(sizeWithFont.height);
#endif
                if (contentLabelHeight <20.0) {
                    cellHeight = cellHeight + 30.0;
                    _orderContentLabel.frame = CGRectMake(20,20, SCREEN_WIDTH-40, 20);
                }else{
                    cellHeight = cellHeight + contentLabelHeight+10;
                    _orderContentLabel.frame = CGRectMake(20,20, SCREEN_WIDTH-40, contentLabelHeight);
                }
                
                if (model.picpaths&&[model.picpaths count] > 0)
                {
                    for (int i = 0; i < [model.picpaths count]; i++)
                    {
                        NSString *imgString = [model.picpaths objectAtIndex:i];
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        if (contentLabelHeight <20.0) {
                            btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), cellHeight+60-50, 40, 40);
                        }else
                        {
                            btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), cellHeight+60-contentLabelHeight-20, 40, 40);
                        }

                        [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgString]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
                        btn.tag = i;
                        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                        [self addSubview:btn];
                        
                    }
                }

            }

            _orderContentLabel.text = [NSString stringWithFormat:@"呼：%@",model.desc];
            _orderVoiceBtn.hidden = YES;
        }else
        {
            _orderContentLabel.text = @"呼：";
            _orderVoiceBtn.hidden = NO;
            
            if (model.picpaths&&[model.picpaths count] > 0)
            {
                for (int i = 0; i < [model.picpaths count]; i++)
                {
                    NSString *imgString = [model.picpaths objectAtIndex:i];
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), OrderCellHeigth+10, 40, 40);
                    [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgString]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
                    btn.tag = i;
                    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:btn];
                    
                }
            }
        }
    }

}

//语音播放
- (void)voicePlayClick
{
    [self.delegate playVoiceWithModel:_tempModel];
}

- (void)btnClick:(UIButton *)btn
{
    [self.delegate showOrderImgWithModel:_tempModel AndIndex:btn.tag];
}
@end
