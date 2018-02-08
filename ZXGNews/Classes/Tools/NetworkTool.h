//
//  NetworkTool.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
typedef void (^ComplectionBlock) (id object,NSError *error);
@interface NetworkTool :AFHTTPSessionManager
+ (instancetype)shareNetworkTool;
- (void)objectWIthUrlString:(NSString *)urlString complectionBloack:(ComplectionBlock)complectionBloack;
@end
