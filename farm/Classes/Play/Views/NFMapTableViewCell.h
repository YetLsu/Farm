//
//  NFMapTableViewCell.h
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFMapModel;
@interface NFMapTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<NFMapModel *> *data;

@end
