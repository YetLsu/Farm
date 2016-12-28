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
#import "YYSightSpotRightView.h"
#import "YYSightSpotTableViewHeaderView.h"

#import "YYSightSpotRecommendTableViewCell.h"

#import "YYSightSpotProductTableViewCell.h"
#import "YYSightSpotProductModel.h"

#import "YYSightSpotNearbyTableViewCell.h"

#import "YYSightSpotMapTableViewCell.h"

#import <MapKit/MapKit.h>

#import "YYSightSpotProductViewController.h"


@interface YYSpotDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) YYSightSpotModel *model;

@property (nonatomic, strong) YYSpotDetailViewModel *viewModel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) YYSightSpotNavView *navView;

@property (nonatomic, weak) YYSightSpotHeaderView *headerView;

@property (nonatomic, assign) CGFloat tableViewHeaderImageViewH;

@property (nonatomic, assign) CGFloat tableViewBottomViewH;

@property (nonatomic, assign) BOOL black;

@property (nonatomic, weak) YYSightSpotRightView *rightView;
@property (nonatomic, assign) CGFloat rightViewW;
//右边的页面是否显示
@property (nonatomic, assign) BOOL rightViewShow;

@property (nonatomic, strong) UIButton *tableViewCoverView;

@property (nonatomic, strong) UIWebView *introWebView;
@property (nonatomic, assign) CGFloat introWebViewH;

@property (nonatomic, strong) NSArray <YYSightSpotProductModel *>*productModelsArray;

@property (nonatomic, strong) NSArray <YYSightSpotModel *>* nearbyModelsArray;

@property (nonatomic, strong) UITableViewCell *introWebViewTableViewCell;

@property (nonatomic, strong) YYSightSpotMapTableViewCell *mapTableViewCell;

