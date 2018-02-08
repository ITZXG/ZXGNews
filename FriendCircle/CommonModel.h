//
//  CommonModel.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/7.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject
@property(nonatomic, copy) NSString     *comments_id;
@property(nonatomic, copy) NSString     *supper_parent_id;
@property(nonatomic, copy) NSString     *parent_id;
@property(nonatomic, copy) NSString     *uid;
@property(nonatomic, copy) NSString     *ttype;
@property(nonatomic, copy) NSString     *avatar;
@property(nonatomic, copy) NSString     *rating;
@property(nonatomic, copy) NSString     *nickname;
@property(nonatomic, copy) NSString     *content;
@property(nonatomic, copy) NSString     *add_time;
@property(nonatomic, copy) NSString     *like_id;
@property(nonatomic, copy) NSString     *like_count;
@property(nonatomic, copy) NSString     *unlike_count;
@property(nonatomic, copy) NSString     *is_show;
@property(nonatomic, copy) NSString     *img_data;
@property(nonatomic, copy) NSString     *like_type;

@property(nonatomic, strong) NSArray    *pic_urls;

@property(nonatomic ,copy) NSString     *identifier;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)commitWithDict:(NSDictionary *)dict;
@end
