//
//  YYBaseViewModel.m
//  farm
//
//  Created by wyy on 2016/12/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYBaseViewModel.h"

@implementation YYBaseViewModel
- (instancetype)init{
    if (self = [super init]) {
        self.modelsArray = [NSMutableArray array];
        self.pageNumber = 5;
    }
    return self;
}
/**
 下拉刷新获取
 */
- (void)getHeaderModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback{
    
    [self getModelsArrayWithParameters:parameters andCallBack:^(NSArray *modelsArray, NSError *error) {
        if (!error || error.code == kNoMoreTableViewDataCode) {
            [self.modelsArray removeAllObjects];
            [self.modelsArray addObjectsFromArray:modelsArray];
        }
        callback(self.modelsArray, error);
    }];
}
/**
 上拉刷新获取
 */
- (void)getFooterModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback{
    
    [self getModelsArrayWithParameters:parameters andCallBack:^(NSArray *modelsArray, NSError *error) {
        
        [self.modelsArray addObjectsFromArray:modelsArray];
        callback(self.modelsArray, error);
    }];
}
- (void)getModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback{
    
}
//获取组数
- (NSUInteger)getNumberSection{
    return 1;
}
//获取某一组有几个单元格
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    return 1;
}
//组头高度
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section{
    return 0;
}
//组尾高度
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section{
    return 0;
}
//行高
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}
//获取一个模型
- (NSObject *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
