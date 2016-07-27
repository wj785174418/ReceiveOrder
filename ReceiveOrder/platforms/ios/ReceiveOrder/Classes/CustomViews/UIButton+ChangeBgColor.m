//
//  UIButton+ChangeBgColor.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/26.
//
//

#import "UIButton+ChangeBgColor.h"
#define SelectedColor [UIColor blueColor]

static UIColor *systemColor;
@implementation UIButton (ChangeBgColor)
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (systemColor == nil) {
        systemColor = self.backgroundColor;
    }
    if (selected) {
        self.backgroundColor = SelectedColor;
    } else {
        self.backgroundColor = systemColor;
    }
}
@end
