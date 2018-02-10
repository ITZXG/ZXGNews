//
//  XGReplyCell.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2018/2/10.
//  Copyright © 2018年 Raiing Medical. All rights reserved.
//

#import "XGReplyCell.h"
#import "Masonry.h"
#import "XGReplyModel.h"

@interface  XGReplyCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation XGReplyCell

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:@"comment_profile_mars"];
    [self.contentView addSubview:iconView];
    [iconView sizeToFit];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(30);
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.equalTo(iconView.mas_right).offset(5);
    }];
    
    
    UILabel *addressLabel = [[UILabel alloc]init];
    self.addressLabel = addressLabel;
    addressLabel.font = [UIFont systemFontOfSize:13];

    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
    }];
    
    UIImageView *zanImageView = [[UIImageView alloc]init];
    zanImageView.image = [UIImage imageNamed:@"night_contentview_pkbutton"];
    [self.contentView addSubview:zanImageView];
    [zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(iconView);
    }];
    
    UILabel *countLabel = [[UILabel alloc]init];
    self.countLabel = countLabel;
    countLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zanImageView);
        make.right.equalTo(zanImageView.mas_left).offset(-5);
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    [self.contentView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressLabel);
        make.right.equalTo(countLabel.mas_right);
        make.top.equalTo(addressLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
}

- (void)setReplyModel:(XGReplyModel *)replyModel {
    _replyModel = replyModel;
    self.nameLabel.text = replyModel.name;
    self.addressLabel.text = replyModel.address;
    self.countLabel.text = replyModel.suppose;
    self.contentLabel.text = replyModel.say;
}

@end
