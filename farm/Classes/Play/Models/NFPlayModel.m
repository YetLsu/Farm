//
//  NFPlayModel.m
//  farm
//
//  Created by guest on 17/2/20.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFPlayModel.h"

@implementation NFPlayModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"playModelId":@"id",
             };
}
@end
