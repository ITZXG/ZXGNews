//
//  NewsContentViewController.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/5.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "NewsContentViewController.h"
#import "NetworkTool.h"
#import "News.h"
#import "NewsContentModel.h"
#import "NewsContentDetailImgModel.h"
#import "UIImage+CH.h"

@interface NewsContentViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NewsContentModel *detailModel;
@end

@implementation NewsContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavtionBar];
    NSString *urlString = [NSString stringWithFormat:@"article/%@/full.html",self.news.docid];
    [[NetworkTool shareNetworkTool] objectWIthUrlString:urlString complectionBloack:^(id object, NSError *error) {
        self.detailModel = [NewsContentModel initWithDict:object[self.news.docid]];
        [self loadWebViewData];
    }];
    
}

- (void)setupNavtionBar {
    //2.在自定义的导航栏上面添加按钮
    UIButton *backBtn=[[UIButton alloc]init];
    //icon_back_highlighted
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    
    UIButton *replyBtn = [[UIButton alloc]init];
    [replyBtn setBackgroundImage: [UIImage resizedImage:@"contentview_commentbacky" left:0.5 top:0.5] forState:UIControlStateNormal];
    [replyBtn setBackgroundImage:[UIImage resizedImage:@"contentview_commentbacky_selected"] forState:UIControlStateHighlighted];
    [replyBtn setTitle:[NSString stringWithFormat:@"%@",self.news.replyCount] forState:UIControlStateNormal];
    [replyBtn sizeToFit];
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    replyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -5, 0, 5);
    
    [replyBtn addTarget:self action:@selector(clickReplyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:replyBtn];
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)clickBackBtn:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)clickReplyBtn:(UIButton *)button {
    
    
    
}

//手势开始的时候触发方法
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{   //判断如果是系统左滑返回页面的手势就停止掉
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return YES;
//}

#pragma mark webView加载网页数据
-(void)loadWebViewData
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"detail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    //添加新闻内容
    [html appendString:[self addBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)addBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@ &nbsp;&nbsp %@</div>",self.detailModel.ptime,self.detailModel.source];
    
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (NewsContentDetailImgModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}


@end
