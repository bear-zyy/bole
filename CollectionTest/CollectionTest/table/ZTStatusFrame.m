//
//  ZTStatusFrame.m
//  01-weiBo
//
//  Created by apple on 15-7-18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZTStatusFrame.h"
#import "ZTStatus.h"
#import "Masonry.h"
@implementation ZTStatusFrame
- (void)setStatus:(ZTStatus *)status {
    _status = status;
    ZTUsers *user = status.user;
    CGFloat margin = 5;
    // 头像的Frame
    CGFloat iconViewW = 40;
    CGFloat iconViewH = 40;
    CGFloat iconViewX = margin;
    CGFloat iconViewY = margin;
    
    self.iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 昵称的Frame
    CGFloat nameLblX = CGRectGetMaxX(self.iconViewF) + margin;
    CGFloat nameLblY = iconViewY;
    self.nameLabelF = (CGRect){nameLblX,nameLblY,[user.screen_name sizeWithFont:[UIFont systemFontOfSize:16]]};
    // 发送时间的Frame
    
    CGFloat createLblX = nameLblX;
    CGFloat createLblY = iconViewH - self.nameLabelF.size.height+ margin;
    self.createLabelF = (CGRect){createLblX,createLblY,[status.created_at sizeWithFont:[UIFont systemFontOfSize:13]]};
    // 来源的Frame
 
    CGFloat sourceLblX = CGRectGetMaxX(self.createLabelF) + margin;
    CGFloat sourceLblY = createLblY;
    self.sourceLabelF = (CGRect){sourceLblX,sourceLblY,[status.source sizeWithFont:[UIFont systemFontOfSize:13]]};
    
    // 正文的Frame
    CGFloat textLblX = iconViewX;
    CGFloat textLblY = CGRectGetMaxY(self.iconViewF) + margin;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.textLabelF = (CGRect){textLblX,textLblY,[status.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(screenW - margin, MAXFLOAT)]};
    // 配图的Frame
    NSInteger pictureCount = status.pic_urls.count;
    if (pictureCount > 0) {
        CGFloat pictureWH = 110;
        NSInteger maxCol = 0;
        NSInteger maxRow = 0;
        
        NSLog(@"picCount = %ld",pictureCount);
        if (pictureCount == 4) {
            maxCol = 2;
            maxRow = 2;
        } else {
            maxCol = (pictureCount - 1) % 3 + 1;//列
            maxRow = (pictureCount - 1) / 3 + 1;//行
        }
        
        CGFloat pictureViewW = [UIScreen mainScreen].bounds.size.width;
        CGFloat pictureViewH = maxRow * pictureWH + (maxRow - 1) * margin;
        CGFloat pictureViewX = iconViewX;
        CGFloat pictureViewY = CGRectGetMaxY(self.textLabelF) + margin;
        self.pictureViewF = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
    }
   
    // 转发微博的Frame
    // 底部状态栏的Frame
    CGFloat statusBarX = 0;
    CGFloat statusBarY = 0;
    if (pictureCount > 0) {
        statusBarY = CGRectGetMaxY(self.pictureViewF) + margin;
    }else {
       statusBarY = CGRectGetMaxY(self.textLabelF) + margin;
    }
    
    CGFloat statusBarW = screenW;
    CGFloat statusBarH = 36;
    self.statusBarF = CGRectMake(statusBarX, statusBarY, statusBarW, statusBarH);
    self.cellHeight = CGRectGetMaxY(self.statusBarF) + margin;
    
}
@end
