//
//  NFPastReviewTableViewCell.m
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFPastReviewTableViewCell.h"
#import "NFReviewModel.h"

@interface NFPastReviewTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;

@end



@implementation NFPastReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NFReviewModel *)model{
    if (_model != model) {
        _model = model;
    }
    [_postImageView sd_setImageWithURL:[NSURL URLWithString:_model.innerImgurl] placeholderImage:nil options:SDWebImageRetryFailed];
    _titleLabel.text = _model.title;
    _abstractLabel.text = _model.discription;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
