//
//  YYHomeDiscoverTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeDiscoverModel;

@interface YYHomeDiscoverTableViewCell : UITableViewCell

@property (nonatomic, strong) YYHomeDiscoverModel *model;

+ (instancetype)homeDiscoverTableViewCellWithTableView:(UITableView *)tableView;

@end
