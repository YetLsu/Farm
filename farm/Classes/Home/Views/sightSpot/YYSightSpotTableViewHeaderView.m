//
//  YYSightSpotTableViewHeaderView.m
//  farm
//
//  Created by wyy on 2016/12/22.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotTableViewHeaderView.h"

@implementation YYSightSpotTableViewHeaderView
- (instancetype)initWithTitle:(NSString *)title andHeaderViewH:(CGFloat)headerViewH{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = kViewBGColor;
        
        UIButton *headerViewBtn = [[UIButton alloc] init];
        [self addSubview:headerViewBtn];
        [headerViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(kX12Margin);
            make.top.mas_equalTo(self).mas_offset(kY12Margin);
            make.right.mas_equalTo(self).mas_offset(-kX12Margin);
            make.bottom.mas_equalTo(self);
        }];
        headerViewBtn.backgroundColor = [UIColor whiteColor];
        self.headerBtn = headerViewBtn;
        
        UIView *greenLineView = [[UIView alloc] init];
        greenLineView.backgroundColor = kGreen34Color;
        [headerViewBtn addSubview:greenLineView];
        [greenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(headerViewBtn);
            make.bottom.mas_equalTo(headerViewBtn).mas_offset(-0.5);
            make.width.mas_equalTo(4);
        }];
        
        UIView *grayLineView = [[UIView alloc] init];
        grayLineView.backgroundColor = kGrayLine225Color;
        [headerViewBtn addSubview:grayLineView];
        [grayLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(headerViewBtn);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [headerViewBtn addSubview:label];
        label.text = title;
        label.textColor = kBlack56Color;
        label.font = kText22Font14Height;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(greenLineView.mas_right).mas_offset(8);
            make.top.mas_equalTo(headerViewBtn);
            make.bottom.mas_equalTo(grayLineView.mas_top);
            make.width.mas_equalTo(200);
        }];
        
        CGFloat rightImageViewH = 19;
        UIImageView *rightImageView = [[UIImageView alloc] init];
        [headerViewBtn addSubview:rightImageView];
        rightImageView.image = [UIImage imageNamed:@"spot_detail_header_right_icon"];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(headerViewBtn).mas_offset(-kX12Margin);
            make.size.mas_equalTo(CGSizeMake(rightImageViewH, rightImageViewH));
            make.centerY.mas_equalTo(headerViewBtn);
        }];
        self.rightIconImageView = rightImageView;
        self.rightIconImageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
