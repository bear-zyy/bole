//
//  FMDBHelper.h
//  Career
//
//  Created by lmh on 16/5/18.
//  Copyright © 2016年 souzhiyun_lyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "AudioModel.h"

typedef enum : NSUInteger {
    SONGDOWNLOADING,
    SONGCOMPLETE,
    SONGWAITING
    
} SongDownloadStatus;

@interface FMDBHelper : NSObject
#pragma mark - song
+ (NSMutableArray *)querySongInformation:(AudioModel *)audioModel;

+ (void)insertSongInformation:(AudioModel *)audioModel;
+ (void)deleteSongInformation:(NSString *)url;
+ (BOOL)querySongisDownload:(NSString *)url;

#pragma mark -  progress history

+(NSMutableArray *)querySongHistory:(AudioModel *)audioModel;
+ (void)deleteSongHistory:(NSString *)url;
+ (void)insertHistory:(AudioModel *)audioModel;

+(AudioModel*)querySongWith:(NSString *)url;

@end
