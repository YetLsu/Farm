//
//  YYThisMonthCommendViewModel.m
//  farm
//
//  Created by wyy on 2016/12/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThisMonthCommendViewModel.h"

#import "YYSightSpotModel.h"

@implementation YYThisMonthCommendViewModel
//计算标签View高度
+ (CGFloat)tagsViewWidthWithTagsArray:(NSArray *)tagsArray andAttr:(NSDictionary *)attr andxMargin:(CGFloat)xMargin andTextHeight:(CGFloat)textH{
    CGFloat allWidth = 0;
    for (NSString *str in tagsArray) {
        CGFloat width = [str calculateWidthStringWithAttr:attr andMaxWidth:200 andMaxHeight:textH] + xMargin + xMargin;
        
        allWidth += width;
    }

    return allWidth - xMargin;
}
- (void)getThisMonthCommendModelsArrayWithParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray <YYSightSpotModel *>*modelsArray ,NSError *error))callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/monthrecommend/getMonthRecommendListAllback1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        if (error) {
            callback(nil, error);
            return;
        }
        NSArray *data = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYSightSpotModel *model = [YYSightSpotModel yy_modelWithDictionary:dic];
            model.spotTags = [model.spotTagsString componentsSeparatedByString:@"|"];
            [array addObject:model];
        }
        
        callback(array, nil);
       
        
    }];
}
@end
