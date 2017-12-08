//
//  ZTStatusBarButton.m
//  01-weiBo
//
//  Created by apple on 15-7-22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZTStatusBarButton.h"
@interface ZTStatusBarButton ()
@property (nonatomic, weak) UIImageView *separateLine;
@end
@implementation ZTStatusBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *separLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
        self.separateLine = separLine;
        [self addSubview:separLine];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    self.separateLine.height = self.height - 10;
//    self.separateLine.x = self.width - 1;
//    self.separateLine.centerY = self.centerY;
}
@end
