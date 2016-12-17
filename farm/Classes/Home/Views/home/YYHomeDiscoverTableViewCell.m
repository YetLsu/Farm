//
//  YYHomeDiscoverTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeDiscoverTableViewCell.h"

#import "YYHomeDiscoverModel.h"


@interface YYHomeDiscoverTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *discoverTagLabel;

@property (weak, nonatomic) IBOutlet UIImageView *discoverImageView;

@property (weak, nonatomic) IBOutlet UILabel *discoverTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *discoverContentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *timeIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (assign, nonatomic) CGFloat contentLabelMaxW;

@property (assign, nonatomic) CGFloat contentLabelMaxH;

@end

@implementation YYHomeDiscoverTableViewCell
+ (instancetype)homeDiscoverTableViewCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"YYHomeDiscoverTableViewCell";
    YYHomeDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeDiscoverTableViewCell" owner:nil options:nil] lastObject];
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
    
    CGFloat imageViewW = 135;
    CGFloat imageViewH = 150;
    [self.discoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageViewW, imageViewH));
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.top.mas_equalTo(self);
    }];
    
    CGFloat discoverTagLabelW = 55;
    CGFloat discoverTagLabelH = 20;
    [self.discoverTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(discoverTagLabelW, discoverTagLabelH));
        make.left.top.mas_equalTo(self.discoverImageView);
    }];
    
    CGFloat discoverTitleLabelTop = 5;
    CGFloat discoverTitleLabelH = 13;
    [self.discoverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(discoverTitleLabelTop);
        make.left.mas_equalTo(self.discoverImageView.mas_right).mas_offset(kX12Margin);
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
        make.height.mas_equalTo(discoverTitleLabelH);
    }];
    
    CGFloat discoverContentLabelTop = 16 - 2.5;
    [self.discoverContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.discoverTitleLabel.mas_bottom).mas_offset(discoverContentLabelTop);
        make.left.right.mas_equalTo(self.discoverTitleLabel);
    }];
    
    CGFloat timeIconImageViewH = 10;
    CGFloat timeIconImageViewW = 10;
    CGFloat timeIconImageViewBottom = -10;
    [self.timeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.discoverTitleLabel);
        make.size.mas_equalTo(CGSizeMake(timeIconImageViewW, timeIconImageViewH));
        make.bottom.mas_equalTo(self.discoverImageView).mas_offset(timeIconImageViewBottom);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeIconImageView.mas_right).mas_offset(4);
        make.right.mas_equalTo(self.discoverTitleLabel);
        make.bottom.top.mas_equalTo(self.timeIconImageView);
    }];
    
    self.contentLabelMaxW = kWidthScreen - kX12Margin - imageViewW - kX12Margin;
    self.contentLabelMaxH = imageViewH - discoverTitleLabelTop - discoverTitleLabelH - discoverContentLabelTop - kY12Margin - timeIconImageViewH + timeIconImageViewBottom;
}

- (void)setViews{
    
    self.discoverTagLabel.textColor = [UIColor whiteColor];
    self.discoverTagLabel.font = kText14Font9Height;
    self.discoverTagLabel.textAlignment = NSTextAlignmentCenter;
    
    self.discoverTitleLabel.textColor = kBlack56Color;
    self.discoverTitleLabel.font = kText20Font12Height;
    
    self.discoverContentLabel.textColor = kGray105Color;
    self.discoverContentLabel.font = kText16Font10Height;
    self.discoverContentLabel.numberOfLines = 0;
    
    self.timeLabel.textColor = kGray188Color;
    self.timeLabel.font = kText14Font9Height;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YYHomeDiscoverModel *)model{
    _model = model;
    
    [self.discoverImageView sd_setImageWithURL:[NSURL URLWithString:model.outerImgurl]];
   
    self.discoverTagLabel.text = model.tag;
    
    self.discoverTitleLabel.text = model.title;
    
    if (model.content) {
        if ([model.tag isEqualToString:@""] || !model.tag) {
            self.discoverTagLabel.backgroundColor = [UIColor clearColor];
        }
        else{
           self.discoverTagLabel.backgroundColor = kRGBAColor(149, 132, 149, 1);
        }
        
        
        self.timeIconImageView.image = [UIImage imageNamed:@"home_time_icon"];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:model.content];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 8.0 - 2.5;
        NSDictionary *attr = @{
                               NSFontAttributeName : kText16Font10Height,
                               NSParagraphStyleAttributeName : paragraphStyle
                               };
        [attributedStr addAttributes:attr range:NSMakeRange(0, attributedStr.length)];
        
        CGFloat contentLabelH = [model.content calculateHeightStringWithAttr:attr andMaxWidth:self.contentLabelMaxW andMaxHeight:self.contentLabelMaxH] + 0.1;
        [self.discoverContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentLabelH);
        }];
        
        self.discoverContentLabel.attributedText = attributedStr;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    
    self.timeLabel.text = [formatter stringFromDate:model.uploadingTime];
    
    
}
@end
