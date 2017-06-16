//
//  YYThisMonthCommendViewController.m
//  farm
//
//  Created by wyy on 2016/12/7.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThisMonthCommendViewController.h"

#import "YYLineCollectionViewFlowLayout.h"

#import "YYThisMonthCommendCollectionViewCell.h"

#import "YYThisMonthCommendViewModel.h"

#import "YYHomeThisMonthRecommendModel.h"

#import "YYSpotDetailViewController.h"

@interface YYThisMonthCommendViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *modelsArray;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong)YYThisMonthCommendViewModel *viewModel;

@property (nonatomic, assign) CGFloat itemW;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger lastIndex;

@property (nonatomic, strong) YYHomeThisMonthRecommendModel *model;
@end

@implementation YYThisMonthCommendViewController

static NSString *const YYThisMonthCommendCollectionViewCellID = @"YYThisMonthCommendCollectionViewCell";
- (instancetype)initWithModel:(YYHomeThisMonthRecommendModel *)model{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
- (YYThisMonthCommendViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYThisMonthCommendViewModel alloc] init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    
    self.title = @"本月推荐";
    
    [self addCollectionViewAndPageControl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"area"] = self.model.cityName;
    YYUserModel *userModel = [YYUserTool userModel];
    if (userModel.lon) {
        parameters[@"lon"] = userModel.lon;
        parameters[@"lat"] = userModel.lat;
    }
    else{
        parameters[@"lon"] = @"120";
        parameters[@"lat"] = @"30";
 
    }
    parameters[@"username"] = userModel.name;
    [self.viewModel getThisMonthCommendModelsArrayWithParameters:parameters andCallback:^(NSArray<YYSightSpotModel *> *modelsArray, NSError *error) {
        if (error) {
            return ;
        }
        self.modelsArray = modelsArray;
    
        [self.collectionView reloadData];
        
        self.lastIndex = self.modelsArray.count/2 - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.lastIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.pageControl.numberOfPages = self.modelsArray.count;
        self.pageControl.currentPage = self.lastIndex;
        
        [self.pageControl bk_addEventHandler:^(UIPageControl *sender) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.currentPage inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
        } forControlEvents:UIControlEventValueChanged];
    }];
      
}
- (void)addCollectionViewAndPageControl{
    
    YYLineCollectionViewFlowLayout *layout = [[YYLineCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat collectionViewTop = 64 + kY12Margin * 2;
    self.itemW = kWidthScreen - (kX12Margin * 2 + 16) * 2;
    CGFloat itemH = kHeightScreen - collectionViewTop - kY12Margin * 2 * 2 - 20;
    layout.itemSize = CGSizeMake(self.itemW, itemH);
    layout.sectionInset = UIEdgeInsetsMake(0, kX12Margin * 2, 0, kX12Margin * 2);
    layout.minimumInteritemSpacing = kX12Margin * 2;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidthScreen, itemH));
        make.top.mas_equalTo(self.view).mas_offset(collectionViewTop);
        make.left.mas_equalTo(self.view);
    }];
    collectionView.backgroundColor = [UIColor clearColor];
    
    
    [collectionView registerNib:[UINib nibWithNibName:@"YYThisMonthCommendCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:YYThisMonthCommendCollectionViewCellID];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView = collectionView;
    
    //添加pageControl
    CGFloat pageControlBottomOffset = kY12Margin * 2;
    CGFloat pageControlH = 20;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(pageControlH);
        make.bottom.mas_equalTo(self.view).mas_offset(-pageControlBottomOffset);
    }];
    pageControl.pageIndicatorTintColor = kGray188Color;
    pageControl.currentPageIndicatorTintColor = kGreen34Color;
    self.pageControl = pageControl;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYThisMonthCommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YYThisMonthCommendCollectionViewCellID forIndexPath:indexPath];
    cell.itemW = self.itemW;
    cell.model = self.modelsArray[indexPath.item];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat centerX = scrollView.center.x + scrollView.contentOffset.x;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(centerX, scrollView.center.y)];
    
    if (self.lastIndex != 1 && indexPath.item == 0) {
        return;
    }
    self.lastIndex = indexPath.item;
    self.pageControl.currentPage = indexPath.item;
    
}

- (nullable NSIndexPath *)indexPathForItemAtPoint:(CGPoint)point{
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YYSightSpotModel *model = self.modelsArray[indexPath.item];
    YYSpotDetailViewController *VC = [[YYSpotDetailViewController alloc] initWithSpotModel:model];
    [self.navigationController pushViewController:VC animated:YES];
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
