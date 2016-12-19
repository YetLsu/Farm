//
//  YYTravelNotesSortView.h
//  farm
//
//  Created by wyy on 2016/12/19.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTravelNotesSortView : UIView

- (instancetype)initWithSortArray:(NSArray *)sortArray andViewH:(CGFloat)viewH;

@property (nonatomic, copy) void (^YYCollectionViewCellClick) (NSString *sortName);

@end

@interface YYTravelNotesSortCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UILabel *sortLabel;

@end


