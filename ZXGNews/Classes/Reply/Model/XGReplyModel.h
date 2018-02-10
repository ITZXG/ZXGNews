//
//  XGReplyModel.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/10.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGReplyModel : NSObject
/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;
@end
