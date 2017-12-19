//
//  ZYYTitleView.m
//  scrollVC
//
//  Created by zyy on 2017/12/19.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ZYYTitleView.h"

@interface ZYYTitleView ()

@property(nonatomic,strong) UIScrollView * titleScrollView;
@property(nonatomic,strong) UIButton * tempBut;
@property(nonatomic,strong) UIView * tempView;

@end

@implementation ZYYTitleView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleScrollView = [[UIScrollView alloc] init];
        [self addSubview:self.titleScrollView];
        self.titleScrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
}

-(void)setDownIndexLineNormalColor:(UIColor *)downIndexLineNormalColor{
    
    _downIndexLineNormalColor = downIndexLineNormalColor;
    
}
-(void)setDownIndexLineSelectColor:(UIColor *)downIndexLineSelectColor{
    
    _downIndexLineSelectColor = downIndexLineSelectColor;
    
}

-(void)setTitleNormalColor:(UIColor *)titleNormalColor{
    _titleNormalColor = titleNormalColor;
    
}
-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor = titleSelectColor;
    
}

-(void)setTitleFont:(CGFloat)titleFont{
    
    _titleFont = titleFont;
    
}

-(void)setBackColor:(UIColor *)backColor{
    _backColor =backColor;
    self.titleScrollView.backgroundColor = backColor;
    
}

-(void)setLineType:(titleType)lineType{
    
    _lineType = lineType;
    
}

-(void)setTitleArray:(NSArray *)titleArray{
    
    UIView * view = nil;
    if (_lineType == equalSpace) {//等间距
        
        for (int i=0; i< titleArray.count; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:_downIndexLineNormalColor forState:UIControlStateNormal];
            [button setTitleColor:_downIndexLineSelectColor forState:UIControlStateSelected];
            button.tag = 100 + i;
            button.selected = NO;
            
            [button addTarget:self action:@selector(titleIndexClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.titleScrollView addSubview:button];
            
            CGSize size = [titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, _titleFont * 2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:_titleFont]} context:nil].size;
            if (i ==0 ) {
                button.selected = YES;
                self.tempBut =button;
                button.frame = CGRectMake(15, 0, size.width + 5, CGRectGetHeight(self.titleScrollView.bounds));
            }
            else{
                
                button.frame = CGRectMake(CGRectGetMaxX(view.frame) + 15, 0, size.width + 5 , CGRectGetHeight(self.titleScrollView.bounds));
            }
            view = button;
            
            UIView * downView = [[UIView alloc] init];
            downView.backgroundColor = _downIndexLineSelectColor;
            downView.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.bounds) - 2, size.width, 2);
            downView.tag = 200 + i;
            [self.titleScrollView addSubview:downView];
            downView.hidden = YES;
            if (i == 0) {
                downView.hidden = NO;
                self.tempView = downView;
            }
        }
        if (CGRectGetMaxX(view.bounds) > [UIScreen mainScreen].bounds.size.width) {
            self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.bounds) + 15, CGRectGetHeight(self.titleScrollView.bounds));
        }
        
    }
    else{
        
        
    }
    
}

-(void)titleIndexClick:(UIButton *)but{
    
    self.tempView.hidden = YES;
    self.tempBut.selected = NO;
    
    but.selected = YES;
    self.tempBut = but;
    
    UIView * view = (UIView *)[self viewWithTag:but.tag + 100];
    view.hidden = NO;
    self.tempView = view;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyyTitleViewSelcetTitleIndex:)])
    {
        [self.delegate zyyTitleViewSelcetTitleIndex:but.tag - 100];
    }
    
}

-(void)setTitleIndex:(NSInteger)titleIndex{
    
    _titleIndex = titleIndex;
    
    self.tempBut.selected = NO;
    self.tempView.hidden = YES;
    
    UIButton * but = (UIButton*)[self viewWithTag:100 + titleIndex];
    but.selected = YES;
    self.tempBut = but;
    UIView * view = (UIView *)[self viewWithTag:but.tag + 100];
    view.hidden = NO;
    self.tempView = view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
