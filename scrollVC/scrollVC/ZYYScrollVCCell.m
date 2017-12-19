//
//  ZYYScrollVCCell.m
//  scrollVC
//
//  Created by zyy on 2017/12/19.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ZYYScrollVCCell.h"


@implementation ZYYScrollVCCell

-(void)setSubVC:(ZYYSubVC *)subVC{
    
    _subVC = subVC;
    
    [self addSubview:subVC.view];
    
    subVC.view.frame = self.bounds;
}

@end
