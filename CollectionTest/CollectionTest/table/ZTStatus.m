//
//  ZTStatus.m
//  01-weiBo
//
//  Created by apple on 15-7-15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZTStatus.h"

@implementation ZTStatus

+ (void)loadStatusList:(void (^)(NSArray *statuses))finished failure:(void (^)(NSError *error))failure{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSDictionary *attr = @{@"access_token":ACCESS_TOKEN,
//                           @"count":@(20)};
//    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:attr success:^(NSURLSessionDataTask *task, NSDictionary *response) {
//        NSArray *tempArr = response[@"statuses"];
//        NSArray *statusArr = [ZTStatus objectArrayWithKeyValuesArray:tempArr];
////        NSLog(@"%@",statusArr);
//        finished(statusArr);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//        NSLog(@"%@",error);
//    }];
}
- (NSString *)description {
//    NSArray *propertis = [self.class loadProperties];
//    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
//    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
    return @"哈哈哈哈哈 ";
}
@end
