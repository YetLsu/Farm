//
//  YYHomeThisMonthRecommendTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYHomeThisMonthRecommendModel;
@interface YYHomeThisMonthRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) YYHomeThisMonthRecommendModel *model;

+ (instancetype)homeThisMonthRecommendTableViewCellWithTableView:(UITableView *)tableView;
@end
