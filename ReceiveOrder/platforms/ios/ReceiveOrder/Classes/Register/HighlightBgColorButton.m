//
//  HighlightBgColorButton.m
//  ReceiveOrder
//
//  Created by HuayuNanyan on 16/7/29.
//
//

#import "HighlightBgColorButton.h"
#define HighlightColor [UIColor blueColor]
#define NormalColor [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1]


@implementation HighlightBgColorButton

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = HighlightColor;
    }else{
        self.backgroundColor = NormalColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end














