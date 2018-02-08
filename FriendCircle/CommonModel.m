//
//  CommonModel.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/7.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

- (NSArray *)pic_urls {
    if (self.img_data.length > 5) {
        NSData *jsonData = [self.img_data dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        if (array) {
            _pic_urls = array;
        }else {
            _pic_urls = [NSArray array];
        }
    }
    return _pic_urls;
}

-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.avatar  = dict[@"avatar"];
        self.nickname = dict[@"nickname"];
        self.content = dict[@"content"];
        self.img_data = dict[@"img_data"];
        self.like_id = dict[@"like_id"];
        self.like_count = dict[@"like_count"];
        self.unlike_count = dict[@"unlike_count"];
        self.add_time = dict[@"add_time"];
        self.rating = dict[@"rating"];
        
    }
    return self;
}
+(instancetype)commitWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}
@end
