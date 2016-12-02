//
//  YYHomePlayCollectionViewCell.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomePlayCollectionViewCell.h"

#import "YYHomeCollectionViewCellModel.h"

@interface YYHomePlayCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@end
@implementation YYHomePlayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bottomLabel.textColor = kBlack56Color;
    self.bottomLabel.font = [UIFont systemFontOfSize:11.0];
    
    
}
- (void)setModel:(YYHomeCollectionViewCellModel *)model{
    _model = model;
    
    self.topImageView.image = [UIImage imageNamed:model.markImgUrl];
    
    self.bottomLabel.text = model.markName;
}

@end
