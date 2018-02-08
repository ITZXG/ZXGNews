//
//  Cycle.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/4.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "Cycle.h"
#import "NetworkTool.h"
#import <objc/runtime.h>

@implementation Cycle
+ (NSArray *)properties{
    unsigned int count;
    /**
     1.获取属性列表
     参数1:获取哪个类的
     参数2:count表示你该类里面有多少个属性
     
     propertyList 它就相当于一个数组
     
     数组里面就装着@property (nonatomic, copy) NSString *title;,@property (nonatomic, copy) NSString *digest;...
     */
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    //定义OC的属性数组
    NSMutableArray *ocProperties = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        //2.取出objc_property_t数组中的property
        objc_property_t property = propertyList[i];
        
        //3.获取的是C语言的名称
        const char *cPropertyName = property_getName(property);
        
        //4.将C语言的字符串转成OC的
        NSString *ocPropertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        
        //5.添加到属性数组中
        [ocProperties addObject:ocPropertyName];
    }
    
    //5.C语言中,用完copy,create的东西之后,最好释放
    free(propertyList);
    
    return ocProperties.copy;
}


+ (instancetype)cycleWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    NSArray *properties = [self properties];
    
    for (NSString *key in properties) {
        if (dict[key]) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
    return obj;
}

+(void)cycleListWithUrlString:(NSString *)urlString complection:(Complection)complection {
    [[NetworkTool shareNetworkTool] objectWIthUrlString:urlString complectionBloack:^(id object, NSError *error) {
        NSDictionary *dictObj = (NSDictionary *)object;
        //1.通过key,取出字典数组
        NSArray *dictArray = dictObj[@"headline_ad"];
        
        //2.遍历我们的字典数组,实现字典转模型
        // 字典转模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            [arrayM addObject:[self cycleWithDict:dict]];
        }
        
        //3.通过返回给我们的控制器(调用者)
        if (complection) {
            complection(arrayM.copy);
        }
    }];
}
@end
