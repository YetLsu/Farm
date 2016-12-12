//
//  YYThisMonthCommendTagsView.m
//  farm
//
//  Created by wyy on 2016/12/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThisMonthCommendTagsView.h"
#import "YYThisMonthTagCollectionViewCell.h"
@interface YYThisMonthCommendTagsView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;



@end
@implementation YYThisMonthCommendTagsView

static NSString * const YYThisMonthTagCollectionViewCellID = @"YYThisMonthTagCollectionViewCell";

//- (instancetype)initWithTagsArray:(NSArray *)tagsArray{
//    if (self = [super initWithFrame:CGRectZero]) {
//        self.tagsArray = tagsArray;
//        [self addSubViewAndSetView];
//        
//    }
//    return self;
//}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self addSubViewAndSetView];
}
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self addSubViewAndSetView];
//    }
//    return self;
//}

- (void)addSubViewAndSetView{

    //view的背景颜色
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = kX12Margin;
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
    
    [collectionView registerClass:[YYThisMonthTagCollectionViewCell class] forCellWithReuseIdentifier:YYThisMonthTagCollectionViewCellID];
    
    collectionView.scrollEnabled = NO;
    
}

- (void)setTagsArray:(NSArray *)tagsArray{
    _tagsArray = tagsArray;
 
    [self.collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    YYLog(@"%lu",(unsigned long)self.tagsArray.count);
    return self.tagsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YYThisMonthTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YYThisMonthTagCollectionViewCellID forIndexPath:indexPath];
    
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
