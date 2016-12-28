//
//  YYProductTableViewHeaderView.h
//  farm
//
//  Created by wyy on 2016/12/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSightSpotProductModel;

@interface YYProductTableViewHeaderView : UIView

- (instancetype)initWithTopImageViewH:(CGFloat)topImageViewH andFrame:(CGRect)viewFrame;


- (void)setModel:(YYSightSpotProductModel *)model andCallback:(void (^)(CGFloat allHeight))callback;
@end
