//
//  NFAccount.m
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFAccount.h"

@implementation NFAccount
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"accountId":@"id",
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accountId forKey:@"accountId"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.headimgurl forKey:@"headimgurl"];    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.accountId = [aDecoder decodeObjectForKey:@"accountId"];
        self.userid = [aDecoder decodeObjectForKey:@"userid"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.headimgurl = [aDecoder decodeObjectForKey:@"headimgurl"];
    }
    return self;
}

@end
