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
             @"productPrice" : @"price",
             @"productPackaging" : @"packaging",
             };
}
@end
