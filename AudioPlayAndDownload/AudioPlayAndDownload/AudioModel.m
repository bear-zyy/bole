//
//  AudioModel.m
//  Career
//
//  Created by lmh on 2017/6/19.
//  Copyright © 2017年 souzhiyun. All rights reserved.
//

#import "AudioModel.h"

@implementation AudioModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"ID" : @"id"};
}

-(NSString *)sharedURL
{
    return [NSString stringWithFormat:@"%@",@"分享的url"];
}


@end
