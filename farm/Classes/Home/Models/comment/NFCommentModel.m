//
//  NFCommentModel.m
//  farm
//
//  Created by guest on 17/3/2.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFCommentModel.h"

@implementation NFCommentModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"commentModelId": @"id",
             @"coTime"  : @"co_time",
             @"discoverId":@"discoverid",
             @"coDetails"  : @"co_details"};
}

- (void)setCoDetails:(NSString *)coDetails{
    if (_coDetails != coDetails) {
        _coDetails = coDetails;
    }
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect rect = [_coDetails boundingRectWithSize:CGSizeMake(kWidthScreen - 60 - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    _coDetailsHeight = rect.size.height;
}
@end
