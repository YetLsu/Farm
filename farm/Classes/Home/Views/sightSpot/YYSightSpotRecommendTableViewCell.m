//
//  YYSightSpotRecommendTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotRecommendTableViewCell.h"
#import "YYSightSpotModel.h"

@interface YYSightSpotRecommendTableViewCell ()

@property (nonatomic, weak) UILabel *recommendLabel;

@end

@implementation YYSightSpotRecommendTableViewCell
+ (instancetype)sightSpotRecommendTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSightSpotRecommendTableViewCell";
    
    YYSightSpotRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYSightSpotRecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = kViewBGColor;
        
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(kX12Margin);
            make.right.mas_equalTo(self.contentView).mas_offset(-kX12Margin);
            make.top.bottom.mas_equalTo(self.contentView);
        }];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [bgView addSubview:label];
        self.recommendLabel = label;
        
        [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bgView).mas_offset(kX12Margin);
            make.right.mas_equalTo(bgView).mas_offset(-kX12Margin);
            make.top.mas_equalTo(bgView).mas_offset(kY12Margin);
            make.bottom.mas_equalTo(bgView).mas_offset(-kY12Margin);
        }];
        
        self.recommendLabel.font = kText18Font11Height;
        self.recommendLabel.textColor = kGray105Color;
        self.recommendLabel.numberOfLines = 0;
        
    }
    
    return self;
}

- (void)setModel:(YYSightSpotModel *)model{
    _model = model;
    
    if (model.spotRecommendResult) {
        NSMutableAttributedString *recommend = [[NSMutableAttributedString alloc] initWithString:model.spotRecommendResult];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 6;
        [recommend addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, recommend.length)];
        
        self.recommendLabel.attributedText = recommend;
    }
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
