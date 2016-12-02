//
//  YYHomePlayCollectionViewTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeCollectionViewCellModel;
@interface YYHomePlayCollectionViewTableViewCell : UITableViewCell

- (instancetype)initWithModelsArray:(NSArray <YYHomeCollectionViewCellModel *>*)modelsArray;
@end
