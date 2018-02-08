//
//  NewsContentDetailImgModel.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "NewsContentDetailImgModel.h"

@implementation NewsContentDetailImgModel
+(instancetype)initWithDict:(NSDictionary *)dict
{
    NewsContentDetailImgModel *imgModel=[[NewsContentDetailImgModel alloc]init];
    imgModel.pixel=dict[@"pixel"];
    imgModel.src=dict[@"src"];
    imgModel.ref=dict[@"ref"];
    return imgModel;
}

@end
