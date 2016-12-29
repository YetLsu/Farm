//
//  YYTripReadTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTripReadTableViewCell.h"
#import "YYTripReadViewModel.h"

@interface YYTripReadTableViewCell ()

@property (nonatomic, weak) UIImageView *leftImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation YYTripReadTableViewCell

+ (instancetype)tripReadTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYTripReadTableViewCell";
    YYTripReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYTripReadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIImageView *leftImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:leftImageView];
        self.leftImageView = leftImageView;
        
        CGFloat leftImageViewW = kX12Margin * 2 + 15;
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(leftImageViewW);
            make.top.bottom.left.mas_equalTo(self.contentView);
        }];
        self.leftImageView.contentMode = UIViewContentModeCenter;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftImageView.mas_right);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0.5);
            make.width.mas_equalTo(200);
        }];
        titleLabel.textColor = kBlack56Color;
        titleLabel.font = kText24Font15Height;
        
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = kGrayLine225Color;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(leftImageViewW);
            make.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
        CGFloat rightImageViewW = kX12Margin * 2 + 10;
        UIImageView *rightImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:rightImageView];
        rightImageView.image = [UIImage imageNamed:@"back_black"];
        rightImageView.contentMode = UIViewContentModeCenter;
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(rightImageViewW);
        }];
        
        
    }
    return self;
}
- (void)setModel:(YYTripReadModel *)model{
    _model = model;
    
    self.leftImageView.image = [UIImage imageNamed:model.leftImageName];
    
    self.titleLabel.text = model.cellTitle;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
