//
//  NetworkTool.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
static NSString * const NewsBoardBaseURLString = @"http://c.m.163.com/nc/";

static NetworkTool *instance;
+ (instancetype)shareNetworkTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self  alloc]initWithBaseURL:[NSURL URLWithString:NewsBoardBaseURLString]];
    });
    return instance;
}
- (void)objectWIthUrlString:(NSString *)urlString complectionBloack:(ComplectionBlock)complectionBloack {
    [self POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complectionBloack(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (complectionBloack) {
            complectionBloack(nil,error);
        }
    }];
}
@end
