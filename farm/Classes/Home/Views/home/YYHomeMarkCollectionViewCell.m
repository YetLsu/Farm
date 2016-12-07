//
//  YYHomeMarkCollectionViewCell.m
//  farm
//
//  Created by wyy on 2016/11/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeMarkCollectionViewCell.h"
#import "YYHomeCollectionViewCellModel.h"

@interface YYHomeMarkCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;

@property (weak, nonatomic) IBOutlet UILabel *markTitleLabel;
@end

@implementation YYHomeMarkCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.markImageView.layer.cornerRadius = 5;
    self.markImageView.layer.masksToBounds = YES;
    
    self.markTitleLabel.textColor = kBlack56Color;
}
- (void)setModel:(YYHomeCollectionViewCellModel *)model{
    _model = model;
    
    self.markImageView.image = [UIImage imageNamed:model.markImgUrl];
    
    self.markTitleLabel.text = model.markName;
}
@end