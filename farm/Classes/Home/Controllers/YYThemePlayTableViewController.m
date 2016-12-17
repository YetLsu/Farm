//
//  YYThemePlayTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThemePlayTableViewController.h"
#import "YYThemePlayModel.h"
#import "YYThemePlayViewModel.h"
#import "YYThemePlayTableViewCell.h"

@interface YYThemePlayTableViewController ()

@end

@implementation YYThemePlayTableViewController

- (void)viewDidLoad {
    self.viewModel = [[YYThemePlayViewModel alloc] init];
    self.viewModel.pageNumber = 5;
    self.parameters = [NSMutableDictionary dictionary];
    [super viewDidLoad];
    
    self.title = @"主题游";
    self.tableView.backgroundColor = kViewBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYThemePlayTableViewCell *cell = [YYThemePlayTableViewCell themePlayTableViewCellWithTableView:tableView];
    
    cell.model = (YYThemePlayModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    return cell;
}

@end
