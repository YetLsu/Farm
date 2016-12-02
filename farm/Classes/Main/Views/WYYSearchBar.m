//
//  WYYSearchBar.m
//  weibo
//
//  Created by wyy on 15/10/31.
//  Copyright © 2015年 wyy. All rights reserved.
//

#import "WYYSearchBar.h"

@interface WYYSearchBar ()
@property (nonatomic, weak) UILabel *label;

@end

NSString *_placeholder;
UIImage *_bgImage;
UIImage *_iconImage;

@implementation WYYSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:16];
        self.placeholder = _placeholder;
        self.textColor = [UIColor whiteColor];
        
        UILabel *label = [self valueForKey:@"placeholderLabel"];
        self.label = label;
        self.label.textColor = [UIColor whiteColor];
        self.background = _bgImage;
        
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = _iconImage;
        
        searchIcon.width = 40;
        searchIcon.height = 40;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}
- (void)setLeftImageViewWithImage:(UIImage *)leftImage{
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = leftImage;
    
    searchIcon.width = 40;
    searchIcon.height = 40;
    searchIcon.contentMode = UIViewContentModeCenter;
    self.leftView = searchIcon;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setLabelTextColor:(UIColor *)textColor{
    UILabel *label = [self valueForKey:@"placeholderLabel"];
    self.label = label;
    self.label.textColor = textColor;

}
+ (instancetype)searchBarWithPlaceholderText:(NSString *)placeholder andSearchBgImage:(UIImage *)bgImage andSearchIconImage:(UIImage *)iconImage{
    
    _iconImage = iconImage;
    _bgImage = bgImage;
    _placeholder = placeholder;
    return [[self alloc] init];
}



@end
