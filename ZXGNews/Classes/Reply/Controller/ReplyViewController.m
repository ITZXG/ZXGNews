 //
//  ReplyViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "ReplyViewController.h"
#import "NetworkTool.h"
#import "News.h"
#import "XGReplyModel.h"
#import "XWReplyHeaderView.h"
#import "Masonry.h"
#import "XGReplyCell.h"
#import "UITableView+FDTemplateLayoutCell.h"



static NSString *CELLID = @"cellid  ";
@interface ReplyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupUI];
    [self loadNetWorkData];
}

- (void)loadNetWorkData {
    NSString *urlString =[NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.news.boardid,self.news.docid];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (jsonDict[@"hotPosts"] ) {
            NSArray *array = jsonDict[@"hotPosts"];
            for (NSDictionary *dict in array) {
                XGReplyModel *model = [[XGReplyModel alloc]init];
                if(dict[@"1"][@"u"]){
                    model.name=dict[@"1"][@"n"];
                }else {
                    model.name = @"火星网友";
                }
                if(dict[@"1"][@"f"]){
                    model.address=dict[@"1"][@"f"];
                }else {
                    model.address = @"未知地点";
                }
                model.say = dict[@"1"][@"b"]?dict[@"1"][@"b"]:nil;
                if(dict[@"1"][@"v"]){
                    model.suppose=dict[@"1"][@"v"];
                }
                [self.dataArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }] resume];
 
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[XGReplyCell class] forCellReuseIdentifier:CELLID];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
        cell.textLabel.text=@"暂无跟帖数据";
        return cell;
    }else {
        XGReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count) {
        CGFloat height = [self.tableView fd_heightForCellWithIdentifier:CELLID cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
        return height;
    }
    return 30;
}

#pragma mark - 给cell赋值
- (void)configureCell:(XGReplyCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    // 采用计算frame模式还是自动布局模式，默认为NO，自动布局模式
    //    cell.fd_enforceFrameLayout = NO;
    cell.replyModel = self.dataArray[indexPath.row];
}

//返回表格单元头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return [XWReplyHeaderView shareWithTitle:@"热门评论"];
    }
    
    return [XWReplyHeaderView shareWithTitle:@"最新评论"];
}
//返回头视图的高度
//返回每个headView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
