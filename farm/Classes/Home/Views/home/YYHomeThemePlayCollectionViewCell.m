//
//  YYHomeThemePlayCollectionViewCell.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeThemePlayCollectionViewCell.h"

#import "YYThemePlayModel.h"

@interface YYHomeThemePlayCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@end
@implementation YYHomeThemePlayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bottomLabel.textColor = kBlack56Color;
    self.bottomLabel.font = [UIFont systemFontOfSize:11.0];
    
    
}
- (void)setModel:(YYThemePlayModel *)model{
    _model = model;
//    YYLog(@"%@", model.homeImgUrl);
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.homeImgUrl]];
    
    self.bottomLabel.text = model.themePlayName;
}

@end
