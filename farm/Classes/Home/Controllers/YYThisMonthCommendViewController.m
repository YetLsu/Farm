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

@interface YYThisMonthCommendViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *modelsArray;

@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation YYThisMonthCommendViewController

static NSString *const YYThisMonthCommendCollectionViewCellID = @"YYThisMonthCommendCollectionViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    
    self.title = @"本月推荐";
    
    [self addCollectionView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.modelsArray = @[@"12", @"12",@"12", @"12",@"12", @"12"];
        [self.collectionView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.modelsArray.count/2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    });
    
}
- (void)addCollectionView{
    
    YYLineCollectionViewFlowLayout *layout = [[YYLineCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat collectionViewTop = 64 + kY12Margin * 2;
    CGFloat itemW = kWidthScreen - (kX12Margin * 2 + 16) * 2;
    CGFloat itemH = kHeightScreen - collectionViewTop - kY12Margin * 2 * 2 - 20;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.sectionInset = UIEdgeInsetsMake(0, kX12Margin * 2, 0, kX12Margin * 2);
    layout.minimumInteritemSpacing = kX12Margin * 2;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidthScreen, itemH));
        make.top.mas_equalTo(self.view).mas_offset(collectionViewTop);
        make.left.mas_equalTo(self.view);
    }];
    collectionView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    
    
    [collectionView registerNib:[UINib nibWithNibName:@"YYThisMonthCommendCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:YYThisMonthCommendCollectionViewCellID];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView = collectionView;
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYThisMonthCommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YYThisMonthCommendCollectionViewCellID forIndexPath:indexPath];
    
    return cell;
    
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
