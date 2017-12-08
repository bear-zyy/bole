//
//  UIViewControllerVideo.h
//  CollectionTest
//
//  Created by zyy on 2017/10/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ciscoVideoStatus) {
    SCPlayerStateFailed,        // 播放失败
    SCPlayerStateBuffering,     // 缓冲中
    SCPlayerStatePlaying,       // 播放中
    SCPlayerStateStopped,        //暂停播放
    SCPlayerStateFinished,        //暂停播放
    SCPlayerStatePause,       // 暂停播放
};

@interface UIViewControllerVideo : UIViewController

@property(nonatomic,assign) ciscoVideoStatus status;

@end
