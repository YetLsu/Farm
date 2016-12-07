//
//  YYHomeMarkTableViewController.h
//  farm
//
//  Created by wyy on 2016/12/3.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeCollectionViewCellModel;
@interface YYHomeMarkTableViewController : UITableViewController

- (instancetype)initWithMarkCollectionModel:(YYHomeCollectionViewCellModel *)markModel;

@end
