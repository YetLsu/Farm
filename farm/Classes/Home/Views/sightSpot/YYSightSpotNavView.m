//
//  YYSightSpotNavView.m
//  farm
//
//  Created by wyy on 2016/12/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotNavView.h"

@implementation YYSightSpotNavView
- (instancetype)initWithLeftBtnW:(CGFloat)leftBtnW andRightBtnW:(CGFloat)rightBtnW{
    if (self = [super initWithFrame:CGRectZero]) {
        
        /**
         *  增加导航栏View中的按钮
         */
        CGFloat leftW = leftBtnW + kX12Margin * 2;
        UIButton *leftBtn = [[UIButton alloc] init];
        [self addSubview:leftBtn];
        self.leftBtn = leftBtn;
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        self.leftBtn.titleLabel.textColor = [UIColor whiteColor];
        
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(leftW);
        }];
        
        //增加右边按钮
        CGFloat rightW = rightBtnW + kX12Margin * 2;
        UIButton *rightBtn = [[UIButton alloc] init];
        [self addSubview:rightBtn];
        self.rightBtn = rightBtn;
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(rightW);
        }];

    }
    return self;
}



@end
