//
//  ZTUsers.h
//  01-weiBo
//
//  Created by apple on 15-7-15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTUsers : NSObject
/**
 *  友好显示名称
 */
//@property (nonatomic, copy) NSString *name;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;
/**
 *  用户头像地址
 */
@property (nonatomic, copy) NSString *profile_image_url;

@property(nonatomic,strong) NSString  * smallCircle;


@end
