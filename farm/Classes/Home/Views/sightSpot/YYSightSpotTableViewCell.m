//
//  YYSightSpotTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotTableViewCell.h"
#import "YYSightSpotModel.h"
#import "YYSightSpotTagsView.h"

#import "YYHomeMarkViewModel.h"

@interface YYSightSpotTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *spotImageView;

@property (weak, nonatomic) YYSightSpotTagsView *spotTagsView;

@property (weak, nonatomic) IBOutlet UILabel *spotTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *spotAddressImageView;

@property (weak, nonatomic) IBOutlet UILabel *spotAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *spotDistanceLabel;

@property (weak, nonatomic) IBOutlet UIView *verticalLineView;
@property (weak, nonatomic) IBOutlet UIView *horizontalLineView;

@property (nonatomic, strong) UIFont *addressFont;

@end

@implementation YYSightSpotTableViewCell
- (UIFont *)addressFont{
    if (!_addressFont) {
        _addressFont = kText16Font10Height;
    }
    return _addressFont;
}
+ (instancetype)sightSpotTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSightSpotTableViewCell";
    YYSightSpotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYSightSpotTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    //增加标签的View
    YYSightSpotTagsView *tagsView = [[YYSightSpotTagsView alloc] init];
    [self.contentView addSubview:tagsView];
    self.spotTagsView = tagsView;
    
    [self addConstrainsOnSubViews];
    
    [self setSubViews];
    
    
    
}
- (void)addConstrainsOnSubViews{
    
    CGFloat spotImageViewH = 200/603.0*kNoNavHeight;
    [self.spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.top.mas_equalTo(self).mas_offset(kY12Margin);
        make.height.mas_equalTo(spotImageViewH);
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
    }];
    
    CGFloat spotTitleLabelH = 14.0;
    CGFloat Ymargin = 10;
    [self.spotTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.spotImageView);
        make.top.mas_equalTo(self.spotImageView.mas_bottom).mas_offset(Ymargin);
        make.height.mas_equalTo(spotTitleLabelH);
    }];
    
    CGFloat iconW = 14;
    CGFloat iconH = 14;
    [self.spotAddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spotTitleLabel);
        make.size.mas_equalTo(CGSizeMake(iconW, iconH));
        make.top.mas_equalTo(self.spotTitleLabel.mas_bottom).mas_offset(Ymargin);
    }];
    
    [self.spotAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spotAddressImageView.mas_right).mas_offset(5);
        make.top.bottom.mas_equalTo(self.spotAddressImageView);
    }];
    
    [self.verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.spotAddressImageView);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.spotAddressLabel.mas_right).mas_offset(6);
    }];
    [self.spotDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verticalLineView.mas_right).mas_offset(6);
        make.top.bottom.mas_equalTo(self.spotAddressImageView);
    }];
    
    [self.horizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.spotImageView);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self);
    }];
    
    
}

- (void)setSubViews{
    self.spotTitleLabel.font = kText22Font14Height;
    self.spotTitleLabel.textColor = kBlack56Color;
    
    self.spotAddressImageView.image = [UIImage imageNamed:@"spot_address_icon"];
    
    self.spotAddressLabel.font = self.addressFont;;
    self.spotAddressLabel.textColor = kGray105Color;
    
    self.spotDistanceLabel.font = self.addressFont;;
    self.spotDistanceLabel.textColor = kGray105Color;
    
    self.verticalLineView.backgroundColor = kGray105Color;
    
    self.horizontalLineView.backgroundColor = kGrayLine225Color;
  
}
- (void)setModel:(YYSightSpotModel *)model{
    _model = model;
    
    self.spotImageView.image = [UIImage imageNamed:model.spotOuterImgurl];
    
    self.spotTitleLabel.text = model.spotTitle;
    
    NSDictionary *attr = @{
                           NSFontAttributeName : self.addressFont,
                           };
    NSString *spotDistanceStr = [NSString distanceStrWithDistanceStr:model.spotDistance];
    
    CGFloat spotDistanceLabelW = [spotDistanceStr calculateWidthStringWithAttr:attr andMaxWidth:100 andMaxHeight:14];
    
    [self.spotDistanceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spotDistanceLabelW);
    }];
   
    self.spotDistanceLabel.text = spotDistanceStr;
    
    
    CGFloat spotAddressLabelMaxW = kWidthScreen - kX12Margin * 2 - 5 - 14 - 6 - 1 - 6 - spotDistanceLabelW;
    CGFloat spotAddressLabelW = [model.spotAddress calculateWidthStringWithAttr:attr andMaxWidth:spotAddressLabelMaxW andMaxHeight:14];
    [self.spotAddressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spotAddressLabelW);
    }];
    self.spotAddressLabel.text = model.spotAddress;
    
    
    //设置标签
    NSDictionary *tagsAttr = @{
                           NSFontAttributeName : kText16Font10Height
                           };
    CGFloat spotTagsViewH = [YYHomeMarkViewModel tagsViewHeightWithTagsArray:model.spotTags andAttr:tagsAttr andxMargin:kX12Margin andItemH:18 andyMargin:kY12Margin/2.0];
    [self.spotTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.spotImageView);
        make.height.mas_equalTo(spotTagsViewH);
    }];
    
    self.spotTagsView.tagsArray = model.spotTags;

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
