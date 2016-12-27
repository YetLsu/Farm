//
//  YYSpotDetailViewModel.h
//  farm
//
//  Created by wyy on 2016/12/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYBaseViewModel.h"

@class YYSightSpotModel,YYSightSpotHeaderBottomCollectionViewCellModel, YYSightSpotTableViewHeaderView, YYSightSpotProductModel;

@interface YYSpotDetailViewModel : YYBaseViewModel<UIWebViewDelegate>

//tableViewHeaderView上半部分高度
@property (nonatomic, assign) CGFloat tableViewHeaderTopViewH;
//tableViewHeaderView下半部分高度
@property (nonatomic, assign) CGFloat tableViewHeaderBottomViewH;

- (instancetype)initWithModel:(YYSightSpotModel *)model;

@property (nonatomic, copy) void (^YYWebViewFinshedBlock)(CGFloat cellH);

//获取tableViewHeaderView中的模型
- (YYSightSpotHeaderBottomCollectionViewCellModel *)getHeaderBottomCollectionViewCellModelWithIndexPath:(NSIndexPath *)indexPath;
//组头的View
- (YYSightSpotTableViewHeaderView *)getTableViewHeaderViewWithSection:(NSInteger)section;

//获取农副产品列表
- (void)getProductModelsArrayWithSpotID:(NSString *)spotID andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback;
//获取农副产品的模型
- (YYSightSpotProductModel *)getProductModelWithIndexPath:(NSIndexPath *)indexPath;
//获取周边推荐
- (void)getNearbyModelsArrayWithCallback:(void (^)(NSArray *modelsArray, NSError *error)) callback;
//根据第几组计算需要滚动的距离
- (CGFloat)getScrollContentOffsetYWithSection:(NSInteger)section;
@end
