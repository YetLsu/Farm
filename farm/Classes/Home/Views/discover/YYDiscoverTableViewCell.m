//
//  YYDiscoverTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverTableViewCell.h"
#import "YYHomeDiscoverModel.h"

@interface YYDiscoverTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *discoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, assign) CGFloat bgViewNoContentLabelH;
@end

@implementation YYDiscoverTableViewCell
+ (instancetype)discoverTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYDiscoverTableViewCell";
    YYDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYDiscoverTableViewCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self removeConstraints:[self constraints]];
    
    self.contentView.backgroundColor = kViewBGColor;
    
    [self setSubViewsConstraints];
    [self setViews];
}
- (void)setSubViewsConstraints{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
        make.top.mas_equalTo(self);
    }];
    
    CGFloat discoverImageViewLeftOffset = kX12Margin;
    CGFloat discoverImageViewW = kWidthScreen - discoverImageViewLeftOffset * 2;
    CGFloat scale = discoverImageViewW/(375.0 - 12 * 2);
    CGFloat discoverImageViewH = 205 * scale;
    [self.discoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(discoverImageViewW, discoverImageViewH));
    }];
    
    CGFloat discoverTagLabelW = 55;
    CGFloat discoverTagLabelH = 20;
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(discoverTagLabelW, discoverTagLabelH));
        make.left.top.mas_equalTo(self.discoverImageView);
    }];
    
    CGFloat discoverTitleLabelTop = kY12Margin;
    CGFloat discoverTitleLabelH = kHeightText22;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discoverImageView.mas_bottom).mas_offset(discoverTitleLabelTop);
        make.left.mas_equalTo(self.bgView).mas_offset(kX12Margin);
        make.right.mas_equalTo(self.bgView).mas_offset(-kX12Margin);
        make.height.mas_equalTo(discoverTitleLabelH);
    }];
    
    CGFloat discoverContentLabelTop = 10 - 2.5;
    CGFloat discoverContentLabelBootom = 10;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(discoverContentLabelTop);
        make.left.right.mas_equalTo(self.titleLabel);
    }];
    
    CGFloat timeIconImageViewH = 10;
    CGFloat timeIconImageViewW = 10;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).mas_offset(-kX12Margin);
        make.bottom.mas_equalTo(self.bgView).mas_offset(-kY12Margin);
        make.size.mas_equalTo(CGSizeMake(80, timeIconImageViewH));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel);
        make.right.mas_equalTo(self.timeLabel.mas_left).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(timeIconImageViewW, timeIconImageViewH));
    }];
    
    self.bgViewNoContentLabelH = discoverImageViewH + discoverTitleLabelTop + discoverTitleLabelH + discoverContentLabelTop + discoverContentLabelBootom + timeIconImageViewH + kY12Margin;
    
}
- (void)setViews{
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.tagLabel.textColor = [UIColor whiteColor];
    self.tagLabel.font = kText14Font9Height;
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.textColor = kBlack56Color;
    self.titleLabel.font = kText22Font14Height;
    
    self.contentLabel.textColor = kGray105Color;
    self.contentLabel.font = kText18Font11Height;
    self.contentLabel.numberOfLines = 0;
    
    self.timeLabel.textColor = kGray188Color;
    self.timeLabel.font = kText14Font9Height;
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    
    
}

- (void)setModel:(YYHomeDiscoverModel *)model{
    _model = model;
    [self.discoverImageView sd_setImageWithURL:[NSURL URLWithString:model.outerImgurl]];
    
    self.tagLabel.text = model.tag;
    
    self.titleLabel.text = model.title;
    if ([model.tag isEqualToString:@""] || !model.tag) {
        self.tagLabel.backgroundColor = [UIColor clearColor];
    }
    else{
        self.tagLabel.backgroundColor = kRGBAColor(149, 132, 149, 1);
    }
    
    
    self.iconImageView.image = [UIImage imageNamed:@"home_time_icon"];
    
    CGFloat maxContentLabelW = kWidthScreen - kX12Margin * 4;
    CGFloat maxContentLabelH = 66;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:model.content];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attr = @{
                           NSFontAttributeName : kText16Font10Height,
                           NSParagraphStyleAttributeName : paragraphStyle
                           };
    [attributedStr addAttributes:attr range:NSMakeRange(0, attributedStr.length)];
    
    CGFloat contentLabelH = [model.content calculateHeightStringWithAttr:attr andMaxWidth:maxContentLabelW andMaxHeight:maxContentLabelH] + 0.1;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentLabelH);
    }];
    
    CGFloat bgViewH = contentLabelH + self.bgViewNoContentLabelH;
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bgViewH);
    }];
    self.contentLabel.attributedText = attributedStr;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    
    self.timeLabel.text = [formatter stringFromDate:model.uploadingTime];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
