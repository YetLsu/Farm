//
//  YYThisMonthCommendViewModel.h
//  farm
//
//  Created by wyy on 2016/12/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYSightSpotModel;
@interface YYThisMonthCommendViewModel : NSObject
- (void)getThisMonthCommendModelsArrayWithParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray <YYSightSpotModel *>*modelsArray ,NSError *error))callback;

//计算标签View高度
+ (CGFloat)tagsViewWidthWithTagsArray:(NSArray *)tagsArray andAttr:(NSDictionary *)attr andxMargin:(CGFloat)xMargin andTextHeight:(CGFloat)textH;
@end
