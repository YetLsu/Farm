//
//  YYSightSpotRecommendTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSightSpotModel;
@interface YYSightSpotRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) YYSightSpotModel *model;

+ (instancetype)sightSpotRecommendTableViewCellWithTableView:(UITableView *)tableView;

@end
