//
//  YYHomeDiscoverTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeDiscoverTableViewController.h"

#import "YYHomeDiscoverViewModel.h"

@interface YYHomeDiscoverTableViewController ()

@end

@implementation YYHomeDiscoverTableViewController

- (void)viewDidLoad {
    self.viewModel = [[YYHomeDiscoverViewModel alloc] init];
    self.viewModel.pageNumber = 10;
    self.parameters = [NSMutableDictionary dictionary];
    [super viewDidLoad];
    
    self.title = @"发现";
    self.view.backgroundColor = kViewBGColor;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = @"saadas";
    
    // Configure the cell...
    
    return cell;
}

@end
