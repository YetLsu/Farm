//
//  YYMarkSightSpotModel.h
//  farm
//
//  Created by wyy on 2016/12/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSightSpotModel : NSObject
//uuid32位唯一编码
@property (nonatomic, copy) NSString *spotuuid;
//景点名称
@property (nonatomic, copy) NSString *spotTitle;
//人均消费
@property (nonatomic, assign) CGFloat spotExpense;
//内图地址
@property (nonatomic, copy) NSString *spotInnerImgurl;
//外图地址
@property (nonatomic, copy) NSString *spotOuterImgurl;
//城市编码
@property (nonatomic, copy) NSString *cityCode;
//详细地址
@property (nonatomic, copy) NSString *spotAddress;
//经度
@property (nonatomic, assign) float cityLon;
//纬度
@property (nonatomic, assign) float cityLat;
//标签列表
@property (nonatomic, strong) NSArray *spotTags;
//景点简介链接地址
@property (nonatomic, copy) NSString *spotIntroUrl;
//推荐理由
@property (nonatomic, copy) NSString *spotRecommendResult;
//上传时间
@property (nonatomic, strong) NSDate *uploadTime;
//距离
@property (nonatomic, copy) NSString *spotDistance;
@end
