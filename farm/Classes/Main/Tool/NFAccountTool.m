//
//  NFAccountTool.m
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFAccountTool.h"
#import "NFAccount.h"

#define kAccountSavePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.doc"]
@implementation NFAccountTool
/**
 *  获取用户模型
 */
+ (NFAccount *)account{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountSavePath];
}

/**
 *  保存用户模型
 */
+ (void)saveAccount:(NFAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountSavePath];
}

/**
 *  删除用户模型
 */
+ (void)removeAccount{
    NFAccount *account = [[NFAccount alloc] init];
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountSavePath];
}

@end
