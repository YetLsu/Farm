//
//  YYSightSpotProductTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYSightSpotProductModel;
@interface YYSightSpotProductTableViewCell : UITableViewCell

@property (nonatomic,strong)YYSightSpotProductModel *model;

+ (instancetype)sightSpotProductTableViewCellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
