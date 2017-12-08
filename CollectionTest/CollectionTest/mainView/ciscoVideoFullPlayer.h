//
//  ciscoVideoFullPlayer.h
//  CollectionTest
//
//  Created by zyy on 2017/10/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ciscoVideoFullPlayer : UIView

@property(nonatomic,copy) void(^backFullVideoBlock)();
@property(nonatomic,copy) void(^fullPlayOrPauseBlocl)(BOOL isPlay);

@property(nonatomic,copy) void(^videoFastOrBack)(BOOL isFast);

@property(nonatomic,strong) NSString * url;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullHight;//212

@property (weak, nonatomic) IBOutlet UIView *FullPlayerView;

@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;

@property (weak, nonatomic) IBOutlet UILabel *cruccentLabel;
@property (weak, nonatomic) IBOutlet UILabel *durentLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBut;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 *  当前播放的item
 */
@property (nonatomic, retain) AVPlayerItem   *currentItem;

@end
