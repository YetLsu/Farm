//
//  YYHomeMarkCollectionViewTableViewCell.h
//  farm
//
//  Created by wyy on 2016/11/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYHomeCollectionViewCellModel;
@interface YYHomeMarkCollectionViewTableViewCell : UITableViewCell

- (instancetype)initWithModelsArray:(NSArray *)modelsArray;

@property (nonatomic, copy) void (^YYCollectionViewCellClickBlock)(YYHomeCollectionViewCellModel *model);
@end
