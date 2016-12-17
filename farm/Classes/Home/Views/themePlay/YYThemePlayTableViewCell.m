//
//  YYThemePlayTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThemePlayTableViewCell.h"

#import "YYThemePlayModel.h"

@interface YYThemePlayTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *themePlayImageView;
@end

@implementation YYThemePlayTableViewCell
+ (instancetype)themePlayTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYThemePlayTableViewCell";
    YYThemePlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYThemePlayTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kViewBGColor;
    
    [self.themePlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
        make.top.mas_equalTo(self).mas_offset(kY12Margin);
        make.bottom.mas_equalTo(self);
    }];
}
- (void)setModel:(YYThemePlayModel *)model{
    _model = model;
    [self.themePlayImageView sd_setImageWithURL:[NSURL URLWithString:model.listImgUrl]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
