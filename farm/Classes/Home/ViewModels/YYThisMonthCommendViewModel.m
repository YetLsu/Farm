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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        YYSightSpotModel *model0 = [[YYSightSpotModel alloc] init];
        model0.spotOuterImgurl = @"home_16";
        model0.spotTitle = @"操你妈逼的景点";
        model0.spotAddress = @"浙江省绍兴市越城区";
        model0.spotDistance = @"50000.12";
        model0.spotTags = @[@"操你妈逼",@"妈的纸张", @"操你妈逼", @"操你妈逼", @"操你妈逼"];
        
        
        YYSightSpotModel *model1 = [[YYSightSpotModel alloc] init];
        model1.spotOuterImgurl = @"home_16";
        model1.spotTitle = @"操你妈逼的景点";
        model1.spotAddress = @"浙江省绍兴市省绍兴省绍兴市越市越省绍兴市越越城区";
        model1.spotDistance = @"500.12";
        model1.spotTags = @[@"操你妈的妈逼妈的纸张",@"妈的", @"操你妈逼"];
        
        callback(@[model0, model1, model0, model1, model0, model1, model0, model1], nil);
    });
}
@end
