//
//  YYSightSpotProductTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotProductTableViewCell.h"
#import "YYSightSpotProductModel.h"


@interface YYSightSpotProductTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation YYSightSpotProductTableViewCell
+ (instancetype)sightSpotProductTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSightSpotProductTableViewCell";
    
    YYSightSpotProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYSightSpotProductTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentView.backgroundColor = kViewBGColor;
    [self.contentView removeConstraints:[self.contentView constraints]];
    
    [self addConstraints];
    
    [self setSubViews];
}
- (void)addConstraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(kX12Margin);
        make.right.mas_equalTo(self.contentView).mas_offset(-kX12Margin);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    
    CGFloat imageViewW = 130;
//    CGFloat imageViewH = 80;
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(kX12Margin);
        make.width.mas_equalTo(imageViewW);
        make.top.mas_equalTo(self.bgView).mas_offset(kY12Margin);
        make.bottom.mas_equalTo(self.bgView).mas_offset(-kY12Margin);
    }];
    
    CGFloat titleLabelH = kHeightText20 + 5 * 2;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(kX12Margin);
        make.right.mas_equalTo(self.bgView).mas_offset(-kX12Margin);
        make.height.mas_equalTo(titleLabelH);
        make.top.mas_equalTo(self.leftImageView);
    }];
    
    CGFloat weightLabelH = 5 * 2 + kHeightText16;
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(weightLabelH);
    }];
    
    CGFloat priceLabelH = kHeightText24 + 5 * 2;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.weightLabel.mas_bottom);
        make.height.mas_equalTo(priceLabelH);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView);
        make.right.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.bgView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)setSubViews{
    self.titleLabel.font = kText20Font12Height;
    self.titleLabel.textColor = kBlack56Color;
    
    self.weightLabel.font = kText16Font10Height;
    self.weightLabel.textColor = kGray105Color;
    
    self.priceLabel.font = kText24Font15Height;
    self.priceLabel.textColor = kRGBAColor(248, 100, 0, 1);
    
    self.lineView.backgroundColor = kGrayLine225Color;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YYSightSpotProductModel *)model{
    _model = model;
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.productOuterImgurl]];
    
    self.titleLabel.text = model.productName;
    
    self.weightLabel.text = model.productPackaging;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", model.productPrice];
}
@end
