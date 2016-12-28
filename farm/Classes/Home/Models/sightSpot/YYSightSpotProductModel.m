//
//  YYSightSpotProductModel.m
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotProductModel.h"

@implementation YYSightSpotProductModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"productID" : @"spotid",
             @"productName" : @"pro_name",
             @"productOuterImgurl" : @"outerImgurl",
             @"productInnerImgList" : @"innerImgurllist",
             @"productPrice" : @"price",
             @"productPackaging" : @"packaging",
             @"productStock" : @"pro_stock",
             @"productCarriage" : @"carriage",
             @"productDelivery" : @"delivery",
             @"productIntro" : @"pro_intro",
             @"productWarmPrompt" : @"warm_prompt",
             };
}
@end
