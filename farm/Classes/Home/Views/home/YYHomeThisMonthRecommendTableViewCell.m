//
//  YYHomeThisMonthRecommendTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeThisMonthRecommendTableViewCell.h"
#import "YYHomeThisMonthRecommendModel.h"

@interface YYHomeThisMonthRecommendTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityMarkLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityContentLabel;

@property (weak, nonatomic) IBOutlet UIButton *seeMoreBtn;

@property (nonatomic, assign) CGFloat contentLabelMaxW;

@property (nonatomic, assign) CGFloat contentLabelMaxH;
@end

@implementation YYHomeThisMonthRecommendTableViewCell
+ (instancetype)homeThisMonthRecommendTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYHomeThisMonthRecommendTableViewCell";
    YYHomeThisMonthRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeThisMonthRecommendTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
    [self addConstraintsOnSubViews];
    
    [self setViews];
    
    
    
}
- (void)addConstraintsOnSubViews{
    CGFloat bgViewH = 200;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
        make.height.mas_equalTo(bgViewH);
    }];
    
    CGFloat leftImageViewW = 160;
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.bgView);
        make.width.mas_equalTo(leftImageViewW);
    }];
    
    CGFloat cityNameLabelH = 20;
    CGFloat cityNameLabelTop = 20;
    [self.cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(kX12Margin);
        make.height.mas_equalTo(cityNameLabelH);
        make.top.mas_equalTo(self.bgView).mas_offset(cityNameLabelTop);
        make.right.mas_equalTo(self.bgView).mas_offset(-kX12Margin);
    }];
    
    CGFloat cityMarkLabelH = 11;
    [self.cityMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(cityMarkLabelH);
        make.left.right.mas_equalTo(self.cityNameLabel);
        make.top.mas_equalTo(self.cityNameLabel.mas_bottom).mas_offset(10);
    }];
    
    [self.cityContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.cityMarkLabel);
        make.top.mas_equalTo(self.cityMarkLabel.mas_bottom).mas_offset(10);
    }];
    
    CGFloat seeMoreBtnBottom = -15;
    CGFloat seeMoreBtnLeft = 15;
    CGFloat seeMoreBtnW = 71;
    CGFloat seeMoreBtnH = 26;
    [self.seeMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(seeMoreBtnLeft);
        make.bottom.mas_equalTo(self.bgView).mas_offset(seeMoreBtnBottom);
        make.size.mas_equalTo(CGSizeMake(seeMoreBtnW, seeMoreBtnH));
    }];
    
    self.contentLabelMaxW = kWidthScreen - kX12Margin * 4 -leftImageViewW;
    self.contentLabelMaxH = bgViewH - cityNameLabelTop - cityNameLabelH - 10 - cityMarkLabelH - 10 - 10 - seeMoreBtnH + seeMoreBtnBottom;
}
- (void)setViews{
    self.bgView.layer.cornerRadius = 5.0;
    self.bgView.layer.borderColor = [kGrayLine225Color CGColor];
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.masksToBounds = YES;
    
    self.cityNameLabel.textColor = kGreen34Color;
    
    self.cityMarkLabel.textColor = kGreen34Color;
    self.cityMarkLabel.adjustsFontSizeToFitWidth = YES;
    
    self.cityContentLabel.textColor = kGray105Color;
    self.cityContentLabel.numberOfLines = 0;
    
    
    [self.seeMoreBtn setImage:[UIImage imageNamed:@"home_seeMoreBtn"] forState:UIControlStateNormal];
    self.seeMoreBtn.tintColor = kGreen34Color;
    self.seeMoreBtn.userInteractionEnabled = NO;

}
- (void)setModel:(YYHomeThisMonthRecommendModel *)model{
    _model = model;
    self.leftImageView.image = [UIImage imageNamed:model.imgurl];
    
    self.cityNameLabel.text = model.cityName;
    
    self.cityMarkLabel.text = model.cityMark;
    
    if (model.cityContent) {
        NSMutableAttributedString *attributesStr = [[NSMutableAttributedString alloc] initWithString:model.cityContent];
        
        NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 8.0;
        
        NSDictionary *attr = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:10.0],
                               NSParagraphStyleAttributeName: paragraphStyle
                               };
        
        [attributesStr addAttributes:attr range:NSMakeRange(0, model.cityContent.length)];
        
        
        CGFloat contentLabelH = [model.cityContent calculateHeightStringWithAttr:attr andMaxWidth:self.contentLabelMaxH andMaxHeight:self.contentLabelMaxH];
        [self.cityContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentLabelH);
        }];
        self.cityContentLabel.attributedText = attributesStr;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
