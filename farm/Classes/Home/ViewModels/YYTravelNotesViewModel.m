//
//  YYTravelNotesViewModel.m
//  farm
//
//  Created by wyy on 2016/12/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTravelNotesViewModel.h"
#import "YYHomeTravelNotesModel.h"

@interface YYTravelNotesViewModel ()

@property (nonatomic, strong) NSMutableDictionary *sortModelsDictionary;

@property (nonatomic, copy) NSString *sortName;

@end

@implementation YYTravelNotesViewModel

- (instancetype)initWithSortsArray:(NSArray *)sortsArray{
    if (self = [super init]) {
        self.sortModelsDictionary = [NSMutableDictionary dictionary];
        for (NSString *str in sortsArray) {
            self.sortModelsDictionary[str] = [NSMutableArray array];
        }
    }
    return self;
}
/**
 获取内容
 */
- (void)getModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *, NSError *))callback{
    self.sortName = parameters[@"tag"];
    [NSObject GET:@"http://nc.guonongda.com:8808/app/travelnotes/getTravelNotesListback1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSArray *data = responseObject[@"data"];
        NSMutableArray *modelsArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYHomeTravelNotesModel *model = [YYHomeTravelNotesModel yy_modelWithDictionary:dic];
            [modelsArray addObject:model];
            
        }
        if (modelsArray.count < self.pageNumber) {
            NSError *error = [[NSError alloc] initWithDomain:@"123" code:kNoMoreTableViewDataCode userInfo:nil];
            callback(modelsArray, error);
        }
        else{
            callback(modelsArray, nil);
        }
        
    }];
    
}
/**
 下拉刷新获取
 */
- (void)getHeaderModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback{
    
    [self getModelsArrayWithParameters:parameters andCallBack:^(NSArray *modelsArray, NSError *error) {
        NSMutableArray *modelArray = self.sortModelsDictionary[parameters[@"tag"]];
        if (!error || error.code == kNoMoreTableViewDataCode) {
            [modelArray removeAllObjects];
            [modelArray addObjectsFromArray:modelsArray];
        }
        callback(modelArray, error);
    }];
}
/**
 上拉刷新获取
 */
- (void)getFooterModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback{
    
    [self getModelsArrayWithParameters:parameters andCallBack:^(NSArray *modelsArray, NSError *error) {
        NSMutableArray *modelArray = self.sortModelsDictionary[parameters[@"tag"]];
        
        [modelArray addObjectsFromArray:modelsArray];
        callback(modelArray, error);
    }];
}
//获取组数
- (NSUInteger)getNumberSection{
    return 1;
}
//获取某一组有几个单元格
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    NSMutableArray *array = self.sortModelsDictionary[self.sortName];
    return array.count;
}
//组头高度
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
//组尾高度
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
//行高
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200 + kY12Margin + 12 + 10 + 10 + kY12Margin;
}
//获取一个模型
- (NSObject *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array = self.sortModelsDictionary[self.sortName];
    return array[indexPath.row];
}
@end
