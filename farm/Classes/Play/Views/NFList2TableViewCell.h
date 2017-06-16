//
//  NFList2TableViewCell.h
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class List2TableViewCell,NFPlayListTwoModel;
@protocol NFList2TableViewCellDelegate <NSObject>

- (void)list2TableViewCell:(List2TableViewCell *)cell andModel:(NFPlayListTwoModel *)model;

@end


@interface NFList2TableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) id<NFList2TableViewCellDelegate> delegate;
@end
