//
//  YYHomeMarkTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/3.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeMarkTableViewController.h"
#import "YYHomeCollectionViewCellModel.h"

#import "YYHomeMarkViewModel.h"
#import "YYThemePlayModel.h"

#import "YYSightSpotModel.h"
#import "YYSightSpotTableViewCell.h"
#import "YYSpotDetailViewController.h"

@interface YYHomeMarkTableViewController ()
@property (nonatomic, strong) YYHomeCollectionViewCellModel *markModel;

@end

@implementation YYHomeMarkTableViewController

- (instancetype)initWithMarkCollectionModel:(YYHomeCollectionViewCellModel *)markModel{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.markModel = markModel;
        self.title = self.markModel.markName;
        
    }
    return self;
}
- (instancetype)initWithCollectionViewCellModel:(YYThemePlayModel *)themePlayModel{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
        self.title = themePlayModel.themePlayName;
        
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[YYHomeMarkViewModel alloc] init];
    self.viewModel.pageNumber = 10;
    self.parameters = [NSMutableDictionary dictionary];
    YYUserModel *userModel = [YYUserTool userModel];
    
    self.parameters[@"lon"] = userModel.lon;
    self.parameters[@"lat"] = userModel.lat;
    self.parameters[@"tag"] = self.title;
    
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYSightSpotTableViewCell *cell = [YYSightSpotTableViewCell sightSpotTableViewCellWithTableView:tableView];
    
    cell.model = (YYSightSpotModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    return cell;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYSightSpotModel *model = (YYSightSpotModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    YYSpotDetailViewController *controller = [[YYSpotDetailViewController alloc] initWithSpotModel:model];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