@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation YYSpotDetailViewController
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (YYSightSpotMapTableViewCell *)mapTableViewCell{
    if (!_mapTableViewCell) {
        _mapTableViewCell = [[YYSightSpotMapTableViewCell alloc] initWithSpotModel:self.model];
        _mapTableViewCell.backgroundColor = kViewBGColor;
        [_mapTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        __weak typeof(self) weakSelf = self;
        
        [_mapTableViewCell setYYMapBlock:^{
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择导航方式" delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:@"苹果地图" otherButtonTitles:nil];
           
            [sheet showInView:weakSelf.view];
        }];
    }
    
    return _mapTableViewCell;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        CLLocationCoordinate2D destCoordinate = CLLocationCoordinate2DMake(self.model.cityLat, self.model.cityLon);
        CLLocation *destLocation = [[CLLocation alloc] initWithLatitude:destCoordinate.latitude longitude:destCoordinate.longitude];
        [self.geocoder reverseGeocodeLocation:destLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *destCp = [placemarks firstObject];
            MKPlacemark *destMp = [[MKPlacemark alloc] initWithPlacemark:destCp];
            MKMapItem *destItem = [[MKMapItem alloc] initWithPlacemark:destMp];
            //获取当前位置
            MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
            
            
            // 1.将起点和终点item放入数组中
            NSArray *items = @[sourceItem, destItem];
            
            // 2.设置Options参数(字典)
            NSDictionary *options = @{
                                      MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking,
                                      MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                                      MKLaunchOptionsShowsTrafficKey : @YES
                                      };
            
            [MKMapItem openMapsWithItems:items launchOptions:options];

        }];
    }
}
- (UITableViewCell *)introWebViewTableViewCell{
    if (!_introWebViewTableViewCell) {
        self.introWebView = [[UIWebView alloc] initWithFrame:CGRectMake(kX12Margin, 0, kWidthScreen - kX12Margin * 2, 1)];
        self.introWebView.delegate = self.viewModel;
        self.introWebView.scrollView.scrollEnabled = NO;
        [self.introWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.spotIntroUrl]]];
        self.introWebView.userInteractionEnabled = NO;
        _introWebViewTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [_introWebViewTableViewCell.contentView addSubview:self.introWebView];
        _introWebViewTableViewCell.backgroundColor = kViewBGColor;
        [_introWebViewTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return _introWebViewTableViewCell;
}
- (UIButton *)tableViewCoverView{
    if (!_tableViewCoverView) {
        _tableViewCoverView = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen - self.rightViewW, kNoNavHeight)];
        [_tableViewCoverView bk_addEventHandler:^(id sender) {
            [UIView animateWithDuration:0.2 animations:^{
                self.tableView.x = 0;
                self.rightView.x = kWidthScreen;
                [_tableViewCoverView removeFromSuperview];
                self.rightViewShow = NO;
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableViewCoverView;
}

- (instancetype)initWithSpotModel:(YYSightSpotModel *)model{
    if (self = [super init]) {
        self.model = model;
        
        self.viewModel = [[YYSpotDetailViewModel alloc] initWithModel:self.model];
        self.viewModel.foldArray = [NSMutableArray array];
        [NSNumber numberWithBool:NO];
        [self.viewModel.foldArray addObjectsFromArray:@[[NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO]]];
        
        self.tableViewHeaderImageViewH = 365.0/603*kNoNavHeight;
        self.tableViewBottomViewH = 40;
        self.viewModel.tableViewHeaderTopViewH = self.tableViewHeaderImageViewH;
        self.viewModel.tableViewHeaderBottomViewH = self.tableViewBottomViewH;
        __weak typeof(self) weakSelf = self;
        [self.viewModel setYYWebViewFinshedBlock:^(CGFloat cellH) {
            weakSelf.introWebViewH = cellH;
            weakSelf.introWebView.height = cellH;
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
            [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    
    //添加子控件
    [self addSubViews];
    
    [self setTableViewHeaderView];
    
    [self.viewModel getProductModelsArrayWithSpotID:self.model.spotID andCallBack:^(NSArray *modelsArray, NSError *error) {
        if (error) {
            YYLog(@"出错");
            return;
        }
        self.productModelsArray = modelsArray;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:3];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    [self.viewModel getNearbyModelsArrayWithCallback:^(NSArray *modelsArray, NSError *error) {
        self.nearbyModelsArray = modelsArray;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:4];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }];
    
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

    tableView.frame = [UIScreen mainScreen].bounds;
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
        if (self.rightViewShow) {
            [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.view.mas_right);
            }];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.view);
            }];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [navView.rightBtn bk_addEventHandler:^(id sender) {
        YYLog(@"分享按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    
    //增加右边的策划栏
    self.rightViewW = 125 + kX12Margin;
    YYSightSpotRightView *rightView = [[YYSightSpotRightView alloc] initWithTitleArray:@[@"推荐理由", @"乡村简介", @"地图", @"农副产品", @"周边推荐"] andViewW:self.rightViewW];
    [self.view addSubview:rightView];
    rightView.frame = CGRectMake(kWidthScreen, 0, self.rightViewW, kHeightScreen);

    self.rightView = rightView;
    
    [self.rightView setYYSightSpotRightViewBlock:^(NSInteger section) {
        
        NSNumber *foldNumber = self.viewModel.foldArray[section];
        BOOL fold = foldNumber.boolValue;
        if (fold) {
            [self.viewModel.foldArray replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:NO]];
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        }
        if (section == 1) {
            self.introWebView.height = self.introWebViewH;
        }
        
        [self.tableView setContentOffset:CGPointMake(0, [self.viewModel getScrollContentOffsetYWithSection:section]) animated:YES];
        
        
    }];
    
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
        self.rightViewShow = YES;

        [self.view addSubview:self.tableViewCoverView];
        [UIView animateWithDuration:0.2 animations:^{

            self.tableView.x = - self.rightViewW;
            self.rightView.x = kWidthScreen - self.rightViewW;
        }];

    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTableViewHeaderView{
    
    
    YYSightSpotHeaderView *headerView = [[YYSightSpotHeaderView alloc] initWithHeight:self.tableViewHeaderImageViewH andBottomViewH:self.tableViewBottomViewH];
    
    [headerView.collectBtn setImage:[UIImage imageNamed:@"spot_collect_yes"] forState:UIControlStateNormal];
    [headerView.collectBtn bk_addEventHandler:^(id sender) {
        YYLog(@"收藏按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    
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
    return [self.viewModel getNumberSection];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel getNumberRowsOnSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YYSightSpotRecommendTableViewCell *cell = [YYSightSpotRecommendTableViewCell sightSpotRecommendTableViewCellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section == 1){
        return self.introWebViewTableViewCell;
    }
    else if (indexPath.section == 2){
        return self.mapTableViewCell;
    }
    else if (indexPath.section == 3){
        YYSightSpotProductTableViewCell *cell = [YYSightSpotProductTableViewCell sightSpotProductTableViewCellWithTableView:tableView];
        
        cell.model = [self.viewModel getProductModelWithIndexPath:indexPath];
        if (indexPath.row == self.productModelsArray.count - 1) {
            cell.lineView.hidden = YES;
        }
        return cell;
    }
    if (indexPath.section == 4) {
        YYSightSpotNearbyTableViewCell *cell = [YYSightSpotNearbyTableViewCell sightSpotNearbyTableViewCellWithTableView:tableView];
        
        cell.modelsArray = self.nearbyModelsArray;
        
        [cell setYYCollectionViewCellBlock:^(YYSightSpotModel *model) {
            YYLog(@"%@", model.spotTitle);
            
        }];

        return cell;

    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self.viewModel getTableViewHeightForFooterInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.viewModel getTableViewHeightForHeaderInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel getHeightForRowAtIndexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YYSightSpotTableViewHeaderView *headerView = [self.viewModel getTableViewHeaderViewWithSection:section];
    [headerView.headerBtn bk_addEventHandler:^(id sender) {
        NSNumber *number = self.viewModel.foldArray[section];
        if (number.boolValue) {
            //需要展开
            if (section == 1) {
                self.introWebView.height = self.introWebViewH;
            }
            
            [self.viewModel.foldArray replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:NO]];
            
            headerView.rightIconImageView.image = [UIImage imageNamed:@"spot_detail_header_right_icon_fold"];
            
        }
        else{
            if (section == 1) {
                self.introWebView.height = 0;
            }
            
            [self.viewModel.foldArray replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:YES]];
            
            headerView.rightIconImageView.image = [UIImage imageNamed:@"spot_detail_header_right_icon"];
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    } forControlEvents:UIControlEventTouchUpInside];
    NSNumber *number = self.viewModel.foldArray[section];
    if (number.boolValue) {
        //需要展开
        headerView.rightIconImageView.image = [UIImage imageNamed:@"spot_detail_header_right_icon_fold"];
    }
    else{
        headerView.rightIconImageView.image = [UIImage imageNamed:@"spot_detail_header_right_icon"];
    }

    return headerView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        YYSightSpotProductViewController *controller = [[YYSightSpotProductViewController alloc] initWithModel:self.productModelsArray[indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark 通过KVO监听tableView的滚动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"contentOffset" isEqualToString:keyPath]) {
        UITableView *tableView = (UITableView *)object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
//        YYLog(@"%f",contentOffsetY);
        if (contentOffsetY >20) {//改变颜色
            CGFloat alpha = contentOffsetY < 50 ? contentOffsetY/50 : 1;
            self.navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
      
            [self.navView.leftBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
            [self.navView.rightBtn setImage:[UIImage imageNamed:@"spot_share_black"] forState:UIControlStateNormal];
            
            self.black = YES;
        }
        else{
            if (contentOffsetY < 0) {
                CGFloat scale = (self.tableViewHeaderImageViewH - contentOffsetY)/self.tableViewHeaderImageViewH;
                CGFloat imageViewW = scale * kWidthScreen;
                CGFloat imageViewX = (kWidthScreen - imageViewW)/2.0;
                self.headerView.headerImageView.frame = CGRectMake(imageViewX, contentOffsetY, imageViewW, self.tableViewHeaderImageViewH - contentOffsetY);
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

#pragma mark tableView的headerView中的collectionView的数据源方法
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
