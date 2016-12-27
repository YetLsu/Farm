//
//  YYSightSpotMapView.h
//  farm
//
//  Created by wyy on 2016/12/26.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSightSpotModel;
@interface YYSightSpotMapTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^YYMapBlock) ();

- (instancetype)initWithSpotModel:(YYSightSpotModel *)model;

@end
