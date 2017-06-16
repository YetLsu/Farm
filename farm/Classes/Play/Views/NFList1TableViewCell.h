//
//  NFList1TableViewCell.h
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFPlayListOneModel,NFList1TableViewCell,YYSightSpotModel;

@protocol NFList1TableViewCellDelegate  <NSObject>

- (void)list1TableViewCell:(NFList1TableViewCell *)cell andModel:(YYSightSpotModel *)model;

@end

@interface NFList1TableViewCell : UITableViewCell

//@property (nonatomic, strong) NFPlayListOneModel *model;
@property (nonatomic, strong) NSArray<NFPlayListOneModel *> *data;

@property (nonatomic, strong) NSArray<YYSightSpotModel *> *signtArray;

@property (nonatomic, assign) id<NFList1TableViewCellDelegate> delegate;

@end
