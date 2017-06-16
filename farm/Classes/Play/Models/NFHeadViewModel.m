//
//  NFHeadViewModel.m
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFHeadViewModel.h"

@implementation NFHeadViewModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"headViewModelId":@"id",
             @"discription":@"description"
             };
}

@end
