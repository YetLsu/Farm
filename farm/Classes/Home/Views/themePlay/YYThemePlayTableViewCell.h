//
//  YYThemePlayTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYThemePlayModel;

@interface YYThemePlayTableViewCell : UITableViewCell

+ (instancetype)themePlayTableViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) YYThemePlayModel *model;

@end
