//
//  YYProductDetailBottomView.m
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProductDetailBottomView.h"

@interface YYProductDetailBottomView ()

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UIButton *addBuyBtn;

@property (nonatomic, weak) UIButton *buyBtn;
@end

@implementation YYProductDetailBottomView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        self.lineView = lineView;
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        self.lineView.backgroundColor = kGrayLine225Color;
        
        CGFloat btnW = 125;
        CGFloat btnH = 30;
        CGFloat margin = (kWidthScreen - btnW * 2)/4.0;
        
        UIButton *addBuyBtn = [[UIButton alloc] init];
        [self addSubview:addBuyBtn];
        self.addBuyBtn = addBuyBtn;
        [self.addBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(margin);
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        }];
        addBuyBtn.backgroundColor = kRGBAColor(247, 100, 0, 1);
        addBuyBtn.layer.cornerRadius = 3;
        addBuyBtn.layer.masksToBounds = YES;
        [addBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBuyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        addBuyBtn.titleLabel.font = kText20Font12Height;

        UIButton *buyBtn = [[UIButton alloc] init];
        [self addSubview:buyBtn];
        self.buyBtn = buyBtn;
        [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-margin);
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        }];
        buyBtn.backgroundColor = kGreen34Color;
        buyBtn.layer.cornerRadius = 3;
        buyBtn.layer.masksToBounds = YES;
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        buyBtn.titleLabel.font = kText20Font12Height;

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
