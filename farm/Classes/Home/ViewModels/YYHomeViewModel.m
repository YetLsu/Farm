//
//  YYHomeViewModel.m
//  farm
//
//  Created by wyy on 2016/11/26.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeViewModel.h"


#import "YYHomeCollectionViewCellModel.h"
#import "YYHomeThisMonthRecommendModel.h"
#import "YYHomeDiscoverModel.h"
#import "YYHomeTravelNotesModel.h"
#import "YYThemePlayModel.h"

#import "YYHomeMarkCollectionViewCell.h"

#import "NSDate+YYWeek.h"

@interface YYHomeViewModel ()


@property (nonatomic, strong) NSMutableArray *markModelsArray;

@property (nonatomic, strong) NSArray *playModelsArray;
@end

@implementation YYHomeViewModel
//- (instancetype)initCollectionViewModelWithMarkModelsArray:(NSArray *)modelsArray{
//    if (self = [super init]) {
//        self.markModelsArray = modelsArray;
//    }
//    return self;
//}
- (NSMutableArray *)markModelsArray{
    if (!_markModelsArray) {
        _markModelsArray = [NSMutableArray array];
    }
    return _markModelsArray;
}
#pragma mark 获取景点分类的数据
- (void)getMarksArrayWithParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray<YYHomeCollectionViewCellModel *> *, NSError *))callback{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        YYHomeCollectionViewCellModel *model0 = [[YYHomeCollectionViewCellModel alloc] init];
        model0.markImgUrl = @"home_2";
        model0.markName = @"农家园林";

        YYHomeCollectionViewCellModel *model1 = [[YYHomeCollectionViewCellModel alloc] init];
        model1.markImgUrl = @"home_3";
        model1.markName = @"花景欣赏";
        
        YYHomeCollectionViewCellModel *model2 = [[YYHomeCollectionViewCellModel alloc] init];
        model2.markImgUrl = @"home_4";
        model2.markName = @"避暑山庄";
        
        YYHomeCollectionViewCellModel *model3 = [[YYHomeCollectionViewCellModel alloc] init];
        model3.markImgUrl = @"home_5";
        model3.markName = @"花园客栈";
        
        self.playModelsArray = @[model0, model1, model2, model3, model0, model1, model2];
        
        callback(self.playModelsArray, nil);
        
    });
}

/**
 获取当月推荐的内容
 */
- (void)getThisMonthRecommendWithParameters:(NSDictionary *)parameters andCallback:(void(^)(YYHomeThisMonthRecommendModel *model, NSError *error))callback{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YYHomeThisMonthRecommendModel *model = [[YYHomeThisMonthRecommendModel alloc] init];
        model.imgurl = @"home_6";
        model.cityName = @"诸暨";
        model.cityMark = @"人文荟萃.越国故地.西施故里";
        model.cityContent = @"诸暨位于浙江省中北部，北邻杭州，东接绍兴，南临义乌。诸暨历史悠久、人文荟萃，是越国故地、西施故里";
        
        callback(model, nil);
        
    });
}
/**
 获取主题游的内容
 */
- (void)getThemePlayModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray<YYThemePlayModel *> *modelsArray,NSError *error)) callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/firstpage/getThemeTaglist.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            YYThemePlayModel *model = [YYThemePlayModel yy_modelWithDictionary:dic];
            [self.markModelsArray addObject:model];

        }
        
        callback(self.markModelsArray, nil);
    }];
    
}
/**
 获取发现的内容
 */
- (void)getDiscoverModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray<YYHomeDiscoverModel *> *modelsArray,NSError *error)) callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/firstpage/getDiscoverlist.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        YYLog(@"%@", responseObject);
        NSArray *data = responseObject[@"data"];
        NSMutableArray *discoverArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYHomeDiscoverModel *model = [YYHomeDiscoverModel yy_modelWithDictionary:dic];
            [discoverArray addObject:model];
            
        }
        
        callback(discoverArray, nil);
    }];
}

/**
 获取游记的内容
 */
- (void)getTravelNotesModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray<YYHomeTravelNotesModel *> *modelsArray,NSError *error)) callback{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YYHomeTravelNotesModel *model0 = [[YYHomeTravelNotesModel alloc] init];
        model0.travelTitle = @"[喜马拉雅风景区]";
        model0.travelOuterImgurl = @"home_12";
        model0.travelTag = @"精华游记";
        model0.travelUploadTime = [NSDate date];
        model0.travelVisitNum = 10002;
        
        YYHomeTravelNotesModel *model1 = [[YYHomeTravelNotesModel alloc] init];
        model1.travelTitle = @"蓝色日本毕业之旅";
        model1.travelOuterImgurl = @"home_13";
        model1.travelTag = nil;
        model1.travelUploadTime = [NSDate date];
        model1.travelVisitNum = 998;
        
        callback(@[model0, model1 ], nil);
    });
}


@end
