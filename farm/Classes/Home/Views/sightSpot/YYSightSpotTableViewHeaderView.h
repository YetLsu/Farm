//
//  YYSightSpotTableViewHeaderView.h
//  farm
//
//  Created by wyy on 2016/12/22.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSightSpotTableViewHeaderView : UIView

@property (nonatomic, weak) UIImageView *rightIconImageView;

@property (nonatomic, weak) UIButton *headerBtn;

- (instancetype)initWithTitle:(NSString *)title andHeaderViewH:(CGFloat)headerViewH;

@end
 
