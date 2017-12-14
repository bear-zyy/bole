//
//  popView.h
//  PopView
//
//  Created by zyy on 2017/12/14.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

@interface popView : MMPopupView

@property(nonatomic,copy) void(^popViewBlock)(NSString * string);

@property(nonatomic,assign) NSInteger popViewType;

@end
