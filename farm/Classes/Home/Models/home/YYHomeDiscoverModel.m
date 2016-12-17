//
//  YYHomeDiscoverModel.m
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeDiscoverModel.h"

@implementation YYHomeDiscoverModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"discoverID" : @"id",
             @"contentUrl" : @"contenturl",
             @"content" : @"introduction",
             @"uploadingTime" : @"uploading_time",
             };
}
@end
