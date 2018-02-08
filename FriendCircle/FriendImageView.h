//
//  FriendImageView.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/7.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendImageView : UIView
@property(nonatomic ,weak) UIViewController *selfVc;
@property(nonatomic, strong) NSArray *pic_urls;
@end
