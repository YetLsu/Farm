//
//  YYProductDetailTableViewCell.h
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YYProductDetailTableViewCell : UITableViewCell

@property (nonatomic, weak) UIButton *btn;

@property (nonatomic, copy) NSString *content;
+ (instancetype)productDetailTableViewCellWithTableView:(UITableView *)tableView;
@end
