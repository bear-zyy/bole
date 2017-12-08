//
//  UIViewControllerVideo.m
//  CollectionTest
//
//  Created by zyy on 2017/10/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "UIViewControllerVideo.h"
#import "CISCOVideoCell.h"
#import "playerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "ciscoVideoFullPlayer.h"

static void *ciscoVideoPlay = &ciscoVideoPlay;

@interface UIViewControllerVideo ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    
    CGFloat totalTime;
    
}
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong)ciscoVideoFullPlayer * ciscoFullPlayer;

@property(nonatomic,strong)CISCOVideoCell * tempCell;

@property(nonatomic,strong) NSIndexPath * indexp;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController  *playerView;

@property (nonatomic, retain) AVPlayerItem   *currentItem;

@property (nonatomic,retain ) AVPlayerLayer  *playerLayer;

@property (nonatomic ,strong) id playbackTimeObserver;

@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL isDragingSlider;//是否点击了按钮的响应事件

@property(nonatomic,strong) UITapGestureRecognizer * tapFull;

@property(nonatomic,assign) BOOL isFull;

@end

@implementation UIViewControllerVideo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 660) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    self.ciscoFullPlayer = [[NSBundle mainBundle] loadNibNamed:@"ciscoVideoFullPlayer" owner:self options:nil].firstObject;
    self.ciscoFullPlayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.ciscoFullPlayer];
    self.ciscoFullPlayer.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    
    self.ciscoFullPlayer.backFullVideoBlock = ^{
        
        weakSelf.ciscoFullPlayer.hidden = YES;
        
        weakSelf.playerLayer.frame = weakSelf.tempCell.backGroundView.layer.bounds;
        //WMPlayer视频的默认填充模式，AVLayerVideoGravityResizeAspect
        weakSelf.playerLayer.videoGravity = AVLayerVideoGravityResize;
        [weakSelf.tempCell.backGroundView.layer insertSublayer:weakSelf.playerLayer atIndex:0];
        weakSelf.tempCell.backImageView.hidden = YES;
        weakSelf.tempCell.operationDownView.hidden = NO;
        
        if (self.status == SCPlayerStatePlaying) {
            weakSelf.tempCell.playOrPuseuBut.selected = YES;
        }
        else{
            weakSelf.tempCell.playOrPuseuBut.selected = NO;
        }
        
        weakSelf.isFull = NO;
        
        [UIApplication sharedApplication].statusBarOrientation = UIDeviceOrientationPortrait;
        
    };
    self.ciscoFullPlayer.fullPlayOrPauseBlocl = ^(BOOL isPlay) {
        if (isPlay) {
            [weakSelf.player play];
            weakSelf.status = SCPlayerStatePlaying;
        }
        else{
            [weakSelf.player pause];
            weakSelf.status = SCPlayerStatePause;
        }
    };
    
    self.ciscoFullPlayer.videoFastOrBack = ^(BOOL isFast) {
      
        if (isFast) {
            [weakSelf.player seekToTime:CMTimeMakeWithSeconds(weakSelf.ciscoFullPlayer.sliderProgress.value + 15.0, weakSelf.currentItem.currentTime.timescale)];
            if (self.player.rate != 1.f) {
                if ([self currentTime] == [self duration])
                    [weakSelf setCurrentTime:0.f];
                weakSelf.ciscoFullPlayer.playOrPauseBut.selected = YES;
                [weakSelf.player play];
            }

        }
        else{
        [weakSelf.player seekToTime:CMTimeMakeWithSeconds(weakSelf.ciscoFullPlayer.sliderProgress.value - 15.0, weakSelf.currentItem.currentTime.timescale)];
            if (self.player.rate != 1.f) {
                if ([self currentTime] == [self duration])
                    [weakSelf setCurrentTime:0.f];
                weakSelf.ciscoFullPlayer.playOrPauseBut.selected = YES;
                [weakSelf.player play];
            }

        }
    };
    
    
    self.currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
    self.player = [AVPlayer playerWithPlayerItem:_currentItem];
    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
    //AVPlayerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.status = SCPlayerStateBuffering;
    [self createNoti];
