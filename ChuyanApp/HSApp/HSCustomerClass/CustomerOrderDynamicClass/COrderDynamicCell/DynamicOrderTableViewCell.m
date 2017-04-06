//
//  DynamicOrderTableViewCell.m
//  HSApp
//
//  Created by xc on 15/11/13.
//  Copyright © 2015年 xc. All rights reserved.

#import "DynamicOrderTableViewCell.h"

#import "UIView+SDAutoLayout.h"


@implementation DynamicOrderTableViewCell
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
            [self.contentView addSubview:_orderTypeLabel];
        }
        
        if (!_headImgView) {
            _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 20, 50, 50)];
            _headImgView.contentMode = UIViewContentModeScaleAspectFill;
            _headImgView.layer.cornerRadius = 25;
            _headImgView.layer.masksToBounds = YES;
            //边框宽度及颜色设置
            [_headImgView.layer setBorderWidth:0.1];
            [_headImgView.layer setBorderColor:[UIColor clearColor].CGColor];
            _headImgView.image = [UIImage imageNamed:@"home_def_head-portrait"];
            _headImgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)];
            [_headImgView addGestureRecognizer:singleTap1];
            [self.contentView addSubview:_headImgView];
        }
        
        if (!_nameLabel) {
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, 120, 30)];
            _nameLabel.backgroundColor = [UIColor clearColor];
            _nameLabel.font = LittleFont;
            _nameLabel.textColor = TextMainCOLOR;
            _nameLabel.text = @"一呼哥";
            _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_nameLabel];
        }
        
        if (!_orderContentLabel) {
            _orderContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,15, SCREEN_WIDTH-140, 20)];
            _orderContentLabel.backgroundColor = [UIColor clearColor];
            _orderContentLabel.font = LittleFont;
            _orderContentLabel.textColor = TextMainCOLOR;
            _orderContentLabel.text = @"呼：";
            _orderContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _orderContentLabel.textAlignment = NSTextAlignmentLeft;
            _orderContentLabel.numberOfLines = 0;
            [self.contentView addSubview:_orderContentLabel];
            
        }
        
        if (!_orderVoiceBtn) {
            _orderVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _orderVoiceBtn.frame = CGRectMake(150, 15, 20, 20);
            [_orderVoiceBtn addTarget:self action:@selector(voicePlayClick) forControlEvents:UIControlEventTouchUpInside];
            [_orderVoiceBtn setImage:[UIImage imageNamed:@"btn_voice"] forState:UIControlStateNormal];
            [self.contentView addSubview:_orderVoiceBtn];
        }
        if (!_getAddressLabel) {
            _getAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,45, SCREEN_WIDTH-140, 20)];
            _getAddressLabel.backgroundColor = [UIColor clearColor];
            _getAddressLabel.font = LittleFont;
            _getAddressLabel.textColor = TextMainCOLOR;
            _getAddressLabel.text = @"取：长江贸易大楼";
            _getAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _getAddressLabel.textAlignment = NSTextAlignmentLeft;
            _getAddressLabel.numberOfLines = 0;
            [self.contentView addSubview:_getAddressLabel];
            
            
        }
        
        if (!_sendAddressLabel) {
            _sendAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,75, SCREEN_WIDTH-140, 20)];
            _sendAddressLabel.backgroundColor = [UIColor clearColor];
            _sendAddressLabel.font = LittleFont;
            _sendAddressLabel.textColor = TextMainCOLOR;
            _sendAddressLabel.text = @"送：长江贸易大楼";
            _sendAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _sendAddressLabel.textAlignment = NSTextAlignmentLeft;
            _sendAddressLabel.numberOfLines = 0;
            [self.contentView addSubview:_sendAddressLabel];
        }
    
        if (!_line2) {
            _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 169, SCREEN_WIDTH, 1)];
            _line2.backgroundColor = LineColor;
            _line2.hidden = YES;
            [self.contentView addSubview:_line2];
        }
        
        if (!_detailView) {
            _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, OrderCellHeigth-36, SCREEN_WIDTH, 36)];
            _detailView.backgroundColor = WhiteBgColor;
            [self.contentView addSubview:_detailView];
        }
        
        if (!_line) {
            _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            _line.backgroundColor = LineColor;
            [_detailView addSubview:_line];
        }
        
        if (!_tipsLabel) {
            _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(31,0, SCREEN_WIDTH/2, 36)];
            _tipsLabel.backgroundColor = [UIColor clearColor];
            _tipsLabel.font = LittleFont;
            _tipsLabel.textColor = TextMainCOLOR;
            _tipsLabel.text = @"小费20元";
            _tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _tipsLabel.textAlignment = NSTextAlignmentLeft;
            [_detailView addSubview:_tipsLabel];
        }
        
        
        if (!_commentBtn) {
            _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _commentBtn.frame = CGRectMake(SCREEN_WIDTH-115, 3, 30, 30);
            [_commentBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
            [_commentBtn setImage:[UIImage imageNamed:@"icon-comment"] forState:UIControlStateNormal];
            [_detailView addSubview:_commentBtn];
        }
        
        if (!_commentCountLabel) {
            _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90,0, 20, 36)];
            _commentCountLabel.backgroundColor = [UIColor clearColor];
            _commentCountLabel.font = LittleFont;
            _commentCountLabel.textColor = TextMainCOLOR;
            _commentCountLabel.text = @"88";
            _commentCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _commentCountLabel.textAlignment = NSTextAlignmentCenter;
            [_detailView addSubview:_commentCountLabel];
        }
        
        if (!_praiseBtn) {
            _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _praiseBtn.frame = CGRectMake(SCREEN_WIDTH-65, 3, 30, 30);
            [_praiseBtn addTarget:self action:@selector(praiseClick) forControlEvents:UIControlEventTouchUpInside];
            [_praiseBtn setImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
            [_detailView addSubview:_praiseBtn];
        }
        
        if (!_praiseCountLabel) {
            _praiseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40,0, 20, 36)];
            _praiseCountLabel.backgroundColor = [UIColor clearColor];
            _praiseCountLabel.font = LittleFont;
            _praiseCountLabel.textColor = TextMainCOLOR;
            _praiseCountLabel.text = @"22";
            _praiseCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _praiseCountLabel.textAlignment = NSTextAlignmentCenter;
            [_detailView addSubview:_praiseCountLabel];
        }
        
