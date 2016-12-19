//
//  YYTravelNotesModel.m
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTravelNotesModel.h"

@implementation YYHomeTravelNotesModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"spotID" : @"id",
             @"travelTitle" : @"title",
             @"travelInnerImgurl" : @"innerImgurl",
             @"travelOuterImgurl" : @"outerImgurl",
             @"travelVisitorName" : @"visitor_name",
             @"travelVisitorHeadImgurl" : @"visitor_headimgurl",
             @"travelUploadTime" : @"uploading_time",
             @"travelContenturl" : @"contenturl",
             @"travelTag" : @"tag",
             @"travelVisitNum" : @"visitnum",
             };
}

@end
