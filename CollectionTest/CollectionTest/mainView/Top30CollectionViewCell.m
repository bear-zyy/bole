//
//  Top30CollectionViewCell.m
//  Career
//
//  Created by souzhiyun Mr_Liu on 2017/5/3.
//  Copyright © 2017年 souzhiyun_lyb. All rights reserved.
//

#import "Top30CollectionViewCell.h"


@interface Top30CollectionViewCell ()



@end


@implementation Top30CollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
//        _label=[MyControl createLabelWithFrame:frame Font:11 Text:@""];
        _label = [[UILabel alloc] initWithFrame:frame];
        
        _label.numberOfLines=0;
        //对齐方式
        _label.textAlignment=NSTextAlignmentLeft;
//        _label.backgroundColor=[UIColor clearColor];
        _label.font=[UIFont systemFontOfSize:11];
        //单词折行
        _label.lineBreakMode=NSLineBreakByWordWrapping;
        //默认字体颜色是白色
//        _label.textColor=[UIColor blackColor];
        //自适应（行数~字体大小按照设置大小进行设置）
        _label.adjustsFontSizeToFitWidth=YES;
    
        _label.layer.masksToBounds=YES;
        _label.layer.cornerRadius=5;
        _label.layer.borderColor = [UIColor redColor].CGColor;
        _label.textAlignment=NSTextAlignmentCenter;
        _label.textColor=[UIColor grayColor];
        _label.userInteractionEnabled=YES;
        _label.numberOfLines=1;
        _label.backgroundColor=[UIColor orangeColor];
//        _label.layer.borderColor=[UIColor whiteColor].CGColor;
//        _label.layer.borderWidth=2;
        [self addSubview:_label];
    }
    return self;
}

-(void)setTitle:(NSString *)title{

    _label.text = [NSString stringWithFormat:@"%@",title];
    
}

//
//
//
//-(void)setModel:(HLWJobModel *)model
//{
//    DLog(@"--------model.position:%@",model.position);
//    _label.text=[NSString stringWithFormat:@"%@",model.position];
//    
//}

//-(void)setIsLabelGrayBg:(BOOL)isLabelGrayBg
//{
//    if (_isLabelGrayBg)
//    {
//        _label.backgroundColor=UIColorHex(0xf5f5f5);
//        _label.layer.masksToBounds=YES;
//        _label.layer.cornerRadius=5;
//    }
//    else
//    {
//        _label.layer.masksToBounds=YES;
//        _label.layer.cornerRadius=5;
//        _label.layer.borderWidth=1;
//        _label.layer.borderColor=Gray90Color.CGColor;
//    }
//}

@end
