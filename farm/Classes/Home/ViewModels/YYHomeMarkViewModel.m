//
//  YYHomeMarkViewModel.m
//  farm
//
//  Created by wyy on 2016/12/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeMarkViewModel.h"
#import "YYSightSpotModel.h"

@implementation YYHomeMarkViewModel
+ (CGFloat)tagsViewHeightWithTagsArray:(NSArray *)tagsArray andAttr:(NSDictionary *)attr andxMargin:(CGFloat)xMargin andItemH:(CGFloat)itemH andyMargin:(CGFloat)yMargin{
    
    CGFloat allWidth = xMargin;
    CGFloat maxWidth = kWidthScreen - xMargin * 2;
    CGFloat lineNum = 1;
    
    for (NSString *str in tagsArray) {
        
        CGFloat width = [str calculateWidthStringWithAttr:attr andMaxWidth:200 andMaxHeight:kHeightText16] + xMargin;
        
        allWidth += xMargin;
        allWidth += width;
        if (allWidth > maxWidth) {
            lineNum += 1;
            allWidth = xMargin + width + xMargin;
        }
    }
    
    return yMargin * (1 + lineNum) + itemH * lineNum;
    
}
- (void)getModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *, NSError *))callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/tag/getSpotsListAll.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSArray *data = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYSightSpotModel *model = [YYSightSpotModel yy_modelWithDictionary:dic];
            model.spotTags = [model.spotTagsString componentsSeparatedByString:@"|"];
            [array addObject:model];
        }
        if (array.count < self.pageNumber) {
            NSError *error = [[NSError alloc] initWithDomain:@"123" code:kNoMoreTableViewDataCode userInfo:nil];
            callback(array, error);
        }
        else{
            callback(array, nil);
        }
        
    }];

}

//获取组数
- (NSUInteger)getNumberSection{
    return 1;
}
//获取某一组有几个单元格
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    return self.modelsArray.count;
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
    CGFloat spotImageViewH = 200/603.0*kNoNavHeight;
    
    CGFloat spotTitleLabelH = 14.0;
    
    CGFloat iconH = 14;
    return kX12Margin * 2 + spotImageViewH + 10 * 2 + iconH + spotTitleLabelH;

}
//获取一个模型
- (NSObject *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.modelsArray[indexPath.row];
}

@end
