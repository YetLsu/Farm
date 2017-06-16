//
//  NFAccountTool.h
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NFAccount;
@interface NFAccountTool : NSObject
/**
 *  获取用户模型
 */
+ (NFAccount *)account;
    
/**
 *  保存用户模型
 */
+ (void)saveAccount:(NFAccount *)account;

/**
 *  删除用户模型
 */
+ (void)removeAccount;
@end
