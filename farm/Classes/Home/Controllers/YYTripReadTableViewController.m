//
//  YYTripReadTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTripReadTableViewController.h"
#import "YYTripReadViewModel.h"
#import "YYSightSpotModel.h"
#import "YYTripReadTableViewCell.h"

@interface YYTripReadTableViewController ()

@property (nonatomic, strong) YYSightSpotModel *model;
@end

@implementation YYTripReadTableViewController
- (instancetype)initWithSightSpotModel:(YYSightSpotModel *)model{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[YYTripReadViewModel alloc] init];
    self.noNeedRefresh = YES;
    [super viewDidLoad];
    
    self.title = @"出行必读";
    self.view.backgroundColor = kViewBGColor;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYTripReadTableViewCell *cell = [YYTripReadTableViewCell tripReadTableViewCellWithTableView:tableView];
    
    cell.model = (YYTripReadModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
