//
//  YYTravelNotesSortView.m
//  farm
//
//  Created by wyy on 2016/12/19.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTravelNotesSortView.h"

@interface YYTravelNotesSortView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIView *bottomLineView;
@property (nonatomic, weak) UIView *greenLineView;

@property (nonatomic, strong) NSArray *sortArray;

@property (nonatomic, assign) CGFloat viewH;

@property (nonatomic, assign) CGFloat itemW;
@end

@implementation YYTravelNotesSortView

- (instancetype)initWithSortArray:(NSArray *)sortArray andViewH:(CGFloat)viewH{
    if (self = [super initWithFrame:CGRectMake(0, 0, kWidthScreen, viewH)]) {
        
        self.sortArray = sortArray;
        self.viewH = viewH;
        
        [self addSubViews];
        
        [self addConstraintsOnSubViews];
        
        
    }
    return self;
}

- (void)addSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemW = kWidthScreen/3.0;
    self.itemW = itemW;
    CGFloat itemH = self.viewH - 1;
    layout.itemSize = CGSizeMake(itemW, itemH);
    
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    layout.minimumLineSpacing = 0;
//    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 37) collectionViewLayout:layout];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[YYTravelNotesSortCollectionViewCell class] forCellWithReuseIdentifier:travelNotesSortCollectionID];
    
    self.collectionView.scrollEnabled = NO;
    
    UIView *bottomLineView = [[UIView alloc] init];
    [self addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
    self.bottomLineView.backgroundColor = kGrayLine225Color;
    
    UIView *greenLineView = [[UIView alloc] init];
    [self addSubview:greenLineView];
    self.greenLineView = greenLineView;
    self.greenLineView.backgroundColor = kGreen34Color;
}
- (void)addConstraintsOnSubViews{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-1);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.greenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomLineView.mas_top);
        make.width.mas_equalTo(self.itemW);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self);
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sortArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YYTravelNotesSortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:travelNotesSortCollectionID forIndexPath:indexPath];
    
    cell.sortLabel.text = self.sortArray[indexPath.item];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat leftOffset = indexPath.item * self.itemW;
    if (self.YYCollectionViewCellClick) {
        self.YYCollectionViewCellClick(self.sortArray[indexPath.item]);
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.greenLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftOffset);
        }];
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end


@implementation YYTravelNotesSortCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.sortLabel = label;
        
        [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.contentView);
        }];
        
        self.sortLabel.textColor = kBlack56Color;
        self.sortLabel.font = kText22Font14Height;
        self.sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}
@end
