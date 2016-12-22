//
//  YYSightSpotHeaderView.h
//  farm
//
//  Created by wyy on 2016/12/21.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYSightSpotModel;
@interface YYSightSpotHeaderView : UIView

@property (nonatomic, weak) UIImageView *headerImageView;

@property (nonatomic, weak) UIButton *collectBtn;

@property (nonatomic, weak) UICollectionView *headerBottomCollectionView;

@property (nonatomic, strong) YYSightSpotModel *model;

- (instancetype)initWithHeight:(CGFloat)headerImageViewH andBottomViewH:(CGFloat)bottomViewH;
@end

@interface YYSightSpotHeaderBottomCollectionViewCellModel : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat imageW;
@end

@interface YYSightSpotHeaderBottomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYSightSpotHeaderBottomCollectionViewCellModel *model;



@end
