//
//  YYTravelNotesViewController.m
//  farm
//
//  Created by wyy on 2016/12/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTravelNotesViewController.h"
#import "YYTravelNotesSortView.h"
#import "YYTravelNotesViewModel.h"
#import "YYHomeTravelNotesTableViewCell.h"

@interface YYTravelNotesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *modelsArray;

@property (nonatomic, copy) NSString *sortName;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) YYTravelNotesViewModel *viewModel;

@property (nonatomic, strong) NSMutableDictionary *parameters;
@end

@implementation YYTravelNotesViewController

- (void)viewDidLoad {
    
    self.parameters = [NSMutableDictionary dictionary];
    self.viewModel = [[YYTravelNotesViewModel alloc] initWithSortsArray:@[@"全部", @"精华游记", @"最新发布"]];
    self.viewModel.pageNumber = 10;
    
    [super viewDidLoad];
    
    self.index = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"游记";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addSubViews];
    
    [self setHeaderAndFooter];
 
}
- (void)addSubViews{
    YYTravelNotesSortView *sortView = [[YYTravelNotesSortView alloc] initWithSortArray:@[@"全部", @"精华游记", @"最新发布"] andViewH:38];
    [self.view addSubview:sortView];
    [sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.height.mas_equalTo(38);
    }];
    
    self.sortName = @"全部";
    [sortView setYYCollectionViewCellClick:^(NSString *sortTitle) {
        self.sortName = sortTitle;
        self.index = 0;
        self.parameters[@"tag"] = sortTitle;
        self.parameters[@"index"] = @"0";
        [self.tableView beginHeaderRefresh];
//        YYLog(@"%@", sortTitle);
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(sortView.mas_bottom);
    }];
}

- (void)setHeaderAndFooter{
    self.index = 0;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        weakSelf.index = 0;
        
        weakSelf.parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index];
        weakSelf.parameters[@"tag"] = self.sortName;
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
        weakSelf.parameters[@"tag"] = self.sortName;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel getNumberRowsOnSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYHomeTravelNotesTableViewCell *cell = [YYHomeTravelNotesTableViewCell homeTravelNotesTabelViewCellWithTableView:tableView];
    
    cell.model = (YYHomeTravelNotesModel *)[self.viewModel getTableViewModelWithIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel getHeightForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self.viewModel getTableViewHeightForFooterInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.viewModel getTableViewHeightForHeaderInSection:section];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
