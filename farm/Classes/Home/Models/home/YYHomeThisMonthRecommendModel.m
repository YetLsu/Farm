//
//  YYHomeThisMonthRecommendModel.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeThisMonthRecommendModel.h"

@implementation YYHomeThisMonthRecommendModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"thisMonthID" : @"id",
             @"cityName" : @"area",
             @"cityMark" : @"title",
             @"cityContent" : @"intro"
             };
}
@end