//    self.playerLayer.frame = self.FullPlayerView.layer.bounds;
//    //WMPlayer视频的默认填充模式，AVLayerVideoGravityResizeAspect
//    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
//    [self.FullPlayerView.layer insertSublayer:_playerLayer atIndex:0];
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - ------ Table view data source ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CISCOVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CISCOVideoCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CISCOVideoCell" owner:self options:nil].firstObject;
    }
    cell.dict = @{};
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.ciscoVideoBlock = ^(AVPlayerItem *currentItem) {
        
        [self clickPlayer:indexPath];
        
    };
    
    cell.fullBlock = ^{
        [self clickFull];
    };
    
    cell.playOrPause = ^(BOOL isPlay) {
        [self playOrPause:isPlay];
    };
    
    cell.tag = indexPath.row + 50;
    return cell;

}

#pragma mark 暂停和播放
-(void)playOrPause:(BOOL)isPlay{

    if (isPlay) {
        [self.player play];
        self.status = SCPlayerStatePlaying;
    }
    else{
        [self.player pause];
        self.status = SCPlayerStatePause;
    }
}

#pragma mark 点击播放
-(void)clickPlayer:(NSIndexPath * )index{

//    [self.tableView reloadData];
    self.tempCell.backImageView.hidden = NO;
    [self.tempCell.loadingView stopAnimating];
    
    self.indexp = index;
    self.tempCell = (CISCOVideoCell *)[self.view viewWithTag:index.row + 50];
    
   self.currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
//    self.player = [AVPlayer playerWithPlayerItem:_currentItem];
    [self.player replaceCurrentItemWithPlayerItem:_currentItem];
    self.playerLayer.frame = self.tempCell.backGroundView.layer.bounds;
    //WMPlayer视频的默认填充模式，AVLayerVideoGravityResizeAspect
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.tempCell.backGroundView.layer insertSublayer:_playerLayer atIndex:0];
    self.tempCell.backImageView.hidden = YES;
    self.tempCell.operationDownView.hidden = NO;
    self.tempCell.playOrPuseuBut.selected = YES;
    
    [self.tempCell.loadingView startAnimating];
    
    [self.tempCell.sliderView addTarget:self action:@selector(stratDragSlide:)  forControlEvents:UIControlEventValueChanged];
    //进度条的点击事件
    [self.tempCell.sliderView addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventTouchUpInside];
    
    //给进度条添加单击手势
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    self.tap.delegate = self;
    [self.tempCell.sliderView addGestureRecognizer:self.tap];
    
    [self.player play];
    self.status = SCPlayerStatePlaying;
}

