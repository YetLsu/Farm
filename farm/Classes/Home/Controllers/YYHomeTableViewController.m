//
//  YYHomeTableViewController.m
//  farm
//
//  Created by wyy on 2016/11/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTableViewController.h"
#import "YYHomeViewModel.h"
#import "YYHomeNavView.h"
#import <SDCycleScrollView.h>

#import "YYHomeMarkCollectionViewTableViewCell.h"

#import "YYHomeThisMonthRecommendModel.h"
#import "YYHomeThisMonthRecommendTableViewCell.h"

#import "YYHomePlayCollectionViewTableViewCell.h"

#import "YYHomeDiscoverModel.h"
#import "YYHomeDiscoverTableViewCell.h"

#import "YYHomeTravelNotesModel.h"
#import "YYHomeTravelNotesTableViewCell.h"

@interface YYHomeTableViewController ()<UITextFieldDelegate, SDCycleScrollViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) YYHomeNavView *homeNavView;

@property (nonatomic, strong) YYHomeViewModel *viewModel;

@property (nonatomic, strong) NSArray *markModelsArray;

@property (nonatomic, strong) NSArray *playModelsArray;

@property (nonatomic, strong) NSArray <YYHomeDiscoverModel *>*discoverModelsArray;

@property (nonatomic, strong) NSArray <YYHomeTravelNotesModel *>*travelNotesrModelsArray;

@property (nonatomic, strong) YYHomeThisMonthRecommendModel *recommendModel;
@end

@implementation YYHomeTableViewController
- (YYHomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYHomeViewModel alloc] init];
        [_viewModel setYYCollectionViewCellClickBlock:^{
            YYLog(@"点击");
        }];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控件
    [self addSubViews];
    
    //增加KVO
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
    //设置tableView
    [self setTableViewHeaderView];
    [self.viewModel getMarksArrayWithParameters:nil andCallback:^(NSArray<YYHomeCollectionViewCellModel *> *modelsArray, NSError *error) {
        self.markModelsArray = modelsArray;
        if (error) {
            YYLog(@"出错");
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }];
    
    [self.viewModel getThisMonthRecommendWithParameters:nil andCallback:^(YYHomeThisMonthRecommendModel *model, NSError *error) {
        
        self.recommendModel = model;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    [self.viewModel getPlayModelsArrayWithParameters:nil andCallBack:^(NSArray<YYHomeCollectionViewCellModel *> *modelsArray, NSError *error) {
        if (error) {
            YYLog(@"出错");
        }
        self.playModelsArray = modelsArray;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    [self.viewModel getDiscoverModelsArrayWithParameters:nil andCallBack:^(NSArray<YYHomeDiscoverModel *> *modelsArray, NSError *error) {
        if (error) {
            YYLog(@"出错");
        }
        self.discoverModelsArray = modelsArray;
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:3];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }];
    [self.viewModel getTravelNotesModelsArrayWithParameters:nil andCallBack:^(NSArray<YYHomeTravelNotesModel *> *modelsArray, NSError *error) {
        if (error) {
            YYLog(@"出错");
        }
        self.travelNotesrModelsArray = modelsArray;
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:4];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

    }];
}
#pragma mark 添加子控件
/**
 添加子控件
 */
- (void)addSubViews{
    // 增加tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview: tableView];
    self.tableView = tableView;
    tableView.backgroundColor = kViewBGColor;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(-20);
        make.bottom.mas_equalTo(self.view);
    }];
    tableView.delegate = self.viewModel;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //增加导航栏

    YYHomeNavView *homeNavView = [YYHomeNavView homeNavViewWithTextFieldDelegate:self];
    [self.view addSubview:homeNavView];
    self.homeNavView = homeNavView;
    homeNavView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];

    
    [homeNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    self.homeNavView.addressBtn.titleLabel.textColor = [UIColor redColor];
    [homeNavView.addressBtn setTitle:@"绍兴" forState:UIControlStateNormal];

}
//设置tableView
- (void)setTableViewHeaderView{
    NSArray *imagesArray = @[[UIImage imageNamed:@"home_1"], [UIImage imageNamed:@"home_1"], [UIImage imageNamed:@"home_1"]];
    SDCycleScrollView *topScrollerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidthScreen, 400) shouldInfiniteLoop:YES imageNamesGroup:imagesArray];
    topScrollerView.delegate = self;
    topScrollerView.backgroundColor = [UIColor whiteColor];
    topScrollerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.tableView.tableHeaderView = topScrollerView;
    //轮播时间间隔，默认1.0秒，可自定义
    topScrollerView.autoScrollTimeInterval = 2.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    YYLog(@"输入搜索关键字");
}
- (void)dealloc{
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    
}
#pragma mark 通过KVO监听tableView的滚动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"contentOffset" isEqualToString:keyPath]) {
        UITableView *tableView = (UITableView *)object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
        if (contentOffsetY >0) {//改变颜色
            CGFloat alpha = (contentOffsetY + 20) < 50 ? (contentOffsetY + 20)/50 : 1;
            self.homeNavView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
            self.homeNavView.addressBtn.titleLabel.textColor = kBlack38Color;
            [self.homeNavView.richScanBtn setImage:[UIImage imageNamed:@"home_richScan_black"] forState:UIControlStateNormal];
            [self.homeNavView.searchBar setLeftImageViewWithImage:[UIImage imageNamed:@"search_home_icon_black"]];
            [self.homeNavView.searchBar setLabelTextColor:kBlack38Color];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }
        else{
            CGFloat alpha = (contentOffsetY + 20) > 0?  (contentOffsetY + 20)/50 : 0;
            self.homeNavView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
            self.homeNavView.addressBtn.titleLabel.textColor = [UIColor whiteColor];
            [self.homeNavView.richScanBtn setImage:[UIImage imageNamed:@"home_richScan"] forState:UIControlStateNormal];
            [self.homeNavView.searchBar setLeftImageViewWithImage:[UIImage imageNamed:@"search_home_icon"]];
            [self.homeNavView.searchBar setLabelTextColor:[UIColor whiteColor]];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3 || section == 4) {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YYHomeMarkCollectionViewTableViewCell *cell = [[YYHomeMarkCollectionViewTableViewCell alloc] initWithModelsArray:self.markModelsArray];
        return cell;
    }
    else if (indexPath.section == 1){
        YYHomeThisMonthRecommendTableViewCell *cell = [YYHomeThisMonthRecommendTableViewCell homeThisMonthRecommendTableViewCellWithTableView:tableView];
        
        cell.model = self.recommendModel;
        
        return cell;
    }
    else if (indexPath.section == 2){
        YYHomePlayCollectionViewTableViewCell *cell = [[YYHomePlayCollectionViewTableViewCell alloc] initWithModelsArray:self.playModelsArray];
        return cell;
    }
    else if (indexPath.section == 3){
        YYHomeDiscoverTableViewCell *cell = [YYHomeDiscoverTableViewCell homeDiscoverTableViewCellWithTableView:tableView];
        cell.model = self.discoverModelsArray[indexPath.row];
        
        return cell;
    }
    YYHomeTravelNotesTableViewCell *cell =[YYHomeTravelNotesTableViewCell homeTravelNotesTabelViewCellWithTableView:tableView];
    
    cell.model = self.travelNotesrModelsArray[indexPath.row];
    return cell;
}

@end
