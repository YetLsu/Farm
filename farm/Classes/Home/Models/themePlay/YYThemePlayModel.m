//
//  YYthemePlayModel.m
//  farm
//
//  Created by wyy on 2016/12/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThemePlayModel.h"

@implementation YYThemePlayModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"themePlayID"  : @"id",
             @"homeImgUrl"  : @"outerImgurl",
             @"listImgUrl"  : @"innerImgurl",
             @"themePlayName": @"tagname"};
}
@end