-(void)setCurrentItem:(AVPlayerItem *)currentItem{
    
    if (_currentItem==currentItem) {
        return;
    }
    if (_currentItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
        [_currentItem removeObserver:self forKeyPath:@"status"];
        [_currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        _currentItem = nil;
    }
    _currentItem = currentItem;
    if (_currentItem) {
        [_currentItem addObserver:self
                       forKeyPath:@"status"
                          options:NSKeyValueObservingOptionNew
                          context:ciscoVideoPlay];
        
        [_currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:ciscoVideoPlay];
        // 缓冲区空了，需要等待数据
        [_currentItem addObserver:self forKeyPath:@"playbackBufferEmpty" options: NSKeyValueObservingOptionNew context:ciscoVideoPlay];
        // 缓冲区有足够数据可以播放了
        [_currentItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options: NSKeyValueObservingOptionNew context:ciscoVideoPlay];
        
        
        [self.player replaceCurrentItemWithPlayerItem:_currentItem];
        // 添加视频播放结束通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGRect cect = [self.tableView rectForRowAtIndexPath:self.indexp];
    
    CGRect rectInSuperview = [self.tableView convertRect:cect toView:[self.tableView superview]];
    
    NSLog(@"cect.origin.y   %f",cect.origin.y);
    
    NSLog(@"rectInSuperview == %f",rectInSuperview.origin.y);
    
//    NSLog(@"scrollView.contentOffset.y %f",scrollView.contentOffset.y);
    
    if (rectInSuperview.origin.y< -200 || rectInSuperview.origin.y > 660) {
        
//        [self.tableView reloadData];
        [self.player pause];
        self.status = SCPlayerStateStopped;
        self.tempCell.backImageView.hidden = NO;
    }
    
}

-(void)moviePlayDidEnd:(NSNotification *)noti{
    
    NSLog(@"播放完成");
    self.status = SCPlayerStateFinished;
    
    self.ciscoFullPlayer.playOrPauseBut.selected = NO;
    self.tempCell.playOrPuseuBut.selected = NO;
    
}

-(void)clickFull{
    
    self.ciscoFullPlayer.hidden = NO;
    
    self.playerLayer.frame = self.ciscoFullPlayer.FullPlayerView.layer.bounds;
    //WMPlayer视频的默认填充模式，AVLayerVideoGravityResizeAspect
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.ciscoFullPlayer.FullPlayerView.layer insertSublayer:_playerLayer atIndex:0];
    
    [self.ciscoFullPlayer.sliderProgress addTarget:self action:@selector(stratDragSlide:)  forControlEvents:UIControlEventValueChanged];
    //进度条的点击事件
    [self.ciscoFullPlayer.sliderProgress addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventTouchUpInside];
    
    //给进度条添加单击手势
    self.tapFull = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionFullTapGesture:)];
    self.tapFull.delegate = self;
    [self.ciscoFullPlayer.sliderProgress addGestureRecognizer:self.tapFull];
    
    if (self.status == SCPlayerStatePlaying) {
        self.ciscoFullPlayer.playOrPauseBut.selected = YES;
    }
    else{
        self.ciscoFullPlayer.playOrPauseBut.selected = NO;
    }
    
    self.isFull = YES;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.estimatedRowHeight = 340;
        
        return self.tableView.rowHeight;
    
//    return 100;
}

-(void)createNoti{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}

