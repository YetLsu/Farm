//
//  NFPlayCollectionViewCell.m
//  farm
//
//  Created by guest on 17/2/16.
//  Copyright © 2017年 WYY. All rights reserved.
//

#import "NFPlayCollectionViewCell.h"
#import "NFPlayModel.h"
#define kHeightRate 280/474;
@interface NFPlayCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postImageViewConstraint;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@end

@implementation NFPlayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.postImageViewConstraint.constant = (kHeightScreen - 64 - 3 * 30) * kHeightRate;
}

- (void)setModel:(NFPlayModel *)model{
    if (_model != model) {
        _model = model;
    }
    [_postImageView sd_setImageWithURL:[NSURL URLWithString:_model.outerImgurl] placeholderImage:nil options:SDWebImageRetryFailed];
    _locationLabel.text = _model.cityname;
    _abstractLabel.text = _model.abstracts;
    _tempLabel.text = [NSString stringWithFormat:@"%@度",_model.temperature];
    _windLabel.text = [NSString stringWithFormat:@"%@级",_model.wind];
    [_weatherImageView sd_setImageWithURL:[NSURL URLWithString:_model.weather] placeholderImage:nil options:SDWebImageRetryFailed];
}



@end