//        _orderContentLabel.sd_layout
//        .topSpaceToView(self.contentView, 20)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
//
//        _getAddressLabel.sd_layout
//        .topSpaceToView(_orderContentLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
//        
//        
//        _sendAddressLabel.sd_layout
//        .topSpaceToView(_getAddressLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
//        
//        
//        _detailView.sd_layout
//        .topSpaceToView(_sendAddressLabel, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .leftSpaceToView(self.contentView,0);
        
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


- (CGFloat)cellHeightWithModel:(Out_OrderDynamicBody*)model
{
    if (!model)
    {
        return OrderCellHeigth;
        
    }else
    {
        
        if (model.picpaths&&[model.picpaths count] > 0){
            
            // 语音
            if (model.type == 2) {
                //(120,15, SCREEN_WIDTH-140, 20)]
                //120,75, SCREEN_WIDTH-140, 20)
                
                CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text1 = model.desc;
                NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
            
                _orderContentLabel.frame = CGRectMake(120, _orderVoiceBtn.frame.origin.y + _orderVoiceBtn.frame.size.height+10, SCREEN_WIDTH-140, sizeWithFont1.height);
                
                CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text2 = model.toAddress;
                NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;

                _sendAddressLabel.frame = CGRectMake(120, _orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height +10 , SCREEN_WIDTH - 140, sizeWithFont2.height);
                
                return _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height + 30 + 40 + 36;
            }
            else{
                
                //(120,15, SCREEN_WIDTH-140, 20)]
                //120,75, SCREEN_WIDTH-140, 20)
                
                CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text1 = model.desc;
                NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
                
                //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LittleFont} context:nil];
                _orderContentLabel.frame = CGRectMake(120, 15, SCREEN_WIDTH-140, sizeWithFont1.height);
                
                CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text2 = model.toAddress;
                NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
                
                //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LittleFont} context:nil];
                _sendAddressLabel.frame = CGRectMake(120,_orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height + 20 , SCREEN_WIDTH - 140, sizeWithFont2.height);
                
                return _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height  + 30 + 40 + 10 + 36;
                
            }
            
            return 0;
        }
        else{
            
            // 语音
            if (model.type == 2) {
                
                CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text1 = model.desc;
                NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
                
                //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LittleFont} context:nil];
                _orderContentLabel.frame = CGRectMake(120, _orderVoiceBtn.frame.origin.y + _orderVoiceBtn.frame.size.height+10, SCREEN_WIDTH-140, sizeWithFont1.height);
                
                CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text2 = model.toAddress;
                NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
                
                //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LittleFont} context:nil];
                _sendAddressLabel.frame = CGRectMake(120, _orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height , SCREEN_WIDTH - 140, sizeWithFont2.height);
                
                return _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height + 30 + 36;
            }
            else{
                
                CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text1 = model.desc;
                NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
                
                //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LittleFont} context:nil];
                
                _orderContentLabel.frame = CGRectMake(120, 15, SCREEN_WIDTH-140, sizeWithFont1.height+20);
                
                CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
                NSString *text2 = model.toAddress;
                NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
                //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LittleFont} context:nil];
                
                _sendAddressLabel.frame = CGRectMake(120,_orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height +10, SCREEN_WIDTH - 140, sizeWithFont2.height);
                
                return _sendAddressLabel.frame.origin.y+ _sendAddressLabel.frame.size.height + 10 + 30 + 36+20;
                
            }
            
            return 0;
        }
        
    }
    
}


