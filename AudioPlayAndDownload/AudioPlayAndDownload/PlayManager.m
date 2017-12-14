//
//  PlayManager.m
//  AudioPlayAndDownload
//
//  Created by zyy on 2017/12/14.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "PlayManager.h"
#import "DownloadSongManager.h"


@interface PlayManager ()

@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;

@end

@implementation PlayManager

+(instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    static PlayManager * play = nil;
    dispatch_once(&onceToken, ^{
        play = [[self alloc] init];
    });
    return play;
}

-(void)playWithModel:(AudioModel *)audioModel{
    
    self.currentUrl = audioModel.audioUrl;
    //[self checkDownloaded:self.currentUrl]; [NSURL URLWithString:audioModel.filePath]
    NSURL *musicURL = [self checkDownloaded:self.currentUrl];
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
    
    _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
    
    if (@available(iOS 10.0, *)) {
        [_player playImmediatelyAtRate:1.0];
    } else {
            // Fallback on earlier
        [_player play];
    }
    
}

-(void)pauseMusic{
    
    [_player pause];
    
}

- (NSURL *)checkDownloaded:(NSString *)url
{
    if ([[DownloadSongManager sharedManager] isDownloadFinishedWithUrl:url]) {
        
        return [NSURL fileURLWithPath:[[DownloadSongManager sharedManager] fullPath:url]];
    }
    
    return [NSURL URLWithString:url];
}


@end
