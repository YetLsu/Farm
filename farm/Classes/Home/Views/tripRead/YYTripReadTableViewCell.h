//
//  YYTripReadTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYTripReadModel;

@interface YYTripReadTableViewCell : UITableViewCell

@property (nonatomic, strong)YYTripReadModel *model;

+ (instancetype)tripReadTableViewCellWithTableView:(UITableView *)tableView;
@end
