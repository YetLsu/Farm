//
//  YYBaseViewModel.h
//  farm
//
//  Created by wyy on 2016/12/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYBaseViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *modelsArray;

@property (nonatomic, assign) int pageNumber;

/**
 下拉刷新获取
 */
- (void)getHeaderModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback;
/**
 上拉刷新获取
 */
- (void)getFooterModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback;

- (void)getModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback;

//获取组数
- (NSUInteger)getNumberSection;
//获取某一组有几个单元格
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section;
//组头高度
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section;
//组尾高度
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section;
//行高
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
//获取一个模型
- (NSObject *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath;
@end
