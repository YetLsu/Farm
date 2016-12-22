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


@end

@implementation YYHomeViewModel
//- (instancetype)initCollectionViewModelWithMarkModelsArray:(NSArray *)modelsArray{
//    if (self = [super init]) {
//        self.markModelsArray = modelsArray;
//    }
//    return self;
//}

#pragma mark 获取景点分类的数据
- (void)getMarksArrayWithParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray<YYHomeCollectionViewCellModel *> *, NSError *))callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/firstpage/getCarrouselTaglist.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSArray *data = responseObject[@"data"];
        NSMutableArray *marksArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYHomeCollectionViewCellModel *model = [YYHomeCollectionViewCellModel yy_modelWithDictionary:dic];
            [marksArray addObject:model];
            
        }
        
        callback(marksArray, nil);
    }];

}

/**
 获取当月推荐的内容
 */
- (void)getThisMonthRecommendWithParameters:(NSDictionary *)parameters andCallback:(void(^)(YYHomeThisMonthRecommendModel *model, NSError *error))callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/firstpage/getMonthRecommend.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSDictionary *data = responseObject[@"data"];
        
        YYHomeThisMonthRecommendModel *model = [YYHomeThisMonthRecommendModel yy_modelWithDictionary:data];
        
        callback(model, nil);
    }];
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
        
        NSMutableArray *playsArray = [NSMutableArray array];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            YYThemePlayModel *model = [YYThemePlayModel yy_modelWithDictionary:dic];
            [playsArray addObject:model];

        }
        
        callback(playsArray, nil);
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
//        YYLog(@"%@", responseObject);
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
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/firstpage/getTravelnoteslist.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
//        YYLog(@"%@", responseObject);
        NSArray *data = responseObject[@"data"];
        NSMutableArray *travelNotesArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYHomeTravelNotesModel *model = [YYHomeTravelNotesModel yy_modelWithDictionary:dic];
            [travelNotesArray addObject:model];
            
        }
        callback(travelNotesArray, nil);
    }];

}


@end
