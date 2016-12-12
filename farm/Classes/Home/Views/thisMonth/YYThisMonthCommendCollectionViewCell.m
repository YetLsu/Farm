//
//  YYThisMonthCommendCollectionViewCell.m
//  farm
//
//  Created by wyy on 2016/12/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThisMonthCommendCollectionViewCell.h"

#import "YYThisMonthCommendTagsView.h"

#import "YYSightSpotModel.h"

#import "YYThisMonthCommendViewModel.h"

@interface YYThisMonthCommendCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet YYThisMonthCommendTagsView *tagsView;

@end

@implementation YYThisMonthCommendCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    [self addConstraintsOnViews];
    
    [self setSubViews];
}

- (void)addConstraintsOnViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat tagsViewBottomOffset = kY12Margin + 2.5;
    CGFloat tagsViewH = 18;
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-tagsViewBottomOffset);
        make.height.mas_equalTo(tagsViewH);
    }];
    
    CGFloat addressLabelBottomOffset = kY12Margin * 3 + 2.5;
    CGFloat addressLabelH = kHeightText18;
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.tagsView.mas_top).mas_offset(-addressLabelBottomOffset);
        make.height.mas_equalTo(addressLabelH);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.addressLabel);
        make.left.mas_equalTo(self.addressLabel.mas_right).mas_offset(kX12Margin*0.5);
        make.width.mas_equalTo(1);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.addressLabel);
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(kX12Margin*0.5);
    }];
    
    CGFloat nameLabelBottomOffset = kY12Margin;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.addressLabel.mas_top).mas_offset(-nameLabelBottomOffset);
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
    }];

    CGFloat topImageViewbottomOffset = 2 * kY12Margin;
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLabel.mas_top).mas_offset(-topImageViewbottomOffset);
        make.left.top.right.mas_equalTo(self);
       
    }];
    
}

- (void)setSubViews{
    
    self.nameLabel.font = kText26Font16Height;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = kBlack56Color;
    
    self.addressLabel.font = kText18Font11Height;
    self.addressLabel.textColor = kGray105Color;
    
    self.distanceLabel.font = kText18Font11Height;
    self.distanceLabel.textColor = kGray105Color;
    
    self.lineView.backgroundColor = kGray105Color;
    
    
}

- (void)setModel:(YYSightSpotModel *)model{
    _model = model;
    
    self.topImageView.image = [UIImage imageNamed:model.spotOuterImgurl];
    self.nameLabel.text = model.spotTitle;
    
    NSString *distance = [NSString distanceStrWithDistanceStr:model.spotDistance];
    self.addressLabel.text = model.spotAddress;
    self.distanceLabel.text = distance;
    
    NSDictionary *attr = @{
                           NSFontAttributeName:kText18Font11Height,
                           };
    CGFloat distanceLabelW = [distance calculateWidthStringWithAttr:attr andMaxWidth:100 andMaxHeight:kHeightText18] + 0.1;
    
    CGFloat addressMaxW = self.itemW - kX12Margin * 2 - distanceLabelW - kX12Margin - 1;
    
    CGFloat addressLabelW = [model.spotAddress calculateWidthStringWithAttr:attr andMaxWidth:addressMaxW andMaxHeight:kHeightText18] + 0.1;
    
    CGFloat addressLabelLeftOffset = (self.itemW - addressLabelW - distanceLabelW - kX12Margin - 1) * 0.5;
    [self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(addressLabelLeftOffset);
        make.width.mas_equalTo(addressLabelW);
    }];
    
    [self.distanceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(distanceLabelW);
    }];
    
    
    NSDictionary *tagsAttr = @{
                           NSFontAttributeName : kText16Font10Height,
                           };
    
    CGFloat allWMax = self.itemW - kX12Margin * 2;
    CGFloat tagsViewW = allWMax < ([YYThisMonthCommendViewModel tagsViewWidthWithTagsArray:model.spotTags andAttr:tagsAttr andxMargin:kX12Margin andTextHeight:kHeightText16]) ? allWMax : ([YYThisMonthCommendViewModel tagsViewWidthWithTagsArray:model.spotTags andAttr:tagsAttr andxMargin:kX12Margin andTextHeight:kHeightText16]);
    
    
    CGFloat tagsViewLeftOffset = (self.itemW - tagsViewW) * 0.5;
    [self.tagsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(tagsViewLeftOffset);
        make.right.mas_equalTo(self).mas_offset(-tagsViewLeftOffset);
    }];
    self.tagsView.tagsArray = model.spotTags;
}
@end
