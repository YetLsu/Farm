//
//  YYHomeNavView.m
//  farm
//
//  Created by wyy on 2016/11/25.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeNavView.h"
#import "WYYSearchBar.h"
#import "NFQRCodeReadViewController.h"

@interface YYHomeNavView (){
    
}

@end

@implementation YYHomeNavView

id _VC;
+ (instancetype)homeNavViewWithTextFieldDelegate:(id<UITextFieldDelegate>)VC{
    _VC = VC;
    YYHomeNavView *navView = [[YYHomeNavView alloc] initWithFrame:CGRectZero];
    
    return  navView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /**
         *  增加导航栏View中的按钮
         */
        UIButton *addressBtn = [[UIButton alloc] init];
        [self addSubview:addressBtn];
        self.addressBtn = addressBtn;
        self.addressBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        self.addressBtn.titleLabel.textColor = [UIColor whiteColor];
        
        [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(75);
        }];
        [addressBtn bk_addEventHandler:^(id sender) {
            YYLog(@"地址按钮被点击");
        } forControlEvents:UIControlEventTouchUpInside];
        
        //增加右边扫一扫图片
        UIButton *richScanBtn = [[UIButton alloc] init];
        [self addSubview:richScanBtn];
        self.richScanBtn = richScanBtn;
        [richScanBtn setImage:[UIImage imageNamed:@"home_richScan"] forState:UIControlStateNormal];
        CGFloat richScanBtnH = 25 + 12 * 2;
        [richScanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(richScanBtnH);
        }];
        [richScanBtn bk_addEventHandler:^(id sender) {
            YYLog(@"扫一扫被点击");
            NFQRCodeReadViewController *qrCodeReaderVc = [[NFQRCodeReadViewController alloc] init];
            if ([self.delegate respondsToSelector:@selector(pushWithViewController:)]) {
                [self.delegate performSelector:@selector(pushWithViewController:) withObject:qrCodeReaderVc];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        //添加搜索框
        WYYSearchBar *searchBar = [WYYSearchBar searchBarWithPlaceholderText:@"搜一搜" andSearchBgImage:[UIImage imageNamed:@"search_home_bg"] andSearchIconImage:[UIImage imageNamed:@"search_home_icon"]];
        searchBar.delegate = _VC;
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        
        CGFloat searchBarWidth = 208 /375.0 * kWidthScreen;
        CGFloat searchBarTop = (64 - 27.5 - 20)/2.0 + 20;
        CGFloat searchBarLeft = (kWidthScreen - searchBarWidth)/2.0;
        
        [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(searchBarWidth);
            make.height.mas_equalTo(27.5);
            make.left.mas_equalTo(searchBarLeft);
            make.top.mas_equalTo(searchBarTop);
            
        }];
        searchBar.height = 27.5;
        searchBar.width = 208 /375.0 * kWidthScreen;
        
    }
    return self;
}

@end
