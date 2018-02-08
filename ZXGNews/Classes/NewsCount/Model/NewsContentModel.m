//
//  NewsContentModel.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "NewsContentModel.h"
#import "NewsContentDetailImgModel.h"
#import "NSDate+CH.h"

@implementation NewsContentModel
+(instancetype)initWithDict:(NSDictionary *)dict
{
    NewsContentModel *detailModel=[[NewsContentModel alloc]init];
    detailModel.title = dict[@"title"];
    detailModel.ptime = dict[@"ptime"];
    detailModel.body = dict[@"body"];
    detailModel.source=dict[@"source"];
    
    NSArray *imgArr=dict[@"img"];
    NSMutableArray *tempArr=[NSMutableArray arrayWithCapacity:imgArr.count];
    if(imgArr){
        for (NSDictionary *dic in imgArr) {
            NewsContentDetailImgModel *imgModel=[NewsContentDetailImgModel initWithDict:dic];
            [tempArr addObject:imgModel];
            
        }
    }
    
    detailModel.img=tempArr;
    
    return detailModel;
}

//设置时间
-(NSString *)ptime
{
    
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
#warning 真机调试 必须加上这句
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *creatDate=[fmt dateFromString:_ptime];
    
    
    //判断是否为今年
    if (creatDate.isThisYear) {//今年
        if (creatDate.isToday) {
            //获得微博发布的时间与当前时间的差距
            NSDateComponents *cmps=[creatDate deltaWithNow];
            if (cmps.hour>=1) {//至少是一个小时之前发布的
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }else if(cmps.minute>=1){//1~59分钟之前发布的
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }else{//1分钟内发布的
                return @"刚刚";
            }
        }else if(creatDate.isYesterday){//昨天发的
            fmt.dateFormat=@"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
        }else{//至少是前天发布的
            fmt.dateFormat=@"yyyy-MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }else           //  往年
    {
        fmt.dateFormat=@"yyyy-MM-dd";
        return [fmt stringFromDate:creatDate];
    }
    
    
    // return _ptime;
}

@end
