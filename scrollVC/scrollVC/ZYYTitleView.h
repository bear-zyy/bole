//
//  ZYYTitleView.h
//  scrollVC
//
//  Created by zyy on 2017/12/19.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    
    equalSpace = 1,//间距相同  顺序排下去，
    equalWidth = 2,//长度相同  占满
    
}titleType;

@protocol ZYYTitleDelegate <NSObject>

-(void)zyyTitleViewSelcetTitleIndex:(NSInteger)index;

@end



@interface ZYYTitleView : UIView


@property(nonatomic,assign) titleType lineType;
@property(nonatomic,strong) NSArray * titleArray;
@property(nonatomic,strong) UIColor * backColor;
@property(nonatomic,strong) UIColor * titleSelectColor;
@property(nonatomic,strong) UIColor * downIndexLineSelectColor;
@property(nonatomic,strong) UIColor * titleNormalColor;
@property(nonatomic,strong) UIColor * downIndexLineNormalColor;
@property(nonatomic,assign) CGFloat titleFont;
@property(nonatomic,weak) id <ZYYTitleDelegate> delegate;

@property(nonatomic,assign) NSInteger titleIndex;

@end
