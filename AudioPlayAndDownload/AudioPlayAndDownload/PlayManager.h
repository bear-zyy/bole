//
//  PlayManager.h
//  AudioPlayAndDownload
//
//  Created by zyy on 2017/12/14.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioModel.h"

@interface PlayManager : NSObject

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, copy) NSString  *currentUrl;

/** 初始化 */
+ (instancetype)sharedInstance;

- (void)playWithModel:(AudioModel *)audioModel;

-(void)pauseMusic;

@end
