//
//  CycleCollectionViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/4.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "CycleCollectionViewController.h"
#import "CycleCollectionViewCell.h"
#import "Cycle.h"
#import "Masonry.h"
#import <objc/runtime.h>
#define MINSESTION 3
@interface CycleCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation CycleCollectionViewController

static NSString * const reuseIdentifier = @"cycleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addPageControl];
    [self loadData];
}
- (void)addPageControl {
    self.pageControl = [[UIPageControl alloc]init];
//    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
//    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(10);
    }];
//    unsigned int count;
//    Ivar *ivarArray = class_copyIvarList([UIPageControl class], &count);
//    for (int i = 0; i < count; ++i) {
//        Ivar ivar = ivarArray[i];
//        const char *name = ivar_getName(ivar);
//        NSString *string = [[NSString alloc]initWithCString:name encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",string);
//    }
//    free(ivarArray);
    [self.pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];

}

- (void)loadData {
    [Cycle cycleListWithUrlString:@"ad/headline/0-4.html" complection:^(NSArray *array) {
        self.modelArray = array;
        [self.collectionView reloadData];
         [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.pageControl.numberOfPages = array.count;
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSInteger needIndex = currentIndex % self.modelArray.count;
    self.pageControl.currentPage = needIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:needIndex inSection:1] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MINSESTION;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Cycle *cycle = self.modelArray[indexPath.item];
    cell.cycle = cycle;
    return cell;
}

@end
