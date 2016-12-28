//
//  YYProductDetailTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProductDetailTableViewCell.h"


@interface YYProductDetailTableViewCell ()

@property (nonatomic, weak) UILabel *label;

@end
@implementation YYProductDetailTableViewCell
+ (instancetype)productDetailTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYProductDetailTableViewCell";
    YYProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYProductDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIButton *btn = [[UIButton alloc] init];
        [self.contentView addSubview:btn];
        self.btn = btn;
        CGFloat btnW = 75;
        CGFloat btnH = 25;
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
            make.top.mas_equalTo(self.contentView).mas_offset(kY12Margin);
            make.centerX.mas_equalTo(self.contentView);
        }];
        btn.userInteractionEnabled = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"spot_product_header_icon"] forState:UIControlStateNormal];
        [btn setTitleColor:kGreen34Color forState:UIControlStateNormal];
        btn.titleLabel.font = kText16Font10Height;
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.label = label;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(kX12Margin);
            make.right.mas_equalTo(self.contentView).mas_offset(-kX12Margin);
            make.top.mas_equalTo(self.btn.mas_bottom).mas_offset(kY12Margin);
            make.bottom.mas_equalTo(self.contentView).mas_offset(-kY12Margin);
        }];
        self.label.numberOfLines = 0;
        self.label.textColor = kGray105Color;
    }
    return self;
}

- (void)setContent:(NSString *)content{
    _content = content;
    
    NSMutableAttributedString *contentAttributed = [[NSMutableAttributedString alloc] initWithString:content];
    
    UIFont *contentFont = kText18Font11Height;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attr = @{
                           NSFontAttributeName : contentFont,
                           NSParagraphStyleAttributeName : paragraphStyle,
                           };
    
    [contentAttributed addAttributes:attr range:NSMakeRange(0, content.length)];
    self.label.attributedText = contentAttributed;
    
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
