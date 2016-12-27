//
//  YYSightSpotNearbyTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/24.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSightSpotModel;
@interface YYSightSpotNearbyTableViewCell : UITableViewCell

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray <YYSightSpotModel *>*modelsArray;

@property (nonatomic, copy) void (^YYCollectionViewCellBlock) (YYSightSpotModel *model);

+ (instancetype)sightSpotNearbyTableViewCellWithTableView:(UITableView *)tableView;

@end

@interface YYSightSpotNearbyTableViewCellCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYSightSpotModel *model;

@end
