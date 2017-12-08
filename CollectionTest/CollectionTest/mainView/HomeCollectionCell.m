//
//  HomeCollectionCell.m
//  Bole
//
//  Created by zyy on 2017/7/27.
//  Copyright © 2017年 SK. All rights reserved.
//

#import "HomeCollectionCell.h"


@implementation HomeCollectionCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        //用于合并分支的test
        self.imageV = [[UIImageView alloc] init];
        
        self.imageV.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview:self.imageV];
        
    }
    return self;
}

-(void)setImageUrl:(NSString *)imageUrl{

    self.imageV.image = [UIImage imageNamed:imageUrl];
    
}

@end
