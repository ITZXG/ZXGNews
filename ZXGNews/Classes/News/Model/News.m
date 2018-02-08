//
//  News.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "News.h"
#import "NetworkTool.h"
#import <objc/runtime.h>

@implementation News
+ (NSArray *)properties {
    unsigned int count;
   objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; ++i) {
        objc_property_t objectName = properties[i];
       const char *cString = property_getName(objectName);
        NSString *string = [[NSString alloc]initWithCString:cString encoding:NSUTF8StringEncoding];
        [array addObject:string];
    }
    free(properties);
    return array;
}

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc]init];
    NSArray *properties = [self properties];
    for (NSString *string in properties) {
        if (dict[string] != nil) {
            [obj setValue:dict[string] forKey:string];
        }
    }
    return obj;
}

+ (void)newsListWithUrlString:(NSString *)urlString finishedBlock:(FinishedBlock)finishedBlock {
    [[NetworkTool shareNetworkTool] objectWIthUrlString:urlString complectionBloack:^(NSDictionary *dict, NSError *error) {
        NSString *key = dict.keyEnumerator.nextObject;
        NSArray *dictArray = dict[key];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:dictArray.count];
        [dictArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            News *news = [News newsWithDict:dict];
            [array addObject:news];
        }];
        if (finishedBlock) {
            finishedBlock(array);
        }
        
    }];
}
- (NSString *)description{
    return [NSString stringWithFormat:@"%@---%@",_title,_digest];
}
-(void)setReplyCount:(NSString *)replyCount
{
    
    //设置回帖数
    NSString *reply=nil;
    if([replyCount intValue]<10000){  //如果小于1万的话
        reply=[NSString stringWithFormat:@"%d跟帖",[replyCount intValue]];
        // NSLog(@"**********%@",replyCount);
    }else{  //如果大于1万的话
        double counts=[replyCount intValue]/10000.0;  //获得回帖数除以10000的商
        reply=[NSString stringWithFormat:@"%.1f万跟帖",counts];
        reply=[reply stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _replyCount=reply;
    
}
@end