- (void)setModel:(Out_OrderDynamicBody *)model
{
    _model = model;
    
    if (model.picpaths&&[model.picpaths count] > 0) {
        
        //1是文字，2是语音
        if (model.type == 2) {
            
            _orderContentLabel.hidden = NO;
            _orderVoiceBtn.hidden = NO;
            _orderContentLabel.text = [NSString stringWithFormat:@"呼：%@",model.desc];
            
            
            CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text1 = model.desc;
            NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
            //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _orderContentLabel.frame = CGRectMake(120, 15, SCREEN_WIDTH-140, sizeWithFont1.height);
            
            CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text2 = model.toAddress;
            NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
            
            //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _sendAddressLabel.frame = CGRectMake(120, _orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height +20, SCREEN_WIDTH - 140, sizeWithFont2.height);
            
            for (int i = 0; i < [model.picpaths count]; i++)
            {
                NSString *imgString = [model.picpaths objectAtIndex:i];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height+30 +10, 40, 40);
                [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgString]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
                btn.tag = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                
            }
            
            _detailView.frame = CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height + 10 + 10 + 30 + 40 , SCREEN_WIDTH, 36);
            _line2.hidden = YES;
            
            
        }
        else{
            
            _orderContentLabel.hidden = NO;
            _orderVoiceBtn.hidden = YES;
            _orderContentLabel.text = [NSString stringWithFormat:@"呼：%@",model.desc];
            
            CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text1 = model.desc;
            NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
            
            //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _orderContentLabel.frame = CGRectMake(120, 15 , SCREEN_WIDTH-140, sizeWithFont1.height);
            
            CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text2 = model.toAddress;
            NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
            
            //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _sendAddressLabel.frame = CGRectMake(120, _orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height +15 , SCREEN_WIDTH - 140, sizeWithFont2.height);
            
            for (int i = 0; i < [model.picpaths count]; i++)
            {
                NSString *imgString = [model.picpaths objectAtIndex:i];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake((SCREEN_WIDTH-20-(40+10)*[model.picpaths count]+(40+10)*i), _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height+30, 40, 40);
                [btn setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgString]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
                btn.tag = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                
            }
            
            _detailView.frame = CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height + 30 + 40 + 10, SCREEN_WIDTH, 36);
            
            _line2.hidden = YES;
            
        }
        
    }else
    {
        //1是文字，2是语音
        if (model.type == 2) {
            
            _orderContentLabel.hidden = NO;
            _orderVoiceBtn.hidden = NO;
            _orderContentLabel.text = [NSString stringWithFormat:@"呼：%@",model.desc];
            
            CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text1 = model.desc;
            NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
            //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _orderContentLabel.frame = CGRectMake(120, 15, SCREEN_WIDTH-140, sizeWithFont1.height);
            
            CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text2 = model.toAddress;
            NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
            
            //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _sendAddressLabel.frame = CGRectMake(120, _orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height +20, SCREEN_WIDTH - 140, sizeWithFont2.height);
            _detailView.frame = CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height + 12 + 30 , SCREEN_WIDTH, 36);
            _line2.hidden = YES;
            
            
        }
        else{
            
            _orderContentLabel.hidden = NO;
            _orderVoiceBtn.hidden = YES;
            _orderContentLabel.text = [NSString stringWithFormat:@"呼：%@",model.desc];
            
            CGSize textSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text1 = model.desc;
            NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont1 = [text1 boundingRectWithSize:textSize1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
            //CGRect rect1 = [model.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _orderContentLabel.frame = CGRectMake(120, 15 , SCREEN_WIDTH-140, sizeWithFont1.height);
            
            CGSize textSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width-140, CGFLOAT_MAX);
            NSString *text2 = model.toAddress;
            NSDictionary *attribute2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize sizeWithFont2 = [text2 boundingRectWithSize:textSize2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
            
            //CGRect rect2 = [model.toAddress boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LittleFont} context:nil];
            _sendAddressLabel.frame = CGRectMake(120, _orderContentLabel.frame.origin.y + _orderContentLabel.frame.size.height +20+20, SCREEN_WIDTH - 140, sizeWithFont2.height);
            _detailView.frame = CGRectMake(0, _sendAddressLabel.frame.origin.y + _sendAddressLabel.frame.size.height + 20 + 30, SCREEN_WIDTH, 36);
            
            _line2.hidden = YES;
            
        }
        
    }
    
    //呼单类型，1：代办，2：代购，3：代送
    if (model.orderTypeId == 1) {
        _orderTypeLabel.textColor = DaiBanColor;
        _orderTypeLabel.text = @"办";
        _orderTypeLabel.layer.borderColor = DaiBanColor.CGColor;
        //判断地址是否存在
        _getAddressLabel.hidden = YES;
        _sendAddressLabel.hidden = NO;
        //设置地址
        _getAddressLabel.text = [NSString stringWithFormat:@"取：%@",model.fromAddress];
        _sendAddressLabel.text =[NSString stringWithFormat:@"送：%@",model.toAddress];
        
//        _sendAddressLabel.sd_layout
//        .topSpaceToView(_orderContentLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
    }else if (model.orderTypeId == 2)
    {
        _orderTypeLabel.textColor = DaiGouColor;
        _orderTypeLabel.text = @"购";
        _orderTypeLabel.layer.borderColor = DaiGouColor.CGColor;
        //判断地址是否存在
        _getAddressLabel.hidden = YES;
        _sendAddressLabel.hidden = NO;
        //设置地址
        _getAddressLabel.text = [NSString stringWithFormat:@"取：%@",model.fromAddress];
        _sendAddressLabel.text =[NSString stringWithFormat:@"送：%@",model.toAddress];
        
//        _sendAddressLabel.sd_layout
//        .topSpaceToView(_orderContentLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
    }else
    {
        _orderTypeLabel.textColor = DaiSongColor;
        _orderTypeLabel.text = @"送";
        _orderTypeLabel.layer.borderColor = DaiSongColor.CGColor;
        //判断地址是否存在
        _getAddressLabel.hidden = NO;
        _sendAddressLabel.hidden = NO;
        //设置地址
        _getAddressLabel.text = [NSString stringWithFormat:@"取：%@",model.fromAddress];
        _sendAddressLabel.text =[NSString stringWithFormat:@"送：%@",model.toAddress];
        
        
//        _getAddressLabel.sd_layout
//        .topSpaceToView(_orderContentLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
//        
//        _sendAddressLabel.sd_layout
//        .topSpaceToView(_getAddressLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView,120)
//        .autoHeightRatio(0);
    }
    //设置小费
    _tipsLabel.text = [NSString stringWithFormat:@"小费%0.0f元",model.tip];
    //设置点赞数和评论数
    _commentCountLabel.text = [NSString stringWithFormat:@"%d",model.cCount];
    _praiseCountLabel.text = [NSString stringWithFormat:@"%d",model.zCount];
    //设置用户名和头像
    _nameLabel.text = model.uName;
    [_headImgView setImageURLStr:model.uHeader placeholder:[UIImage imageNamed:@"home_def_head-portrait"]];

    [self setupAutoHeightWithBottomViewsArray:@[_detailView] bottomMargin:0];
}

//语音播放
- (void)voicePlayClick
{
    [self.delegate playOrderVoiceWithModel:_model];
}

//评论
- (void)commentClick
{
    [self.delegate dynamicCommentWithModel:_model];
}

//点赞
- (void)praiseClick
{
    [self.delegate orderPraiseWithModel:_model];
}


- (void)headClick
{
    
}

- (void)btnClick:(UIButton *)btn
{
    [self.delegate showOrderImgWithModel:_model AndIndex:btn.tag];
}
@end
