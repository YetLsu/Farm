//
//  YYTravelNotesModel.h
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHomeTravelNotesModel : NSObject

//景点id
@property(nonatomic, assign) int spotID;
//游记标题
@property (nonatomic, copy) NSString *travelTitle;
//内图地址
@property (nonatomic, copy) NSString *travelInnerImgurl;
//外图地址
@property (nonatomic, copy) NSString *travelOuterImgurl;
//游客名称
@property (nonatomic, copy) NSString *travelVisitorName;
//游客头像
@property (nonatomic, copy) NSString *travelVisitorHeadImgurl;
//上传时间
@property (nonatomic, strong) NSDate *travelUploadTime;
//内容链接地址
@property (nonatomic, copy) NSString *travelContenturl;
//标签
@property (nonatomic, copy) NSString *travelTag;
//访问量
@property (nonatomic, assign) int travelVisitNum;

@property (nonatomic, assign) int commentNum;

@property (nonatomic, assign) int praiseNum;
@end
