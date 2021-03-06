//
//  YYHomeDiscoverTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeDiscoverTableViewController.h"

#import "YYHomeDiscoverViewModel.h"
#import "YYDiscoverTableViewCell.h"
#import "YYHomeDiscoverModel.h"

#import "YYDiscoverViewController.h"

@interface YYHomeDiscoverTableViewController ()

@end

@implementation YYHomeDiscoverTableViewController

- (void)viewDidLoad {
    self.viewModel = [[YYHomeDiscoverViewModel alloc] init];
    self.viewModel.pageNumber = 10;
    self.parameters = [NSMutableDictionary dictionary];
    YYUserModel *userModel = [YYUserTool userModel];
    NSString *userName = userModel.name;
    self.parameters[@"username"] = userName;
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"发现";
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYDiscoverTableViewCell *cell = [YYDiscoverTableViewCell discoverTableViewCellWithTableView:tableView];
    
    cell.model = (YYHomeDiscoverModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYHomeDiscoverModel *model = (YYHomeDiscoverModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    YYDiscoverViewController *VC = [[YYDiscoverViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
