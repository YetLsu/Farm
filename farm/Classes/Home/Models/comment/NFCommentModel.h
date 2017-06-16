//
//  NFCommentModel.h
//  farm
//
//  Created by guest on 17/3/2.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFCommentModel : NSObject
@property (nonatomic, copy) NSString *commentModelId;
@property (nonatomic, copy) NSString *discoverId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *coTime;
//评论内容
@property (nonatomic, copy) NSString *coDetails;
//评论内容的高度
@property (nonatomic, assign) CGFloat coDetailsHeight;

@end
