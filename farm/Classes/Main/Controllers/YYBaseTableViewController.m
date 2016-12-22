//
//  YYBaseTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYBaseTableViewController.h"

@interface YYBaseTableViewController ()



@end

@implementation YYBaseTableViewController
- (NSArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSArray array];
    }
    return _modelsArray;
}
- (void)setHeaderAndFooter{
    self.index = 0;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        weakSelf.index = 0;
        
        weakSelf.parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index];
        [weakSelf.viewModel getHeaderModelsArrayWithParameters:weakSelf.parameters andCallBack:^(NSArray *modelsArray, NSError *error) {
            if (error) {
                if (error.code == kNoMoreTableViewDataCode) {
                    [weakSelf.tableView setNoMoreData];
                }
                else{
                    YYLog(@"网络请求错误%ld",(long)error.code);
                }
                
            }
            else{
                [weakSelf.tableView resetFooter];
            }
            weakSelf.modelsArray = modelsArray;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endHeaderRefresh];
        }];
        
        
    }];
    [self.tableView addFooterRefresh:^{
        weakSelf.index = (weakSelf.index + 1) * self.viewModel.pageNumber;
        weakSelf.parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index];
        [weakSelf.viewModel getFooterModelsArrayWithParameters:weakSelf.parameters andCallBack:^(NSArray *modelsArray, NSError *error)  {
            if (error) {
                if (error.code == kNoMoreTableViewDataCode) {
                    weakSelf.modelsArray = modelsArray;
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView setNoMoreData];
                }
                else{
                    YYLog(@"网络请求错误%ld",(long)error.code);
                }
            }
            else{
                weakSelf.modelsArray = modelsArray;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endFooterRefresh];
            }
            
        }];
        
    }];
    [self.tableView beginHeaderRefresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeaderAndFooter];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel getNumberSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel getNumberRowsOnSection:0];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.viewModel getTableViewHeightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self.viewModel getTableViewHeightForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel getHeightForRowAtIndexPath:indexPath];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//}
@end
