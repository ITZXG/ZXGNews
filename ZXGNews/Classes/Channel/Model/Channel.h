//
//  Channel.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
/// 频道
@property (nonatomic, copy) NSString *tname;
/// 频道的id
@property (nonatomic, copy) NSString *tid;
/// 每个频道对应的url
@property (nonatomic, copy) NSString *urlString;
+(NSArray *)channels;
@end
