//
//  CycleCollectionViewCell.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/4.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import "Cycle.h"
#import <UIImageView+WebCache.h>
@interface CycleCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *diseLabel;

@end

@implementation CycleCollectionViewCell
- (void)setCycle:(Cycle *)cycle {
    _cycle = cycle;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:cycle.imgsrc]];
    self.diseLabel.text = cycle.title;
}
@end
