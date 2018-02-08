//
//  ChannelLabel.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:18];
        self.textAlignment =NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    CGFloat minScale = 0.8;
    // 真是的缩放比率,0.8~1
    CGFloat realScale = minScale + (1 - minScale)*scale;
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
}
@end
