//
//  YYHomeMarkViewModel.h
//  farm
//
//  Created by wyy on 2016/12/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYSightSpotModel;
@interface YYHomeMarkViewModel : NSObject
//计算标签View高度
+ (CGFloat)tagsViewHeightWithTagsArray:(NSArray *)tagsArray andAttr:(NSDictionary *)attr andxMargin:(CGFloat)xMargin andItemH:(CGFloat)itemH andyMargin:(CGFloat)yMargin;


- (void)getSightSpotModelsArrayWithParameters:(NSDictionary *)parameters andCallback:(void(^)(NSArray <YYSightSpotModel *> *modelsArray, NSError *error))callback;
@end
