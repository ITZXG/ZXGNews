//
//  XGPhotoContentView.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/8.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "XGPhotoContentView.h"
#import "UIView+MJ.h"
#define marginLeft 10
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height

@implementation XGPhotoContentView
-(instancetype)init
{
    self=[super init];
    if(self){
        self.width = ScreenWidth;
        self.height = photoContentH;
        //添加子控件
        [self addChild];
    }
    return self;
}


-(void)addChild
{
    //1.添加title
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont fontWithName:@"HYQiHei" size:15];
    [self addSubview:titleLabel];
    self.titleLabel=titleLabel;
    //2.添加图片数量label
    UILabel *numLabel=[[UILabel alloc]init];
    numLabel.textAlignment=NSTextAlignmentRight;
    numLabel.font=[UIFont systemFontOfSize:15];
    numLabel.textColor=[UIColor whiteColor];
    [self addSubview:numLabel];
    self.numLabel=numLabel;
    //3.显示对片对应的内容
    UITextView *contentText=[[UITextView alloc]init];
    contentText.backgroundColor=[UIColor clearColor];
    contentText.editable=NO;
    contentText.contentInset=UIEdgeInsetsMake(-7, 0, 7, 0);
    //contentText.userInteractionEnabled=NO;
    contentText.textColor=[UIColor whiteColor];
    contentText.font=[UIFont systemFontOfSize:13];
    [self addSubview:contentText];
    self.contentText=contentText;
    
}

-(void)layoutSubviews
{
    //1.设置titleLabel的frame
    CGFloat titleLabelX=marginLeft;
    CGFloat titleLabelY=0;
    CGFloat titleLabelW=self.frame.size.width-marginLeft*5;
    CGFloat titleLabelH= 20;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    //2.设置数量label的frame
    CGFloat numLabelY=0;
    CGFloat numLabelW=60;
    CGFloat numLabelH=20;
    CGFloat numLabelX=self.frame.size.width-marginLeft-numLabelW;
    self.numLabel.frame=CGRectMake(numLabelX, numLabelY, numLabelW, numLabelH);
    //3.设置内容的frame
    CGFloat contentX=marginLeft;
    CGFloat contentY=CGRectGetMaxY(_titleLabel.frame);
    CGFloat contentW=self.frame.size.width-2*marginLeft;
    CGFloat contentH=self.frame.size.height-contentY;
    self.contentText.frame=CGRectMake(contentX, contentY, contentW, contentH);
}


@end
