//
//  YYMarkSightSpotModel.m
//  farm
//
//  Created by wyy on 2016/12/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotModel.h"

@implementation YYSightSpotModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"spotID" : @"spotid",
             @"spotTitle" : @"spot_title",
             @"spotExpense" : @"expense",
             @"spotInnerImgurl" : @"innerImgurl",
             @"spotOuterImgurl" : @"outerImgurl",
             @"cityCode" : @"citycode",
             @"spotAddress" : @"address",
             @"cityLon" : @"lon",
             @"cityLat" : @"lat",
             @"spotTagsString" : @"tags",
             @"spotIntroUrl" : @"spot_introurl",
             @"spotRecommendResult" : @"recommend",
             @"spotDistance" : @"juli"
             };
}
@end
