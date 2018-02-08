//
//  Cycle.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/4.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Complection)(NSArray *array);
@interface Cycle : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;
+(void)cycleListWithUrlString:(NSString *)urlString complection:(Complection) complection;
@end
