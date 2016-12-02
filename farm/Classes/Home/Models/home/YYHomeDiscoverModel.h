//
//  YYHomeDiscoverModel.h
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHomeDiscoverModel : NSObject
//发现标题
@property (nonatomic, copy) NSString *title;
//内图地址
@property (nonatomic, copy) NSString *innerImgurl;
//外图地址
@property (nonatomic, copy) NSString *outerImgurl;
//上传时间
@property (nonatomic, strong) NSDate *uploadingTime;
//内容链接地址
@property (nonatomic, copy) NSString *contentUrl;
//标签
@property (nonatomic, copy) NSString *tag;
//内容
@property (nonatomic, copy) NSString *content;
@end
