//
//  YYBaseTableViewController.h
//  farm
//
//  Created by wyy on 2016/12/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBaseTableViewController : UITableViewController

@property (nonatomic, assign) int index;

@property (nonatomic, strong) NSArray *modelsArray;

@property (nonatomic, strong) YYBaseViewModel *viewModel;

@property (nonatomic, strong) NSMutableDictionary *parameters;

- (void)setHeaderAndFooter;


@end
