//
//  DoPhotoCell.m
//  DoImagePickerController
//
//  Created by Donobono on 2014. 1. 23..
//

#import "DoPhotoCell.h"

@implementation DoPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    _selectPhoto.hidden = YES;
    return self;
}

- (void)setSelectMode:(BOOL)bSelect
{
    if (bSelect)
    {
        _selectPhoto.hidden = NO;
        _ivPhoto.alpha = 0.2;
    }
    else
    {
        _selectPhoto.hidden = YES;
        _ivPhoto.alpha = 1.0;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
