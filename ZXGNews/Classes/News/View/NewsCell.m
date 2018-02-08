//
//  NewsCell.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/12/1.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import <UIImageView+WebCache.h>
#import "Masonry.h"
@interface NewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UILabel *digistLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.digistLabel.preferredMaxLayoutWidth = self.bounds.size.width - 106;
}

- (void)setNews:(News *)news {
    _news = news;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    self.titelLabel.text = news.title;
    self.digistLabel.text = news.digest;
    self.replayCountLabel.text = [NSString stringWithFormat:@"%d",news.replyCount];
    if (news.imgextra.count == 2) {
        for (int i = 0; i < news.imgextra.count; ++i) {
            NSDictionary *dict = news.imgextra[i];
            NSString *imageViewString = dict[@"imgsrc"];
            UIImageView *imageVIew = self.imageViews[i];
            [imageVIew sd_setImageWithURL:[NSURL URLWithString:imageViewString]];
        }
    }
}

@end
