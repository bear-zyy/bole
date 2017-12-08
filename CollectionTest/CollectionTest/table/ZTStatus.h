//
//  ZTStatus.h
//  01-weiBo
//
//  Created by apple on 15-7-15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTUsers.h"

@interface ZTStatus : NSObject
/**
 *  微博内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博id
 */
@property (nonatomic, assign) NSUInteger id;
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  转发数
 */
@property (nonatomic, assign) NSInteger reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) NSInteger comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign) NSInteger attitudes_count;
/**
 * 配图地址
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  用户信息
 */
@property (nonatomic, strong) ZTUsers *user;
/**
 *  获取微博
 */
+ (void)loadStatusList:(void (^)(NSArray *statuses))finished failure:(void (^)(NSError *error))failure;
@end
