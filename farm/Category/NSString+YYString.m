//
//  NSString+YYString.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "NSString+YYString.h"

@implementation NSString (YYString)
- (CGFloat)calculateStringWithAttr:(NSDictionary *)attr andMaxHeight:(CGFloat)maxHeight andMaxWidth:(CGFloat)maxWidth{
    
    return [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 2;
}


@end
