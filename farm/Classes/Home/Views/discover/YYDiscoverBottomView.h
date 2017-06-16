//
//  YYDiscoverBottomView.h
//  farm
//
//  Created by wyy on 2016/12/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDiscoverBottomView : UIView

@property (nonatomic, copy) NSString *commentNumStr;

@property (nonatomic, copy) NSString *praiseNumStr;

@property (nonatomic, strong) UIColor *centerLineViewColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIImage *commentImage;

@property (nonatomic, strong) UIImage *praiseImage;

@property (nonatomic, copy) void (^YYBtnClick) (NSInteger tag);


@end
