//
//  ZTStatusCell.m
//  01-weiBo
//
//  Created by apple on 15-7-18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZTStatusCell.h"
#define REUSEID @"status"
//#import "UIImageView+WebCache.h"
#import "ZTPictureView.h"
@implementation ZTStatusCell
+ (instancetype)statusCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    ZTStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        self.iconView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:iconView];
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        
        [self.contentView addSubview:nameLabel];
        // 发送时间
        UILabel *createLabel = [[UILabel alloc] init];
        self.createLabel = createLabel;
        [self.contentView addSubview:createLabel];
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        self.sourceLabel = sourceLabel;
        [self.contentView addSubview:sourceLabel];
        // 正文
        UILabel *textLabel = [[UILabel alloc] init];
        self.contentLabel = textLabel;
        [self.contentView addSubview:textLabel];
        // 配图
        ZTPictureView *pictureView = [[ZTPictureView alloc] init];
        self.pictureView = pictureView;
        [self.contentView addSubview:pictureView];
        // 底部状态栏
        ZTStatusBar *statusBar = [[ZTStatusBar alloc] init];
        self.statusBar = statusBar;
        [self.contentView addSubview:statusBar];

    }
    return self;
}
- (void)setStatusFrame:(ZTStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    // 头像
    self.iconView.frame = statusFrame.iconViewF;
//    NSURL *url = [NSURL URLWithString:statusFrame.status.user.profile_image_url];
//    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 昵称
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = statusFrame.status.user.screen_name;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textColor = [UIColor blackColor];
    // 创建时间
    self.createLabel.frame = statusFrame.createLabelF;
    self.createLabel.text = statusFrame.status.created_at;
    self.createLabel.font = [UIFont systemFontOfSize:13];
    self.createLabel.textColor = [UIColor blackColor];
    // 来源
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = statusFrame.status.source;
    self.sourceLabel.font = [UIFont systemFontOfSize:13];
    self.sourceLabel.textColor = [UIColor blackColor];
    // 正文
    self.contentLabel.frame = statusFrame.textLabelF;
    self.contentLabel.text = statusFrame.status.text;
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.numberOfLines = 0;
    // 配图
    NSInteger pictureCount = statusFrame.status.pic_urls.count;

    if (pictureCount > 0) {
        self.pictureView.hidden = NO;
        self.pictureView.frame = statusFrame.pictureViewF;
        self.pictureView.status = statusFrame.status;
    }else {
        self.pictureView.hidden = YES;
    }
   
    // 状态栏
    self.statusBar.frame = statusFrame.statusBarF;
    self.statusBar.status = statusFrame.status;
    
}
@end
