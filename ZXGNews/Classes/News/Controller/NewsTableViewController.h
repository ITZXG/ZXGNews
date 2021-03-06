//
//  NewsTableViewController.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
typedef void (^ClickBlock) (NSIndexPath *indexPath,News *news);
@interface NewsTableViewController : UITableViewController
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) ClickBlock clickBlock;
- (void)loadNewData;
@end
