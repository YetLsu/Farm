//
//  YYSightSpotNavView.h
//  farm
//
//  Created by wyy on 2016/12/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSightSpotNavView : UIView

- (instancetype)initWithLeftBtnW:(CGFloat)leftBtnW andRightBtnW:(CGFloat)rightBtnW;
@property (nonatomic, weak) UIButton *leftBtn;

@property (nonatomic, weak) UIButton *rightBtn;
@end
