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
- (void)getSightSpotModelsArrayWithParameters:(NSDictionary *)parameters andCallback:(void(^)(NSArray <YYSightSpotModel *> *modelsArray, NSError *error))callback{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        YYSightSpotModel *model0 = [[YYSightSpotModel alloc] init];
        model0.spotOuterImgurl = @"home_14";
        model0.spotTitle = @"操你妈逼的景点";
        model0.spotAddress = @"浙江省绍兴市越城区";
        model0.spotDistance = @"50000.12";
        model0.spotTags = @[@"操你妈逼操你妈逼",@"妈的纸张"];
        
        
        YYSightSpotModel *model1 = [[YYSightSpotModel alloc] init];
        model1.spotOuterImgurl = @"home_15";
        model1.spotTitle = @"操你妈逼的景点";
        model1.spotAddress = @"浙江省绍兴市越城区";
        model1.spotDistance = @"500.12";
        model1.spotTags = @[@"操你操你妈逼",@"妈的纸张", @"操你妈的妈逼妈的纸张",@"妈的", @"操你妈逼",@"妈的纸张", @"操你妈逼",@"妈的纸张"];
        
        callback(@[model0, model1, model0, model1, model0, model1, model0, model1], nil);
    });
}
@end
