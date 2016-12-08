//
//  YYHomeViewModel.h
//  farm
//
//  Created by wyy on 2016/11/26.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYHomeCollectionViewCellModel, YYHomeThisMonthRecommendModel, YYHomeDiscoverModel, YYHomeTravelNotesModel;
@interface YYHomeViewModel : NSObject


- (instancetype)initCollectionViewModelWithMarkModelsArray:(NSArray *)modelsArray;
/**
    获取景点分类的数据
 */
- (void)getMarksArrayWithParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray<YYHomeCollectionViewCellModel *> *modelsArray,NSError *error)) callback;

/**
    获取当月推荐的内容
 */
- (void)getThisMonthRecommendWithParameters:(NSDictionary *)parameters andCallback:(void(^)(YYHomeThisMonthRecommendModel *model, NSError *error))callback;
/**
    获取主题游的内容
 */
- (void)getPlayModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray<YYHomeCollectionViewCellModel *> *modelsArray,NSError *error)) callback;

/**
 获取发现的内容
 */
- (void)getDiscoverModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray<YYHomeDiscoverModel *> *modelsArray,NSError *error)) callback;
/**
 获取游记的内容
 */
- (void)getTravelNotesModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray<YYHomeTravelNotesModel *> *modelsArray,NSError *error)) callback;
@property (nonatomic, copy) void (^YYCollectionViewCellClickBlock)();

@end
