//
//  YYSightSpotTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSightSpotModel;
@interface YYSightSpotTableViewCell : UITableViewCell

@property (nonatomic, strong) YYSightSpotModel *model;

+ (instancetype)sightSpotTableViewCellWithTableView:(UITableView *)tableView;
@end
