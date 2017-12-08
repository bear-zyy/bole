//
//  ZTPictureView.m
//  01-weiBo
//
//  Created by apple on 15-7-21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZTPictureView.h"
//#import "UIImageView+WebCache.h"
#define PAGE_COUNT 9
@implementation ZTPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < PAGE_COUNT; ++i) {
            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.hidden = YES;
            [self addSubview:imageView];
        }
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setStatus:(ZTStatus *)status {
    _status = status;
    [self.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:@(YES)];
    NSInteger pictureCount = status.pic_urls.count;
  
    for (int i = 0; i < pictureCount; ++i) {
        UIImageView *image = self.subviews[i];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",status.pic_urls[i]]];
//        image.backgroundColor = [UIColor blackColor];
//        NSURL *url = [NSURL URLWithString:status.pic_urls[i][@"thumbnail_pic"]];
//        [image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        image.hidden = NO;
   
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger pictureCount = self.status.pic_urls.count;
    if (pictureCount != 0) {
        CGFloat margin = 20;
        CGFloat imageViewH = 110;
        CGFloat imageW = 90;
        CGFloat col = 0;
        CGFloat row = 0;
        for (int i = 0; i < pictureCount; ++i) {
            UIImageView *image = self.subviews[i];
            if (pictureCount == 4) {
                col = i % 2;
                row = i / 2;
            }else {
                col = i % 3;
                row = i / 3;
            }
            CGFloat imageViewX = (imageW + margin) * col;
            CGFloat imageViewY = (imageViewH + margin) * row;
            image.frame = CGRectMake(imageViewX, imageViewY, imageW, imageViewH);
            
        }
    }
  
}
@end
