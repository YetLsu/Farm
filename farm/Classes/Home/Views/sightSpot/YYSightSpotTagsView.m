//
//  YYSightSpotTagsView.m
//  farm
//
//  Created by wyy on 2016/12/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotTagsView.h"
#import "YYSightSpotTagCollectionViewCell.h"

@interface YYSightSpotTagsView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;



@end

@implementation YYSightSpotTagsView
static NSString * const YYSightSpotTagCollectionViewCellID = @"YYSightSpotTagCollectionViewCell";

- (instancetype)initWithTagsArray:(NSArray *)tagsArray{
    if (self = [super initWithFrame:CGRectZero]) {
        self.tagsArray = tagsArray;
        [self addSubViewAndSetView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViewAndSetView];
    }
    return self;
}

- (void)addSubViewAndSetView{
       

    
    //view的背景颜色
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(kY12Margin/2.0, kX12Margin, kY12Margin/2.0, kX12Margin);
    layout.minimumLineSpacing = kY12Margin/2.0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //collectionView的背景颜色
    collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    [collectionView registerClass:[YYSightSpotTagCollectionViewCell class] forCellWithReuseIdentifier:YYSightSpotTagCollectionViewCellID];
    
    collectionView.scrollEnabled = NO;
    
}

- (void)setTagsArray:(NSArray *)tagsArray{
    _tagsArray = tagsArray;
}

 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    YYLog(@"%lu",(unsigned long)self.tagsArray.count);
    return self.tagsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YYSightSpotTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YYSightSpotTagCollectionViewCellID forIndexPath:indexPath];
    
    cell.tagLabel.text = self.tagsArray[indexPath.item];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = self.tagsArray[indexPath.row];
    NSDictionary *attr = @{
                           NSFontAttributeName : kText16Font10Height
                           };
    CGFloat width = [str calculateWidthStringWithAttr:attr andMaxWidth:200 andMaxHeight:kHeightText16] + kX12Margin;
    return CGSizeMake(width, 18);
}
@end
