//
//  NFInnerHeader.m
//  farm
//
//  Created by guest on 17/2/17.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFInnerHeader.h"
#import "NFHeadViewModel.h"
@interface NFInnerHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *abstrictTextView;

@end

@implementation NFInnerHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)setModel:(NFHeadViewModel *)model{
    if (_model != model) {
        _model = model;
    }
    [_postImageView sd_setImageWithURL:[NSURL URLWithString:_model.innerImgurl] placeholderImage:nil options:SDWebImageRetryFailed];
    
    _titleLabel.text = _model.title;
    _locationLabel.text = [NSString stringWithFormat:@"%@|共%@站",_model.address,_model.spotnum];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@／人次",_model.expense];
    _abstrictTextView.text = _model.discription;
}



@end
