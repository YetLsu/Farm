//
//  YYHomeTravelNotesTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHomeTravelNotesModel;
@interface YYHomeTravelNotesTableViewCell : UITableViewCell

@property (nonatomic, strong) YYHomeTravelNotesModel *model;

+ (instancetype)homeTravelNotesTabelViewCellWithTableView:(UITableView *)tableView;
@end
