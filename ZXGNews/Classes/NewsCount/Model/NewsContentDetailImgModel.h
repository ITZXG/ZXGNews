//
//  NewsContentDetailImgModel.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsContentDetailImgModel : NSObject
//新闻详情的model
@property (nonatomic, copy) NSString *src;
/** 图片尺寸 */
@property (nonatomic, copy) NSString *pixel;
/** 图片所处的位置 */
@property (nonatomic, copy) NSString *ref;

+(instancetype)initWithDict:(NSDictionary*)dict;
@end
