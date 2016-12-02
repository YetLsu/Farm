//
//  YYHomeTableViewHeaderView.h
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHomeTableViewHeaderView : UIView
+ (instancetype)homeTableViewHeaderView;

@property (nonatomic, copy) NSString *titleContent;

@property (nonatomic, copy) NSString *detailContent;

@property (nonatomic, assign) BOOL arrowHidden;

@property (nonatomic, copy) void (^YYHeaderViewClickBlock)();
@end
