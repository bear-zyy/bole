//
//  DownloadSongManager.m
//  Career
//
//  Created by lmh on 2017/6/19.
//  Copyright © 2017年 souzhiyun. All rights reserved.
//

#import "DownloadSongManager.h"
#import "SRDownloadManager.h"
#import "FMDBHelper.h"

@implementation DownloadSongManager

+ (instancetype)sharedManager {
    
    static DownloadSongManager *downloadManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[self alloc] init];
        
    });
    return downloadManager;
}


- (instancetype)init {
    
    if (self = [super init]) {
        
        [SRDownloadManager sharedManager].saveFilesDirectory = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CustomDownloadDirectory"];
        [SRDownloadManager sharedManager].maxConcurrentCount = 1;
        
        [SRDownloadManager sharedManager].waitingQueueMode = SRWaitingQueueModeFILO;
    }
    
    return self;
    
}

- (void)downloadAudioWithAudioModel:(AudioModel *)audioModel success:(void (^)(BOOL isSuccess))block
{

    __weak typeof(self) weakSelf = self ;
    
    if (!audioModel.downloadingStatus) {
        
        [[SRDownloadManager sharedManager] downloadURL:[NSURL URLWithString:audioModel.audioUrl] destPath:nil state:^(SRDownloadState state) {
            

            if ([FMDBHelper querySongInformation:audioModel].count > 0) {
                
//                [iToast alertWithTitleCenter:@"已存在"];
                
                
            }
            else
            {
                audioModel.downloadingStatus = [weakSelf titleWithDownloadState:state];
                
                [FMDBHelper insertSongInformation:audioModel];

            }
            
            if (state == SRDownloadStateRunning) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(downloadFinish)]) {
                    
                    [_delegate downloadFinish];
                    
                }
                
            }

        } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
            
            NSLog(@"%.f", progress * 100);
            
            weakSelf.label.text = [NSString stringWithFormat:@"已下载%.f%%", progress * 100];
            
            
            
        } completion:^(BOOL success, NSString *filePath, NSError *error) {
            if (success) {
                
                !block ?: block(success);
                
                if (_delegate && [_delegate respondsToSelector:@selector(downloadFinish)]) {
                    
                    [_delegate downloadFinish];
                    
                }
              

                
            } else {
                NSLog(@"Error: %@", error);
            }
        }];

    }
    else if([audioModel.downloadingStatus isEqualToString:@"Waiting"])
    {
        [[SRDownloadManager sharedManager] cancelDownloadOfURL:[NSURL URLWithString:audioModel.audioUrl]];

    }
    else if([audioModel.downloadingStatus isEqualToString:@"Pause"])
    {
         [[SRDownloadManager sharedManager] suspendDownloadOfURL:[NSURL URLWithString:audioModel.audioUrl]];
    }
    else if([audioModel.downloadingStatus isEqualToString:@"Resume"] || [audioModel.downloadingStatus isEqualToString:@"Faild"])
    {
         [[SRDownloadManager sharedManager] resumeDownloadOfURL:[NSURL URLWithString:audioModel.audioUrl]];
    }
    else if([audioModel.downloadingStatus isEqualToString:@"Finish"])
    {
        
        NSLog(@"File has been downloaded! It's path is: %@", [[SRDownloadManager sharedManager] fileFullPathOfURL:[NSURL URLWithString:audioModel.audioUrl]]);
    }
}

-(void)downloadAudioWithAudioModel:(AudioModel *)audioModel success:(void (^)(BOOL))block withProgress:(void (^)(CGFloat))progressBlock{
    
    __weak typeof(self) weakSelf = self;
    
    if (!audioModel.downloadingStatus) {
        
        [[SRDownloadManager sharedManager] downloadURL:[NSURL URLWithString:audioModel.audioUrl] destPath:nil state:^(SRDownloadState state) {
//            if ([FMDBHelper querySongInformation:audioModel].count > 0) {
//            }
//            else
//            {
//                audioModel.downloadingStatus = [weakSelf titleWithDownloadState:state];
//                [FMDBHelper insertSongInformation:audioModel];
//            }
            if (state == SRDownloadStateRunning) {
                if (_delegate && [_delegate respondsToSelector:@selector(downloadFinish)]) {
                    [_delegate downloadFinish];
                }
            }
        } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
            
            NSLog(@"%.f", progress * 100);
            
            weakSelf.label.text = [NSString stringWithFormat:@"已下载%.f%%", progress * 100];
            
            progressBlock(progress * 100);
        } completion:^(BOOL success, NSString *filePath, NSError *error) {
            if (success) {
                
                AudioModel * model = [[AudioModel alloc] init];
                model = audioModel;
                model.filePath = filePath;
                if (![FMDBHelper querySongisDownload:audioModel.audioUrl]) {
                    [FMDBHelper insertSongInformation:model];
                }
                
                !block ?: block(success);
                
                if (_delegate && [_delegate respondsToSelector:@selector(downloadFinish)]) {
                    
                    [_delegate downloadFinish];
                }
            } else {
                NSLog(@"Error: %@", error);
            }
        }];
    }
    else if([audioModel.downloadingStatus isEqualToString:@"Waiting"])
    {
        [[SRDownloadManager sharedManager] cancelDownloadOfURL:[NSURL URLWithString:audioModel.audioUrl]];
        
    }
    else if([audioModel.downloadingStatus isEqualToString:@"Pause"])
    {
        [[SRDownloadManager sharedManager] suspendDownloadOfURL:[NSURL URLWithString:audioModel.audioUrl]];
    }
    else if([audioModel.downloadingStatus isEqualToString:@"Resume"] || [audioModel.downloadingStatus isEqualToString:@"Faild"])
    {
        [[SRDownloadManager sharedManager] resumeDownloadOfURL:[NSURL URLWithString:audioModel.audioUrl]];
    }
    else if([audioModel.downloadingStatus isEqualToString:@"Finish"])
    {
        
        NSLog(@"File has been downloaded! It's path is: %@", [[SRDownloadManager sharedManager] fileFullPathOfURL:[NSURL URLWithString:audioModel.audioUrl]]);
    }
}


- (NSString *)titleWithDownloadState:(SRDownloadState)state {
    
    switch (state) {
        case SRDownloadStateWaiting:
            return @"Waiting";
        case SRDownloadStateRunning:
            return @"Running";
        case SRDownloadStateSuspended:
            return @"Pause";
        case SRDownloadStateCanceled:
            return @"Start";
        case SRDownloadStateCompleted:
            return @"Finish";
        case SRDownloadStateFailed:
            return @"Faild";
    }
}
-(void)downloadAudios:(NSArray *)audios success:(void (^)(BOOL))block
{
    for (int i = 0; i < audios.count; i ++) {
        
        AudioModel *model = audios[i];
        
        [self downloadAudioWithAudioModel:model success:block];
        
    }
}

- (BOOL)isDownloadFinishedWithUrl:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",[[SRDownloadManager sharedManager] fileFullPathOfURL:[NSURL URLWithString:urlStr]]);
    
    return [[SRDownloadManager sharedManager] isDownloadCompletedOfURL:url];
    
    
}

- (NSString *)fullPath:(NSString *)url
{
    return [[SRDownloadManager sharedManager] fileFullPathOfURL:[NSURL URLWithString:url]];
    
}

- (void)removeItemWith:(NSString *)url
{
    [[SRDownloadManager sharedManager] deleteFileOfURL:[NSURL URLWithString:url]];
    
    [FMDBHelper deleteSongInformation:url];

}

@end
