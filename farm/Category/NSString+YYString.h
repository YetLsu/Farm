//
//  NSString+YYString.h
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYString)
- (CGFloat)calculateHeightStringWithAttr:(NSDictionary *)attr andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;

- (CGFloat)calculateWidthStringWithAttr:(NSDictionary *)attr andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;

+ (instancetype)distanceStrWithDistanceStr:(NSString *)distanceStr;
@end
