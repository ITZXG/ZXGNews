//
//  NewsContentCell.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "NewsContentCell.h"
#import "NewsTableViewController.h"
@interface NewsContentCell ()
@property (nonatomic, strong)NewsTableViewController *newsVC;
@end

@implementation NewsContentCell
- (void)awakeFromNib {
        [super awakeFromNib];
    UIStoryboard *newsSB =[UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsVC =newsSB.instantiateInitialViewController;
    self.newsVC.tableView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.newsVC.tableView];
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    self.newsVC.urlString = _urlString;
    self.newsVC.clickBlock = self.clickBlock;
//    [self.newsVC loadNewData];
}
@end
