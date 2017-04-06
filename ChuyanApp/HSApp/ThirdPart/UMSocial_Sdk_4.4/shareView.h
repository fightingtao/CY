//
//  shareView.h
//  YMSP
//
//  Created by cbwl on 16/6/12.
//  Copyright © 2016年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shareCustomDelegate <NSObject>      //协议

@required

- (void)shareBtnClickWithIndex:(int)tag;

@end

@interface shareView : UIView
@property (nonatomic,retain)id <shareCustomDelegate> shareDelegate;  
@end
