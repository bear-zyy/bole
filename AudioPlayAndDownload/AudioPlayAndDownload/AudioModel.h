//
//  AudioModel.h
//  Career
//
//  Created by lmh on 2017/6/19.
//  Copyright © 2017年 souzhiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioModel : NSObject

@property (nonatomic, copy) NSString            *filePath;
@property (nonatomic, copy) NSString            *audioUrl;
@property(nonatomic,strong) NSString            *downloadingStatus;


@end
