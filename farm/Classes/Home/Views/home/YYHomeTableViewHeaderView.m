//
//  YYHomeTableViewHeaderView.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTableViewHeaderView.h"

@interface YYHomeTableViewHeaderView ()
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *detailLabel;

@property (nonatomic, weak) UIImageView *arrowImageView;
@end

@implementation YYHomeTableViewHeaderView

+ (instancetype)homeTableViewHeaderView{
    return [[YYHomeTableViewHeaderView alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
        
        [btn bk_addEventHandler:^(id sender) {
            if (self.YYHeaderViewClickBlock) {
                self.YYHeaderViewClickBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat arrowImageViewW = 9;
        CGFloat arrowImageViewH = 20;
        CGFloat arrowImageViewY = 16;
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        [btn addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
        self.arrowImageView.image = [UIImage imageNamed:@"home_tableViewHeader_arrow"];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(arrowImageViewW, arrowImageViewH));
            make.top.mas_equalTo(self).mas_offset(arrowImageViewY);
            make.right.mas_equalTo(self).mas_offset(-kX12Margin);
        }];
        self.arrowImageView.hidden = YES;
        
        CGFloat titleLabelRight = arrowImageViewW + kX12Margin;
        CGFloat titleLabelH = 15;
        UILabel *titleLabel = [[UILabel alloc] init];
        [btn addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabelRight);
            make.right.mas_equalTo(-titleLabelRight);
            make.top.mas_equalTo(kY12Margin);
            make.height.mas_equalTo(titleLabelH);
        }];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.titleLabel.textColor = kBlack56Color;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        CGFloat detailLabelH = 10.0;
        UILabel *detailLabel = [[UILabel alloc] init];
        [btn addSubview:detailLabel];
        self.detailLabel = detailLabel;
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(4.5);
            make.left.right.mas_equalTo(self.titleLabel);
            make.height.mas_equalTo(detailLabelH);
        }];
        self.detailLabel.font = [UIFont systemFontOfSize:10.0];
        self.detailLabel.textColor = kGray105Color;
        self.detailLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}
- (void)setTitleContent:(NSString *)titleContent{
    _titleContent = titleContent;
    self.titleLabel.text = titleContent;
}
- (void)setDetailContent:(NSString *)detailContent{
    _detailContent = detailContent;
    self.detailLabel.text = detailContent;
}
- (void)setArrowHidden:(BOOL)arrowHidden{
    _arrowHidden = arrowHidden;
    self.arrowImageView.hidden = arrowHidden;
}
@end
