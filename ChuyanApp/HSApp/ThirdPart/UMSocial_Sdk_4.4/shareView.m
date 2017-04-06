//
//  shareView.m
//  YMSP
//
//  Created by cbwl on 16/6/12.
//  Copyright © 2016年 xc. All rights reserved.
//

#import "shareView.h"
#import "publicResource.h"
#import "ShareManage.h"
#define menuBtnWidth    40  //按钮宽度
#define menuBtnHeight   40  //按钮高度
#define btnxDistance    20 //按钮之间x的距离
#define btnyDistance    15 //按钮之间y的距离

@implementation shareView
{
    UILabel *titleLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatMainShareView];
    }
    return self;
}
-(void)creatMainShareView{
//    NSArray *titleArr = [NSArray arrayWithObjects:@"微信好友",@"微信朋友圈",@"QQ",@"QQ空间",@"新浪微博", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"微信好友",@"微信朋友圈", nil];
    NSArray *imgArr   = [NSArray arrayWithObjects:@"wx.png",@"friend.png", nil];
    int cloumsNum = 3;              //按钮列数
    int rowsNum = (int)(titleArr.count + cloumsNum - 1) / cloumsNum;                //按钮行数
    
    float viewWidth = SCREEN_WIDTH - 120;//cloumsNum * menuBtnWidth + (cloumsNum - 1) * btnxDistance;
//    float viewHeight = rowsNum * menuBtnHeight + (rowsNum - 1) * btnyDistance;
    
//    UIView *buttonsView = [[UIView alloc] init];
//    buttonsView.frame = CGRectMake(30,20, viewWidth, viewHeight);
//    buttonsView.backgroundColor = [UIColor redColor];
//    [self  addSubview:buttonsView];
    
    for(int i = 0; i < rowsNum; i++)
    {
        for(int j = 0; j<cloumsNum; j++)
        {
            int num = i * cloumsNum + j;
            if(num >= [titleArr count])
            {
                break ;
            }
            float btnX =30+ j * menuBtnWidth + j * ((viewWidth - menuBtnWidth * cloumsNum) / (cloumsNum - 1));
            float btnY =20+ i * (SCREEN_WIDTH-100) / cloumsNum;
            
            UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            menuBtn.frame = CGRectMake(btnX, btnY, menuBtnWidth, menuBtnHeight);
            menuBtn.tag = 200 + num;
            [menuBtn setImage:[UIImage imageNamed:[imgArr objectAtIndex:num]] forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            buttonsView.backgroundColor = [UIColor clearColor];
            [self addSubview:menuBtn];
            
            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 12)];
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor grayColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = [titleArr objectAtIndex:num];
            [self addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(menuBtn.center.x, menuBtn.center.y + 40);
        }
    }

    
}
-(void)shareBtnClick:(UIButton *)btn{
//    [self.shareDelegate shareBtnClickWithIndex:btn.tag];
    ShareManage *share=[[ShareManage alloc]init];
    if (btn.tag ==200){ //微信
        [share wxShareWithViewControll];
    }
    else if (btn.tag==201){
        [share wxpyqShareWithViewControll];
    }
    
    else if (btn.tag==202){
        [share QQShareWithViewControll];
    }
    
    else if (btn.tag==203){
        [share tensentShareWithViewControll];
    }
    
    else if (btn.tag==204){
        [share wbShareWithViewControll];
    }
}


@end
