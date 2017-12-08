//
//  ZTStatusCell.h
//  01-weiBo
//
//  Created by apple on 15-7-18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTStatusFrame.h"
#import "ZTStatusBar.h"
#import "ZTPictureView.h"
@interface ZTStatusCell : UITableViewCell
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  创建时间
 */
@property (nonatomic, weak) UILabel *createLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *contentLabel;
/**
 *  配图
 */
@property (nonatomic, weak) ZTPictureView *pictureView;
/**
 *  底部状态栏
 */
@property (nonatomic, weak) ZTStatusBar *statusBar;
@property (nonatomic, strong) ZTStatusFrame *statusFrame;
+ (instancetype)statusCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
