//
//  ZTStatusBar.m
//  01-weiBo
//
//  Created by apple on 15-7-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZTStatusBar.h"
#import "ZTStatusBarButton.h"
#define BTN_COUNT 3
@interface ZTStatusBar ()
@property (nonatomic, strong) NSArray *titleArr;
@end
@implementation ZTStatusBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSArray *titleArr = @[@"转发",@"评论",@"赞"];
        self.titleArr = titleArr;
        NSArray *imgNameArr = @[@"retweet",@"comment",@"unlike"];
        // 添加三个button
        for (int i = 0; i < BTN_COUNT; ++i) {
            NSString *imgName = [NSString stringWithFormat:@"timeline_icon_%@",imgNameArr[i]];
            ZTStatusBarButton *btn = [ZTStatusBarButton buttonWithType:UIButtonTypeCustom];
//            [btn setTitle:titleArr[i] color:[UIColor grayColor] backNorImg:@"timeline_card_bottom_background" backStateImg:@"timeline_card_bottom_background_highlighted" NorImg:imgName stateImg:nil state:UIControlStateHighlighted];
           
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:btn];
        }
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnW = screenW / BTN_COUNT;
    // 设置分割线
    
    int index = 0;
    for (ZTStatusBarButton *btn in self.subviews) {
        btn.frame = CGRectMake(index * btnW, 0, btnW, 36);
       
        index ++;
    }
}

- (void)setStatus:(ZTStatus *)status {
    _status = status;
    NSInteger reposts = status.reposts_count; // 转发数
//    NSInteger reposts = 13391;
    NSInteger comments = status.comments_count; // 评论数
    NSInteger attitudes = status.attitudes_count; // 点赞数
    if (reposts == 0) {
        [self.subviews[0] setTitle:self.titleArr[0] forState:UIControlStateNormal];
    }else if (reposts < 10000) {
        [self.subviews[0] setTitle:[NSString stringWithFormat:@"%zd",reposts] forState:UIControlStateNormal];
    }else {
         [self.subviews[0] setTitle:[NSString stringWithFormat:@"%.1f万",reposts / 10000.0] forState:UIControlStateNormal];
    }
    
    if (comments == 0) {
        [self.subviews[1] setTitle:self.titleArr[1] forState:UIControlStateNormal];
    }else if (comments < 10000) {
        [self.subviews[1] setTitle:[NSString stringWithFormat:@"%zd",comments] forState:UIControlStateNormal];
    }else {
        [self.subviews[1] setTitle:[NSString stringWithFormat:@"%.1f万",comments / 10000.0] forState:UIControlStateNormal];
    }
    
    if (attitudes == 0) {
        [self.subviews[2] setTitle:self.titleArr[2] forState:UIControlStateNormal];
    }else if (attitudes < 10000) {
        [self.subviews[2] setTitle:[NSString stringWithFormat:@"%zd",attitudes] forState:UIControlStateNormal];
    }else {
        [self.subviews[2] setTitle:[NSString stringWithFormat:@"%.1f万",attitudes / 10000.0] forState:UIControlStateNormal];
    }
}
@end
