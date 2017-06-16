//
//  YYHomeNavView.h
//  farm
//
//  Created by wyy on 2016/11/25.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WYYSearchBar.h"

@protocol YYHomeNavViewDelegate <NSObject>

- (void)pushWithViewController:(UIViewController *)viewController;

@end

@interface YYHomeNavView : UIView

@property (nonatomic, weak) UIButton *addressBtn;

@property (nonatomic, weak) WYYSearchBar *searchBar;

@property (nonatomic, weak) UIButton *richScanBtn;

@property (nonatomic, assign) id<YYHomeNavViewDelegate> delegate;

+ (instancetype)homeNavViewWithTextFieldDelegate:(id<UITextFieldDelegate>)VC;
@end
