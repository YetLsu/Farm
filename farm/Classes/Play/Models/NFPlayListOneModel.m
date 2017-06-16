//
//  NFPlayListOneModel.m
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFPlayListOneModel.h"

@implementation NFPlayListOneModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"playListOneModelId":@"id",
             @"spotTitle":@"spot_title"
             };
}

@end
