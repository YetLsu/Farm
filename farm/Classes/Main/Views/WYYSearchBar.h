//
//  WYYSearchBar.h
//  weibo
//
//  Created by wyy on 15/10/31.
//  Copyright © 2015年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYYSearchBar : UITextField

@property (nonatomic, weak) UIImageView *leftImageView;

+ (instancetype)searchBarWithPlaceholderText:(NSString *)placeholder andSearchBgImage:(UIImage *)bgImage andSearchIconImage:(UIImage *)iconImage;

- (void)setLeftImageViewWithImage:(UIImage *)leftImage;

- (void)setLabelTextColor:(UIColor *)textColor;
@end
