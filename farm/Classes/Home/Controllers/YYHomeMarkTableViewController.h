//
//  YYHomeMarkTableViewController.h
//  farm
//
//  Created by wyy on 2016/12/3.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeCollectionViewCellModel,YYThemePlayModel;
@interface YYHomeMarkTableViewController : YYBaseTableViewController

- (instancetype)initWithMarkCollectionModel:(YYHomeCollectionViewCellModel *)markModel;
#warning TODO 增加了初始化方法
- (instancetype)initWithCollectionViewCellModel:(YYThemePlayModel *)themePlayModel;
@end
