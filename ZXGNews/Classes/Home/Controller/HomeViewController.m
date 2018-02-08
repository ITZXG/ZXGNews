//
//  HomeViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "HomeViewController.h"
#import "Channel.h"
#import "ChannelLabel.h"
#import "NewsContentCell.h"
#import "NewsContentViewController.h"
#import "News.h"
#import "ImageShowViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/// 滚动的scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
/// 模型数组
@property (nonatomic, strong) NSArray *channelsModelArray;

/// 内容的cllectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionFlowLayout;
/// 存放频道的label
@property (nonatomic, strong) NSMutableArray *labelsArray;
/// 选中频道label的下标
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChannelLavel];
    [self setUpCollectionViewItem];
}

- (void)setUpChannelLavel {
    self.channelsModelArray = [Channel channels];
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / 5.0;
    CGFloat h = self.channelScrollView.frame.size.height;
    for (int i = 0; i < self.channelsModelArray.count; ++i) {
        ChannelLabel *channel = [[ChannelLabel alloc]init];
        if (i == 0) {
            channel.scale = 1.0;
        }
        channel.frame = CGRectMake(i * w, y, w, h);
        Channel *channelModel=self.channelsModelArray[i];
        channel.text = channelModel.tname;
        channel.tag = i;
        [self.labelsArray addObject:channel];
        [self.channelScrollView addSubview:channel];
        [channel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectLabel:)]];
    }
    self.channelScrollView.contentSize = CGSizeMake(w * self.channelsModelArray.count, 0);
}

- (void)didSelectLabel:(UITapGestureRecognizer *)tap {
    ChannelLabel *channelLabel = (ChannelLabel*)tap.view;
    self.selectIndex = channelLabel.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:channelLabel.tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self scrollLabelToCenter];
}

- (void)setUpCollectionViewItem {
    CGFloat itemSizeWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemSizeHeight = [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height - self.channelScrollView.frame.size.height;
    self.collectionFlowLayout.itemSize = CGSizeMake(itemSizeWidth, itemSizeHeight);
    self.collectionFlowLayout.minimumLineSpacing = 0;
    self.collectionFlowLayout.minimumInteritemSpacing = 0;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - self.collectionFlowLayout.itemSize.height;
    NSLog(@"%f--%@",height,NSStringFromCGSize(self.collectionFlowLayout.itemSize));
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return  self.channelsModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCell" forIndexPath:indexPath ];
    Channel *channel = self.channelsModelArray[indexPath.item];
    cell.clickBlock = ^(NSIndexPath *indexPath1, News *news) {
        if (news.imgextra.count) {
            ImageShowViewController *showVC = [[ImageShowViewController alloc]init];
            showVC.news = news;
            showVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:showVC animated:YES];
        }else {
            UIStoryboard *sb= [UIStoryboard storyboardWithName:@"News" bundle:nil] ;
            NewsContentViewController *contentVC = [sb instantiateViewControllerWithIdentifier:@"newsContent"];
            contentVC.news = news;
            contentVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:contentVC animated:YES];
        }

    };
    cell.urlString = channel.urlString;
    return cell;
}
- (void)scrollLabelToCenter {
    // 选中的label
    ChannelLabel *selectLabel = self.labelsArray[self.selectIndex];
    // 应该滚出的距离
    CGFloat needScrollOffsetX = selectLabel.center.x - self.channelScrollView.bounds.size.width * 0.5;
    // 如果是第一个label不滚动
    if(needScrollOffsetX < 0) {
        needScrollOffsetX = 0;
    }
    // 最大滚动的范围
    CGFloat maxScrollOffsetX = self.channelScrollView.contentSize.width - self.channelScrollView.bounds.size.width;
    if (needScrollOffsetX > maxScrollOffsetX) {
        needScrollOffsetX = maxScrollOffsetX;
    }
    [self.channelScrollView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
    
    for (ChannelLabel *label in self.labelsArray) {
        if (label.tag == self.selectIndex) {
            label.scale = 1.0;
        }
        else {
            label.scale = 0.0;
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.selectIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self scrollLabelToCenter];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = (CGFloat)scrollView.contentOffset.x / scrollView.bounds.size.width;
   // 防止滚动出边界
    if (value < 0 || value > self.channelsModelArray.count - 1) {
        return;
    }
    // 左边的索引
    NSInteger leftIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 右边的索引
    NSInteger rightIndex = leftIndex + 1;
    // 计算各自的比率
    CGFloat rightScale = value - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    ChannelLabel *leftlabel= self.labelsArray[leftIndex];
    leftlabel.scale = leftScale;
    if (rightIndex < self.channelsModelArray.count) {
        ChannelLabel *label = self.labelsArray[rightIndex];
        label.scale = rightScale;
    }
    
}
#pragma mark 懒加载
- (NSMutableArray *)labelsArray {
    if (_labelsArray == nil) {
        _labelsArray = [NSMutableArray array];
    }
    return _labelsArray;
}
@end