-(void)statusBarOrientationChange:(NSNotification *)noti{
    
//    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"UIInterfaceOrientationLandscapeLeft");
        self.ciscoFullPlayer.top.constant = 0;
        self.ciscoFullPlayer.fullHight.constant = [UIScreen mainScreen].bounds.size.height;
        self.ciscoFullPlayer.FullPlayerView.bounds = [UIScreen mainScreen].bounds;
        self.playerLayer.frame = self.ciscoFullPlayer.FullPlayerView.layer.bounds;
    }
    else if (orientation == UIInterfaceOrientationPortrait){
        self.ciscoFullPlayer.top.constant = 205;
        self.ciscoFullPlayer.fullHight.constant = 212;
        NSLog(@"UIInterfaceOrientationPortrait");
        self.playerLayer.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,212);
        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.ciscoFullPlayer.FullPlayerView.layer insertSublayer:_playerLayer atIndex:0];
    }
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    /* AVPlayerItem "status" property value observer. */
    
    if (context == ciscoVideoPlay)
    {
        if ([keyPath isEqualToString:@"status"]) {
            AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
            switch (status)
            {
                    /* Indicates that the status of the player is not yet known because
                     it has not tried to load new media resources for playback */
                case AVPlayerStatusUnknown:
                {
//                    [self.loadingProgress setProgress:0.0 animated:NO];
                    NSLog(@"%s WMPlayerStateBuffering",__FUNCTION__);
                    
//                    self.state = WMPlayerStateBuffering;
                    [self.tempCell.loadingView startAnimating];
                }
                    break;
                    
                case AVPlayerStatusReadyToPlay:
                {
//                    self.state = WMPlayerStatePlaying;
                    
                    /* Once the AVPlayerItem becomes ready to play, i.e.
                     [playerItem status] == AVPlayerItemStatusReadyToPlay,
                     its duration can be fetched from the item. */
                    if (CMTimeGetSeconds(_currentItem.duration)) {
                        
                        totalTime = CMTimeGetSeconds(_currentItem.duration);
                        if (!isnan(totalTime)) {
                            self.tempCell.sliderView.maximumValue = totalTime;
                            self.ciscoFullPlayer.sliderProgress.maximumValue = totalTime;
                            NSLog(@"totalTime = %f",totalTime);
                            
                        }
                    }
                    //监听播放状态
                    [self initTimer];
                    
                    
                    //5s dismiss bottomView
//                    if (self.autoDismissTimer==nil) {
//                        self.autoDismissTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoDismissBottomView:) userInfo:nil repeats:YES];
//                        [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
//                    }
//                    
//                    if (self.delegate&&[self.delegate respondsToSelector:@selector(wmplayerReadyToPlay:WMPlayerStatus:)]) {
//                        [self.delegate wmplayerReadyToPlay:self WMPlayerStatus:WMPlayerStatePlaying];
//                    }
//                    //here
//                    
                    [self.tempCell.loadingView stopAnimating];
//                    // 跳到xx秒播放视频
//                    if (self.seekTime) {
//                        [self seekToTimeToPlay:self.seekTime];
//                    }
                    
                }
                    break;
                    
                case AVPlayerStatusFailed:
                {
//                    self.state = WMPlayerStateFailed;
//                    NSLog(@"%s WMPlayerStateFailed",__FUNCTION__);
//                    
//                    if (self.delegate&&[self.delegate respondsToSelector:@selector(wmplayerFailedPlay:WMPlayerStatus:)]) {
//                        [self.delegate wmplayerFailedPlay:self WMPlayerStatus:WMPlayerStateFailed];
//                    }
                    NSError *error = [self.player.currentItem error];
                    if (error) {
                        self.tempCell.failLabel.hidden = NO;
//                        [self bringSubviewToFront:self.loadFailedLabel];
//                        //here
                        [self.tempCell.loadingView stopAnimating];
                    }
                    NSLog(@"视频加载失败===%@",error.description);
                }
                    break;
            }
            
        }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            
            // 计算缓冲进度
            NSTimeInterval timeInterval = [self availableDuration];
            CMTime duration             = self.currentItem.duration;
            CGFloat totalDuration       = CMTimeGetSeconds(duration);
            //缓冲颜色
            self.tempCell.progressView.progressTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
            [self.tempCell.progressView setProgress:timeInterval / totalDuration animated:NO];
            
            
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
//            [self.loadingView startAnimating];
            // 当缓冲是空的时候
            if (self.currentItem.playbackBufferEmpty) {
//                self.state = WMPlayerStateBuffering;
                NSLog(@"%s WMPlayerStateBuffering",__FUNCTION__);
                
//                [self loadedTimeRanges];
            }
            
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            //here
//            [self.loadingView stopAnimating];
            // 当缓冲好的时候
//            if (self.currentItem.playbackLikelyToKeepUp && self.state == WMPlayerStateBuffering){
//                NSLog(@"55555%s WMPlayerStatePlaying",__FUNCTION__);
            
//                self.state = WMPlayerStatePlaying;
//            }
            
        }
    }
    
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [_currentItem loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma  mark - 定时器
-(void)initTimer{
    double interval = .1f;
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        return;
    }
    long long nowTime = _currentItem.currentTime.value/_currentItem.currentTime.timescale;
    CGFloat width = CGRectGetWidth([self.tempCell.sliderView bounds]);
    interval = 0.5f * nowTime / width;
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver =  [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC)  queue:dispatch_get_main_queue() /* If you pass NULL, the main queue is used. */
                                                                          usingBlock:^(CMTime time){
                                                                              [weakSelf syncScrubber];
                                                                          }];
    
}

