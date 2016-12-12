//
//  YYThisMonthCommendCollectionViewCell.h
//  farm
//
//  Created by wyy on 2016/12/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSightSpotModel;
@interface YYThisMonthCommendCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYSightSpotModel *model;

@property (nonatomic, assign) CGFloat itemW;
@end
