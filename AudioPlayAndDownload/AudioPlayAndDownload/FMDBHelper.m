//
//  FMDBHelper.m
//  Career
//
//  Created by lmh on 16/5/18.
//  Copyright © 2016年 souzhiyun_lyb. All rights reserved.
//

#import "FMDBHelper.h"
@implementation FMDBHelper

+ (NSString *)getDocumentPath
{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"baseData.sqlite"];
    
    return filePath;
    
}




+ (void)dropTable
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDocumentPath]];
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"drop table if exists song_information"];
        
        BOOL isDelete = [db executeUpdate:sql];
        
        if (isDelete) {
            
            NSLog(@"删除成功");
            
        }
    }
}

#pragma mark - song 
+ (void)insertSongInformation:(AudioModel *)audioModel
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[FMDBHelper getDocumentPath]];
    
    if ([db open]) {
        
        BOOL create =  [db executeUpdate:@"create table if not exists song_information (audioUrl text , filePath text)"];
        
        if (create) {
            
                       
        }
    }
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"insert into 'song_information' ('audioUrl' , 'filePath') values(?,?)"];
        
        BOOL isInsert = [db executeUpdate:sql, audioModel.audioUrl , audioModel.filePath];
        
        if (isInsert) {
            
            NSLog(@"插入成功");
            
        }
        
    }
}
+(NSMutableArray *)querySongInformation:(AudioModel *)audioModel
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDocumentPath]];
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from song_information where audioUrl = '%@'", audioModel.audioUrl];
        
        
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            
            AudioModel *model = [[AudioModel alloc] init];
            model.audioUrl = [rs stringForColumn:@"audioUrl"];
            model.filePath = [rs stringForColumn:@"filePath"];
            [dataArray addObject:model];            
        }
    }
    
    return dataArray;
}

+ (BOOL)querySongisDownload:(NSString *)url
{

    FMDatabase *db = [FMDatabase databaseWithPath:[self getDocumentPath]];
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from song_information where audioUrl = '%@'", url];
        
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            
            AudioModel *model = [[AudioModel alloc] init];

            model.audioUrl = [rs stringForColumn:@"audioUrl"];
            model.filePath = [rs stringForColumn:@"filePath"];
            
            return YES;

        }
    }
    
    return NO;

}

+ (void)deleteSongInformation:(NSString *)url
{
    FMDatabase *db = [FMDatabase databaseWithPath:[FMDBHelper getDocumentPath]];
    
    if ([db open]) {
        
        
        //        @"insert into 'song_information' ('songId', 'mid', 'title','audioUrl','downloadStatus','audioSize','isFree','praiseNum','viewNum','showDay','backImg','summary','content','contentHtml','audioDuration', 'audioImg','createDate','uid','butType','authorText'
        NSString *sql = [NSString stringWithFormat:@"delete from song_information where audioUrl = '%@'", url];
        
        [db executeUpdate:sql];

    }

}
/**判断输入的是拼音还是汉字*/
+ (BOOL)isChinesecharacter:(NSString *)string
{
    if (string.length == 0) {
        
        return NO;
    }
    unichar c = [string characterAtIndex:0];
    if (c >=0x4E00 && c <=0x9FA5) {
        
        
        return YES;
        
    }else{
        
        
        return NO;
        
    }
}

#pragma mark progress history
+ (void)insertHistory:(AudioModel *)audioModel
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[FMDBHelper getDocumentPath]];
    
    
    
    if ([db open]) {
        
        
        BOOL create =  [db executeUpdate:@"create table if not exists song_history (audioUrl text , filePath text)"];
        
        if (create) {
            
            
        }
        
        
    }
    
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"insert into 'song_history' ('audioUrl' , 'filePath') values(? , ?)"];
        
        
        
        if ([FMDBHelper querySongHistory:audioModel].count != 0) {
            
        }
        else
        {
            
            BOOL isInsert = [db executeUpdate:sql, audioModel.audioUrl,audioModel.filePath];
            
            
            if (isInsert) {
                
                NSLog(@"插入成功");
                
            }
        }
       
        
    }
}

+ (void)deleteSongHistory:(NSString *)url
{
    FMDatabase *db = [FMDatabase databaseWithPath:[FMDBHelper getDocumentPath]];
    
    if ([db open]) {
        
        
        //        @"insert into 'song_information' ('songId', 'mid', 'title','audioUrl','downloadStatus','audioSize','isFree','praiseNum','viewNum','showDay','backImg','summary','content','contentHtml','audioDuration', 'audioImg','createDate','uid','butType','authorText'
        NSString *sql = [NSString stringWithFormat:@"delete from song_history where audioUrl = '%@'", url];
        
        
        [db executeUpdate:sql];

        
    }
    
}

+(NSMutableArray *)querySongHistory:(AudioModel *)audioModel
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDocumentPath]];
    
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from song_history where audioUrl = '%@'", audioModel.audioUrl];
        
        
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            
            AudioModel *model = [[AudioModel alloc] init];
            model.audioUrl = [rs stringForColumn:@"audioUrl"];
            model.filePath = [rs stringForColumn:@"filePath"];
            [dataArray addObject:model];
        }
    }
    
    return dataArray;
}

+(AudioModel *)querySongWith:(NSString *)url{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDocumentPath]];
    
    if ([db open]) {
     
        NSString * sql = [NSString stringWithFormat:@"select * from song_information"];
        
        FMResultSet * rs = [db executeQuery:sql];
        
        while ([rs next]) {
            
            AudioModel * model = [[AudioModel alloc] init];
            model.audioUrl = [rs stringForColumn:@"audioUrl"];
            model.filePath = [rs stringForColumn:@"filePath"];
            return model;
        }
    }
    return nil;
}

/**将字符串转成拼音*/
+ (NSString *)transform:(NSString *)chinese
{
    if ([chinese isEqualToString:@""]) {
        
        return @"";
    }
    
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //NSLog(@"%@", pinyin);
    
    NSMutableString * py = [NSMutableString stringWithString:[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    return [py lowercaseString];
}

@end