- (void)syncScrubber{
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)){
        self.tempCell.sliderView.minimumValue = 0.0;
        return;
    }
    float minValue = [self.tempCell.sliderView minimumValue];
    float maxValue = [self.tempCell.sliderView maximumValue];
    long long nowTime = _currentItem.currentTime.value/_currentItem.currentTime.timescale;
    self.tempCell.currentLabel.text = [self convertTime:nowTime];
    self.ciscoFullPlayer.cruccentLabel.text = [self convertTime:nowTime];
    self.tempCell.durationLabel.text = [self convertTime:totalTime];
    self.ciscoFullPlayer.durentLabel.text = [self convertTime:totalTime];
//    if (self.isDragingSlider==YES) {//拖拽slider中，不更新slider的值
//        
//    }else if(self.isDragingSlider==NO){
        [self.tempCell.sliderView setValue:(maxValue - minValue) * nowTime / totalTime + minValue];
    [self.ciscoFullPlayer.sliderProgress setValue:(maxValue - minValue) * nowTime / totalTime + minValue];
//    }
}

- (CMTime)playerItemDuration{
    AVPlayerItem *playerItem = _currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return([playerItem duration]);
    }
    return(kCMTimeInvalid);
}

- (NSString *)convertTime:(float)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    return [[self dateFormatter] stringFromDate:d];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    }
    return _dateFormatter;
}

- (void)stratDragSlide:(UISlider *)slider{
    self.isDragingSlider = YES;
}
#pragma mark
#pragma mark - 播放进度
- (void)updateProgress:(UISlider *)slider{
    self.isDragingSlider = NO;
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, _currentItem.currentTime.timescale)];
    
    if (self.player.rate != 1.f) {
        if ([self currentTime] == [self duration])
            [self setCurrentTime:0.f];
        self.tempCell.playOrPuseuBut.selected = YES;
        [self.player play];
    }
}

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchLocation = [sender locationInView:self.tempCell.sliderView];
    CGFloat value = (self.tempCell.sliderView.maximumValue - self.tempCell.sliderView.minimumValue) * (touchLocation.x/self.tempCell.sliderView.frame.size.width);
    [self.tempCell.sliderView setValue:value animated:YES];
    
    [self.player seekToTime:CMTimeMakeWithSeconds(self.tempCell.sliderView.value, self.currentItem.currentTime.timescale)];
    if (self.player.rate != 1.f) {
        if ([self currentTime] == [self duration])
            [self setCurrentTime:0.f];
        self.tempCell.playOrPuseuBut.selected = YES;
        [self.player play];
    }
}

-(void)actionFullTapGesture:(UITapGestureRecognizer *)sender{

    CGPoint touchLocation = [sender locationInView:self.ciscoFullPlayer.sliderProgress];
    CGFloat value = (self.ciscoFullPlayer.sliderProgress.maximumValue - self.ciscoFullPlayer.sliderProgress.minimumValue) * (touchLocation.x/self.ciscoFullPlayer.sliderProgress.frame.size.width);
    [self.ciscoFullPlayer.sliderProgress setValue:value animated:YES];
    
    [self.player seekToTime:CMTimeMakeWithSeconds(self.ciscoFullPlayer.sliderProgress.value, self.currentItem.currentTime.timescale)];
    if (self.player.rate != 1.f) {
        if ([self currentTime] == [self duration])
            [self setCurrentTime:0.f];
            self.ciscoFullPlayer.playOrPauseBut.selected = YES;
            [self.player play];
    }
    
}

///获取视频长度
- (double)duration{
    AVPlayerItem *playerItem = self.player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else{
        return 0.f;
    }
}

- (void)setCurrentTime:(double)time{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.player seekToTime:CMTimeMakeWithSeconds(time, self.currentItem.currentTime.timescale)];
        
    });
}


///获取视频当前播放的时间
- (double)currentTime{
    if (self.player) {
        return CMTimeGetSeconds([self.player currentTime]);
    }else{
        return 0.0;
    }
}

-(BOOL)shouldAutorotate{//是否支持旋转屏幕
 
    if (self.isFull) {
        return YES;
    }
    else{
        return NO;
    }
    
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{//支持哪些方向
  
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
//
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{//默认显示的方向
 
    return UIInterfaceOrientationPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
