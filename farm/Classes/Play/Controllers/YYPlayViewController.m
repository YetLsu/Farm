//
//  YYPlayViewController.m
//  farm
//
//  Created by wyy on 2016/11/16.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPlayViewController.h"
#import "NFPlayCollectionViewCell.h"
#import "NFInnerPlayViewController.h"
#import "NFCardFlowLayout.h"
#import "NFPlayModel.h"

@interface YYPlayViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

static NSString *const cellIdentifierId = @"cellIdentifierId";
@implementation YYPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
    [self setupContent];
}
- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)requestData{
    NSString *url = @"http://nc.guonongda.com:8808/app/travelplaying/queryTravelCity.do";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    YYUserModel *model = [YYUserTool userModel];
    
    parameters[@"cityname"] = model.userCity;
    parameters[@"lon"] = model.lon;
    parameters[@"lat"] = model.lat;
    [NSObject GET:url parameters:parameters progress:nil completionHandler:^(id responseObject, NSError *error) {
        NSArray *data = responseObject[@"data"];
        
        for (NSDictionary *dic in data) {
            NFPlayModel *model = [NFPlayModel yy_modelWithDictionary:dic];
            [self.datasource addObject:model];
        }
        
        [self.collectionView reloadData];

    }];
}

- (void)setupContent{
    self.view.backgroundColor = kRGBAColor(242, 247, 250, 1);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen, kHeightScreen - 64)];
    bgView.backgroundColor = kRGBAColor(242, 247, 250, 1);
    [self.view addSubview:bgView];
    
    
    CGFloat padding = 30;
    NFCardFlowLayout *layout = [[NFCardFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = padding -12.5;
    layout.minimumInteritemSpacing = padding -10;
    layout.sectionInset = UIEdgeInsetsMake(0, padding, 0, padding);
    CGFloat itemW = kWidthScreen - padding*2;
    CGFloat itemH = bgView.bounds.size.height - padding * 3;
    layout.itemSize = CGSizeMake(itemW, itemH);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, padding, bgView.bounds.size.width, bgView.bounds.size.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"NFPlayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifierId];
    [self.view addSubview: _collectionView];
    
}

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.datasource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NFPlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifierId forIndexPath:indexPath];
    cell.model = _datasource[indexPath.row];
    return cell;
}

#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NFPlayModel *model = _datasource[indexPath.row];
    NFInnerPlayViewController *innerPlayerVC = [[NFInnerPlayViewController alloc] init];
    innerPlayerVC.model = model;
    [self.navigationController pushViewController:innerPlayerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
