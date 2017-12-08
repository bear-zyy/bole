//
//  CISCOVideoCell.h
//  Bole
//
//  Created by zyy on 2017/10/16.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CISCOVideoCell : UITableViewCell

@property(nonatomic,copy) void(^ciscoVideoBlock)(AVPlayerItem *currentItem);

@property(nonatomic,copy) void(^fullBlock)();

@property(nonatomic,copy) void(^playOrPause)(BOOL isPlay);

@property (weak, nonatomic) IBOutlet UIView *backGroundView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lookLabel;

@property (weak, nonatomic) IBOutlet UIView *operationDownView;

@property (weak, nonatomic) IBOutlet UIButton *playOrPuseuBut;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UISlider *sliderView;

@property (nonatomic,strong) UIActivityIndicatorView *loadingView;

@property (weak, nonatomic) IBOutlet UILabel *failLabel;

@property(nonatomic,strong) NSDictionary * dict;


@end
