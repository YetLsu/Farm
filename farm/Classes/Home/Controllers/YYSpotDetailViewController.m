//
//  YYSpotDetailTableViewController.m
//  farm
//
//  Created by wyy on 2016/12/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSpotDetailViewController.h"
#import "YYSpotDetailViewModel.h"
#import "YYSightSpotModel.h"
#import "YYSightSpotNavView.h"
#import "YYSightSpotHeaderView.h"

@interface YYSpotDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) YYSightSpotModel *model;

@property (nonatomic, strong) YYSpotDetailViewModel *viewModel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) YYSightSpotNavView *navView;

@property (nonatomic, weak) YYSightSpotHeaderView *headerView;

@property (nonatomic, assign) CGFloat tableViewHeaderImageViewH;

@property (nonatomic, assign) BOOL black;

@property (nonatomic, weak) UIView *rightView;

@end

@implementation YYSpotDetailViewController
- (instancetype)initWithSpotModel:(YYSightSpotModel *)model{
    if (self = [super init]) {
        self.model = model;
        self.viewModel = [[YYSpotDetailViewModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    
    
    //添加子控件
    [self addSubViews];
    
    [self setTableViewHeaderView];
    
    //增加KVO
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //增加导航栏
    
    YYSightSpotNavView *navView = [[YYSightSpotNavView alloc] initWithLeftBtnW:10.5 andRightBtnW:22];
    [self.view addSubview:navView];
    self.navView = navView;
    navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [navView.leftBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [navView.rightBtn setImage:[UIImage imageNamed:@"spot_share_white"] forState:UIControlStateNormal];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    [navView.leftBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [navView.rightBtn bk_addEventHandler:^(id sender) {
        YYLog(@"分享按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    //增加回到顶部的按钮
    UIButton *topBtn = [[UIButton alloc] init];
    [self.view addSubview:topBtn];
    CGFloat topBtnBottom = 68/603.0*kNoNavHeight;
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-kX12Margin);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.bottom.mas_equalTo(self.view).mas_offset(-topBtnBottom);
    }];
    [topBtn setImage:[UIImage imageNamed:@"spot_top"] forState:UIControlStateNormal];
    [topBtn bk_addEventHandler:^(id sender) {
        
        [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //增加调出侧边栏的按钮
    UIButton *rightAllBtn = [[UIButton alloc] init];
    [self.view addSubview:rightAllBtn];
    [rightAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-kX12Margin);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.bottom.mas_equalTo(topBtn.mas_top).mas_offset(-kY12Margin);
    }];
    [rightAllBtn setImage:[UIImage imageNamed:@"spot_rightAll"] forState:UIControlStateNormal];
    [rightAllBtn bk_addEventHandler:^(id sender) {
        [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_right).mas_offset(-100);
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(-100);
        }];
        YYLog(@"qqwe");
    } forControlEvents:UIControlEventTouchUpInside];
    
    //增加右边的策划栏
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_right);
        make.top.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
    self.rightView = rightView;
}

- (void)setTableViewHeaderView{
    
    self.tableViewHeaderImageViewH = 365.0/603*kNoNavHeight;
    CGFloat bottomViewH = 40;
    YYSightSpotHeaderView *headerView = [[YYSightSpotHeaderView alloc] initWithHeight:self.tableViewHeaderImageViewH andBottomViewH:bottomViewH];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.model = self.model;
    
    self.headerView.headerBottomCollectionView.dataSource = self;
    self.headerView.headerBottomCollectionView.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"123";
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
#pragma mark 通过KVO监听tableView的滚动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"contentOffset" isEqualToString:keyPath]) {
        UITableView *tableView = (UITableView *)object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
        
        if (contentOffsetY >20) {//改变颜色
            CGFloat alpha = contentOffsetY < 50 ? contentOffsetY/50 : 1;
            self.navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
      
            [self.navView.leftBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
            [self.navView.rightBtn setImage:[UIImage imageNamed:@"spot_share_black"] forState:UIControlStateNormal];
            
            self.black = YES;
        }
        else{
            if (contentOffsetY < 0) {
                [self.headerView.headerImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.headerView).mas_offset(contentOffsetY);
                    make.height.mas_equalTo(self.tableViewHeaderImageViewH - contentOffsetY);
                }];
            }
            CGFloat alpha = contentOffsetY > 0 ?  contentOffsetY/50 : 0;
            self.navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
            [self.navView.leftBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
            [self.navView.rightBtn setImage:[UIImage imageNamed:@"spot_share_white"] forState:UIControlStateNormal];
            
            self.black = NO;
            
        }
        [self setNeedsStatusBarAppearanceUpdate];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.black) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}
- (void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYSightSpotHeaderBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sightSpotHeaderBottomCollectionViewCellID forIndexPath:indexPath];
    
    cell.model = [self.viewModel getHeaderBottomCollectionViewCellModelWithIndexPath:indexPath];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YYSightSpotHeaderBottomCollectionViewCellModel *model = [self.viewModel getHeaderBottomCollectionViewCellModelWithIndexPath:indexPath];
    YYLog(@"%@", model.title);
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
