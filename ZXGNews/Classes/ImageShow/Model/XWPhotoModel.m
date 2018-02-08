//
//  XWPhotoModel.m
//  新闻
//
//  Created by user on 15/10/4.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "XWPhotoModel.h"
#import "XWPhotoDetailModel.h"

@implementation XWPhotoModel

+(NSDictionary *)objectClassInArray
{
    
    return @{@"photos" : [XWPhotoDetailModel class]};
}



@end
