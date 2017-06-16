//
//  NFCommentCell.m
//  farm
//
//  Created by guest on 17/3/2.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFCommentCell.h"
#import "NFCommentModel.h"
@interface NFCommentCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comentHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation NFCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NFCommentModel *)model{
    if (_model != model) {
        _model = model;
    }
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl] placeholderImage:nil options:SDWebImageRetryFailed];
    _userLabel.text = _model.username;
    _timeLabel.text = _model.coTime;
    _commentLabel.text = _model.coDetails;
    _comentHeightConstraint.constant = _model.coDetailsHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
