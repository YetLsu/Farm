//
//  YYHomeCollectionViewCellModel.m
//  farm
//
//  Created by wyy on 2016/11/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeCollectionViewCellModel.h"

@implementation YYHomeCollectionViewCellModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"modelID" : @"id",
             @"markImgUrl" : @"imgurl",
             @"markName" : @"tagname",
             };
}

@end
