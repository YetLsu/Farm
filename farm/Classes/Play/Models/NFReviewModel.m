//
//  NFReviewModel.m
//  farm
//
//  Created by guest on 17/2/23.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFReviewModel.h"

@implementation NFReviewModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"reviewModelId":@"id",
             @"discription":@"description"
             };
}

@end
