//
//  NFAccount.h
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFAccount : NSObject<NSCoding>
@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *headimgurl;
@end
