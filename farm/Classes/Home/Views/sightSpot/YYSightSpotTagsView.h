//
//  YYSightSpotTagsView.h
//  farm
//
//  Created by wyy on 2016/12/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSightSpotTagsView : UIView

@property (nonatomic, strong) NSArray *tagsArray;

- (instancetype)initWithTagsArray:(NSArray *)tagsArray;



@property (nonatomic, copy) void (^YYHeightBlock) (int lineNum);
@end
