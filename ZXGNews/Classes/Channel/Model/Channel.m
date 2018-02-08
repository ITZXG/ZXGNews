//
//  Channel.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "Channel.h"

@implementation Channel

- (void)setTid:(NSString *)tid {
    _tid = tid;
    if ([_tid isEqualToString:@"T1348647853363"]) {
        _urlString = @"article/headline/T1348647853363/0-20.html";
    }else {
        _urlString = [NSString stringWithFormat:@"article/list/%@/0-20.html",_tid];
    }
}

+(NSArray *)properties {
    return @[@"tname",@"tid"];
}

+ (instancetype)channelWIthDict:(NSDictionary *)dict {
    id obj = [[self alloc]init];
    
    NSArray *properties = [self properties];
    for (NSString *string in properties) {
        if (dict[string] != nil) {
            [obj setValue:dict[string] forKey:string];
        }
    }
    return obj;
}

+(NSArray *)channels {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:NULL];
    NSArray *dictArray = dic[@"tList"];
    
    NSMutableArray *channelArray = [NSMutableArray arrayWithCapacity:dictArray.count];
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Channel *channel = [self channelWIthDict:obj];
        [channelArray addObject:channel];
    }];
    [channelArray sortUsingComparator:^NSComparisonResult(Channel *obj1, Channel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    return channelArray;
}

@end
