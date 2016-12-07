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

#import "YYSightSpotModel.h"
#import "YYSightSpotTableViewCell.h"

@interface YYHomeMarkTableViewController ()
@property (nonatomic, strong) YYHomeCollectionViewCellModel *markModel;

@property (nonatomic, strong) YYHomeMarkViewModel *viewModel;

@property (nonatomic, strong) NSArray<YYSightSpotModel *> *modelsArray;

@end

@implementation YYHomeMarkTableViewController

- (YYHomeMarkViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYHomeMarkViewModel alloc] init];
    }
    return _viewModel;
}
- (instancetype)initWithMarkCollectionModel:(YYHomeCollectionViewCellModel *)markModel{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.markModel = markModel;
        self.title = self.markModel.markName;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.viewModel getSightSpotModelsArrayWithParameters:nil andCallback:^(NSArray<YYSightSpotModel *> *modelsArray, NSError *error) {
        self.modelsArray = modelsArray;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYSightSpotTableViewCell *cell = [YYSightSpotTableViewCell sightSpotTableViewCellWithTableView:tableView];
    
    cell.model = self.modelsArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat spotImageViewH = 200/603.0*kNoNavHeight;
    
    CGFloat spotTitleLabelH = 14.0;
    
    CGFloat iconH = 14;
    return kX12Margin * 2 + spotImageViewH + 10 * 2 + iconH + spotTitleLabelH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
