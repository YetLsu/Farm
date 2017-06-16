//
//  YYHomePlayCollectionViewTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeCollectionViewCellModel,YYThemePlayModel;

@protocol YYHomePlayCollectionViewTableViewCellDelegate <NSObject>

- (void)pushWithModel:(YYThemePlayModel *)model;

@end


@interface YYHomePlayCollectionViewTableViewCell : UITableViewCell

@property (nonatomic, assign) id<YYHomePlayCollectionViewTableViewCellDelegate> delegate;

- (instancetype)initWithModelsArray:(NSArray <YYHomeCollectionViewCellModel *>*)modelsArray;



@end
