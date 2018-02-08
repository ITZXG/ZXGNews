//
//  FriendTableViewCell.h
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/7.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonModel;

@interface FriendTableViewCell : UITableViewCell
@property (nonatomic, strong) CommonModel *model;
@property(nonatomic ,weak) UIViewController *weakSelf;
@end
