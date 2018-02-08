//
//  FriendTableViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/7.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//
#import "CommonModel.h"
#import "FriendTableViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FriendTableViewCell.h"


@interface FriendTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
static NSString *CELLID = @"cellid";
@implementation FriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    [self.tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:CELLID];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadNetWorkData];
}

- (void)loadNetWorkData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MasonryCellData.json" ofType:nil];
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSArray *contentArray = dict[@"comments_list"];
    for (NSDictionary *dict in contentArray) {
        CommonModel *model = [CommonModel commitWithDict:dict];
        [self.dataArray addObject:model];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    [self configureCell:cell atIndexPath:indexPath];
    cell.weakSelf = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self.tableView fd_heightForCellWithIdentifier:CELLID cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    return height;
}

#pragma mark - 给cell赋值
- (void)configureCell:(FriendTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    cell.model = self.dataArray[indexPath.row];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
