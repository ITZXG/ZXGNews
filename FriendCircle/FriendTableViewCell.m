//
//  FriendTableViewCell.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/7.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "FriendImageView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CommonModel.h"

@interface FriendTableViewCell()
// 昵称
@property(nonatomic ,strong) UILabel        *nameLab;
// 头像
@property(nonatomic ,strong) UIImageView    *avatar;
// 时间
@property(nonatomic ,strong) UILabel        *timeLab;
// 内容
@property(nonatomic ,strong) UILabel        *contentLab;
// 图片
@property(nonatomic ,strong) FriendImageView *photosView;
// 分割线
@property(nonatomic ,strong) UIView         *line;
@end

@implementation FriendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self setUpAllView];
    }
    return self;
}


- (void)setModel:(CommonModel *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nameLab.text = model.nickname;
    self.contentLab.text = model.content;
    NSInteger time = [model.add_time integerValue];
    self.timeLab.text = [self dateWithTimeInterval:time format:@"MM月dd日"];

    NSInteger count = model.pic_urls.count;
    
    if (count > 0 ) {
        _photosView.pic_urls = model.pic_urls;
        _photosView.selfVc = _weakSelf;
        // 有图片重新更新约束
        CGFloat oneheight = ([UIScreen mainScreen].bounds.size.width - _nameLab.frame.origin.x - 15 -20)/3;
        // 三目运算符 小于或等于3张 显示一行的高度 ,大于3张小于或等于6行，显示2行的高度 ，大于6行，显示3行的高度
        CGFloat photoHeight = count<=3 ? oneheight : (count<=6 ? 2*oneheight+10 : oneheight *3+20);
        
        [_photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLab.mas_bottom).offset(10);
            make.left.equalTo(_nameLab.mas_left);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(photoHeight);
            make.bottom.mas_equalTo(-15);
        }];
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0); // 这句很重要！！！
        }];
        _photosView.hidden = NO;
    }else{
        [_photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLab.mas_bottom).offset(10);
            make.left.equalTo(_nameLab.mas_left);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(0.001);
        }];
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            //            make.top.equalTo(_photosView.mas_bottom).offset(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0); // 这句很重要！！！
        }];
        
        _photosView.hidden = YES;
    }
    
}

- (void)setUpAllView {
    // 头像
    UIImageView *imageView = [[UIImageView alloc]init];
    self.avatar = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.width.height.mas_equalTo(40);
    }];
    
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    self.nameLab = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView.mas_centerY);
        make.left.equalTo(imageView.mas_right).offset(15);
    }];
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc]init];
    self.timeLab = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    // 内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    self.contentLab = contentLabel;
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.equalTo(nameLabel.mas_left);
        make.right.mas_equalTo(-15);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    

    // 图片
    FriendImageView *imageViews = [[FriendImageView alloc]init];
    self.photosView = imageViews;
    [self.contentView addSubview:imageViews];
    [imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(10);
        make.left.equalTo(_nameLab.mas_left);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.001);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
//    self.photosView = [[ZJCommitPhotoView alloc]init];
//    [self.contentView addSubview:self.photosView];
//    [_photosView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_contentLab.mas_bottom).offset(10);
//        make.left.equalTo(_nameLab.mas_left);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(0.001);
//    }];
    
#warning 注意  不管你的布局是怎样的 ，一定要有一个(最好是最底部的控件)相对 contentView.bottom的约束，否则计算cell的高度的时候会不正确！
//    self.line = [UIView zj_viewWithBackColor:kLightGrayColor supView:self.contentView constraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_photosView.mas_bottom).offset(15);
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(0.5);
//        make.bottom.mas_equalTo(0); // 这句很重要！！！
//
//    }];
    UIView *lineView = [[UIView alloc]init];
    self.line =lineView;
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photosView.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
}

- (NSString *)dateWithTimeInterval:(NSTimeInterval)interval format:(NSString *)formating
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    return [dateFormatter stringFromDate:date];
}
@end
