//
//  NSString+YYString.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "NSString+YYString.h"

@implementation NSString (YYString)
- (CGFloat)calculateHeightStringWithAttr:(NSDictionary *)attr andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight{

    return [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
}
- (CGFloat)calculateWidthStringWithAttr:(NSDictionary *)attr andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight{
    return [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
}
+ (instancetype)distanceStrWithDistanceStr:(NSString *)distanceStr{
    double distance = distanceStr.doubleValue;
    NSUInteger distanceInt = (NSUInteger)distance;
    if (distanceInt <1000) {
        return [NSString stringWithFormat:@"%ldM", distanceInt];
    }
    CGFloat distanceKM = distanceInt/1000.0;
    return [NSString stringWithFormat:@"%.2fKM", distanceKM];
}
@end
