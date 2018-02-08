//
//  ImageShowViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "ImageShowViewController.h"
#import "XGPhotoBottomView.h"
#import "XGPhotoContentView.h"
#import "XWPhotoModel.h"
#import "Masonry.h"
#import "UIView+MJ.h"
#import "NetworkTool.h"
#import "News.h"
#import "MJExtension.h"
#import "XWPhotoDetailModel.h"
#import "UIImageView+WebCache.h"

@interface ImageShowViewController() <UIScrollViewDelegate>
@property (nonatomic, strong) XGPhotoBottomView *photoBottom;
@property (nonatomic, strong) XGPhotoContentView *photoContentV;
//滚动视图
@property (nonatomic,weak) UIScrollView *photoScrollView;
//新闻数据的模型
@property (nonatomic,strong)  XWPhotoModel *photoModel;
@end

@implementation ImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加自定义的scrollView  里面放图片
    [self setupScrollView];
    //1 添加新闻内容的view
    [self addPhotoContentView];
    //4.添加底部的view
    [self addBottomView];
    //5.内容请求
    [self setupRequest];
}

#pragma mark  添加自定义的scrollView  里面放图片
-(void)setupScrollView
{
    UIScrollView *photoScrollView=[[UIScrollView alloc]init];
    [self.view addSubview:photoScrollView];
    [photoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.mas_equalTo(photoBottomH);
    }];
    photoScrollView.delegate=self;
    photoScrollView.showsHorizontalScrollIndicator = NO;
    photoScrollView.showsVerticalScrollIndicator = NO;
    self.photoScrollView = photoScrollView;
}

#pragma mark 添加新闻内容的view
-(void)addPhotoContentView
{
    XGPhotoContentView *contentV=[[XGPhotoContentView alloc]init];
    contentV.x=0;
    contentV.y=self.view.height-photoBottomH-photoContentH;
    [self.view addSubview:contentV];
    self.photoContentV=contentV;
}
#pragma mark 添加底部的view
-(void)addBottomView
{
    XGPhotoBottomView *photoView=[[XGPhotoBottomView alloc]init];
    
    photoView.x=0;
    photoView.y=self.view.height-photoView.height;
    
    [self.view addSubview:photoView];
    self.photoBottom=photoView;
}

#pragma mark  发送网络请求

-(void)setupRequest {
    //1.取出关键字  54GI0096|78327
    NSString *one=self.news.photosetID;
    //2.从第四个开始截取
    NSString *two=[one substringFromIndex:4];
    NSArray *three=[two componentsSeparatedByString:@"|"];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    [[NetworkTool shareNetworkTool] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XWPhotoModel *photoModel=[XWPhotoModel mj_objectWithKeyValues:responseObject];
        self.photoModel=photoModel;
        //1.显示内容到label
        [self setContentWithModel:photoModel];
        //2.显示图片到scrollView
        [self setImageViewWithModel:photoModel];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark 显示新闻内容到view
-(void)setContentWithModel:(XWPhotoModel*)photoModel
{
    self.photoContentV.titleLabel.text = photoModel.setname;
    
    // 设置新闻内容
    [self setContentWithIndex:0];
    
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoModel.photos.count];
    self.photoContentV.numLabel.text=countNum;
}

#pragma mark 设置新闻内容
-(void)setContentWithIndex:(NSInteger)index
{
    NSString *content = [self.photoModel.photos[index] note];
    NSString *contentTitle = [self.photoModel.photos[index] imgtitle];
    if (content.length != 0) {
        self.photoContentV.contentText.text = content;
    }else{
        self.photoContentV.contentText.text  = contentTitle;
    }
}
/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScrollView.contentOffset.x / self.photoScrollView.width;
    
    // 添加图片
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%zd",index+1,self.photoModel.photos.count];
    self.photoContentV.numLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}

/** 懒加载添加图片！这里才是设置图片 */
- (void)setImgWithIndex:(NSInteger)i
{
    
    UIImageView *photoImgView = nil;
    
    photoImgView = self.photoScrollView.subviews[i];
    
    XWPhotoDetailModel  *detailModel = self.photoModel.photos[i];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
        [photoImgView sd_setImageWithURL:[NSURL URLWithString:detailModel.imgurl] placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
    }
    
}
#pragma mark 添加新闻图片
- (void)setImageViewWithModel:(XWPhotoModel *)photoModel
{
    NSUInteger count = self.photoModel.photos.count;
    
    for (int i = 0; i < count; i++) {
        UIImageView *photoImgView = [[UIImageView alloc]init];
        photoImgView.height = self.photoScrollView.height;
        photoImgView.width = self.photoScrollView.width;
        photoImgView.y = -30;
        photoImgView.x = i * photoImgView.width;
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode= UIViewContentModeTopLeft;
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        
        [self.photoScrollView addSubview:photoImgView];
        
    }
    //设置第一张图片
    [self setImgWithIndex:0];
    
    self.photoScrollView.contentOffset = CGPointZero;
    self.photoScrollView.contentSize = CGSizeMake(self.photoScrollView.width * count, 0);
    self.photoScrollView.pagingEnabled = YES;
}
@end
