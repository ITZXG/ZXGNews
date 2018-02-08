//
//  NewsTableViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "NewsTableViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "UIView+ViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"

@interface NewsTableViewController ()
@property (nonatomic, strong) NSMutableArray *modelArray;
/// 上拉加载更多
@property (nonatomic, strong) UIActivityIndicatorView *footerIndicatorVIew;
/// 数据的索引
@property (nonatomic, assign) NSInteger dataIndex;
@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    [self.refreshControl addTarget:self action:@selector(loadNewData) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    UIActivityIndicatorView *footerView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.tableView.tableFooterView = footerView;
    self.footerIndicatorVIew = footerView;
        
}
- (void)loadNewData {
    [News newsListWithUrlString:self.urlString finishedBlock:^(NSArray *NewsList) {
        [self.modelArray removeAllObjects];
        [self.modelArray addObjectsFromArray:NewsList];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}
- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    [News newsListWithUrlString:urlString finishedBlock:^(NSArray *NewsList) {
        [self.modelArray removeAllObjects];
        [self.modelArray addObjectsFromArray:NewsList];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.modelArray[indexPath.item];
    static NSString *cellID = @"baseCell";
    if (news.imgType) {
        cellID = @"bigCell";
    }else if (news.imgextra.count == 2) {
        cellID = @"threeImageCell";
    }else {
        cellID = @"baseCell";
    }
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.news = news;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.modelArray[indexPath.item];
    if (news.imgType) {
        return 200;
    }else if (news.imgextra.count == 2) {
        return 120;
    }else {
        return 100;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.modelArray[indexPath.item];
    if (self.clickBlock) {
        
        self.clickBlock(indexPath, news);
    }
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.modelArray.count - 1 && !self.footerIndicatorVIew.isAnimating) {
        [self.footerIndicatorVIew startAnimating];
        [self loadMoreData];
    }
}

- (void)loadMoreData {
    self.dataIndex++;
    NSString *lastPathComponet = self.urlString.lastPathComponent;
    NSRange range = [self.urlString rangeOfString:lastPathComponet];
    NSString *previousString = [self.urlString substringToIndex:range.location];
    NSString *newUrlString = [previousString stringByAppendingString:[NSString stringWithFormat:@"%ld-20.html",self.dataIndex * 10]];
    [News newsListWithUrlString:newUrlString finishedBlock:^(NSArray *NewsList) {
        [self.modelArray addObjectsFromArray:NewsList];
        [self.tableView reloadData];
        [self.footerIndicatorVIew stopAnimating];
    }];
}

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
