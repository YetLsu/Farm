//
//  YYSightSpotRightView.h
//  farm
//
//  Created by wyy on 2016/12/22.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSightSpotRightView : UIView
- (instancetype)initWithTitleArray:(NSArray *)titleArray andViewW:(CGFloat)viewW;
@end

@interface YYSightSpotRightTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *nameLabel;

+ (instancetype)sightSpotRightTableViewCellWithTableView:(UITableView *)tableView;

@end
