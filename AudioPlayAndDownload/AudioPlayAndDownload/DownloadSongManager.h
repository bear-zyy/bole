//
//  DownloadSongManager.h
//  Career
//
//  Created by lmh on 2017/6/19.
//  Copyright © 2017年 souzhiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AudioModel.h"


@protocol DownloadSongManagerDelegate <NSObject>
@required
- (void)downloadFinish;


@end

typedef enum : NSUInteger {
    START,
    WAITING,
    PAUSE,
    RESUME,
} AudioDownloadStatus;



@interface DownloadSongManager : NSObject
@property (nonatomic, assign) CGFloat  currentProgress;

@property (nonatomic, strong) UILabel       *label;
@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, weak) id<DownloadSongManagerDelegate>delegate;





+ (instancetype)sharedManager;

- (void)downloadAudioWithAudioModel:(AudioModel *)audioModel success:(void (^)(BOOL isSuccess))block;

- (void)downloadAudioWithAudioModel:(AudioModel *)audioModel success:(void (^)(BOOL isSuccess))block withProgress:(void (^)(CGFloat proStr))progressBlock;


- (void)downloadAudios:(NSArray *)audios success:(void (^)(BOOL isSuccess))block;

- (BOOL)hasStart;

- (CGFloat)fileHasDownloadedProgressWithAudioModel:(AudioModel *)audioModel;

- (BOOL)isDownloadFinishedWithUrl:(NSString *)urlStr;

- (NSString *)fullPath:(NSString *)url;

- (void)removeItemWith:(NSString *)url;


@end
