//
//  YYDiscoverTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeDiscoverModel;
@interface YYDiscoverTableViewCell : UITableViewCell

@property (nonatomic, strong) YYHomeDiscoverModel *model;

+ (instancetype)discoverTableViewCellWithTableView:(UITableView *)tableView;
@end
