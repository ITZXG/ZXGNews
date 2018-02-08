//
//  NewsContentModel.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsContentModel : NSObject
@property (nonatomic,copy) NSString *body;
//@property (nonatomic,copy) NSString *replyCount;
//@property (nonatomic,copy) NSString *docid;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *ptime;


@property (nonatomic,copy) NSString *spinfo; //扩展阅读部分
@property (nonatomic,strong) NSMutableArray *img; //存放的图片那模型数据  XWDetailImgModel

+(instancetype)initWithDict:(NSDictionary*)dict;
@end
