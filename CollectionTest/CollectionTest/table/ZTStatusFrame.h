//
//  ZTStatusFrame.h
//  01-weiBo
//
//  Created by apple on 15-7-18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZTUsers.h"
#import "ZTStatus.h"
@interface ZTStatusFrame : NSObject
/**
 *  头像的Frame
 */
@property (nonatomic, assign) CGRect iconViewF;
/**
 *  昵称的Frame
 */
@property (nonatomic, assign) CGRect nameLabelF;
/**
 *  创建时间的Frame
 */
@property (nonatomic, assign) CGRect createLabelF;
/**
 *  来源的Frame
 */
@property (nonatomic, assign) CGRect sourceLabelF;
/**
 *  正文的Frame
 */
@property (nonatomic, assign) CGRect textLabelF;
/**
 * 配图的Frame
 */
@property (nonatomic, assign) CGRect pictureViewF;
/**
 *  转发微博的Frame
 */
/**
 *  底部状态栏的Frame
 */
@property (nonatomic, assign) CGRect retweeted_statusF;
@property (nonatomic, assign) CGRect statusBarF;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) ZTStatus *status;

@end
