//
//  popView.m
//  PopView
//
//  Created by zyy on 2017/12/14.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "popView.h"
#import <Masonry.h>

@interface popView ()


@end

@implementation popView


-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    
    return self;
    
}

-(void)setPopViewType:(NSInteger)popViewType{
    
    self.type = popViewType;
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
//    self.type = MMPopupTypeSheet;
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.attachedView.mm_dimBackgroundView.backgroundColor = MMHexColor(0x0000007F);
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
    }];
    
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    
    self.animationDuration = 0.2;
    
}

- (IBAction)cancelClick:(id)sender {
    
    if (self.popViewBlock) {
        self.popViewBlock(@"popview");
    }
    
    [MMPopupView hideAll];
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
