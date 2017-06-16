//
//  YYHomePlayCollectionViewTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomePlayCollectionViewTableViewCell.h"

#import "YYHomeThemePlayCollectionViewCell.h"

#import "YYHomeCollectionViewCellModel.h"

#import "YYThemePlayModel.h"


@interface YYHomePlayCollectionViewTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *playModelsArray;
@end

@implementation YYHomePlayCollectionViewTableViewCell

- (instancetype)initWithModelsArray:(NSArray <YYHomeCollectionViewCellModel *>*)modelsArray{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        
        self.playModelsArray = modelsArray;
        
        CGFloat left = 12;
        CGFloat xMargin = 10;
        CGFloat itemW = (kWidthScreen - left * 2 - xMargin * 2)/3;
        CGFloat itemH = 96;
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(0, left, kY12Margin, left);
        layout.minimumLineSpacing = xMargin;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        
        [self.contentView addSubview:collectionView];
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(itemH + kY12Margin);
        }];
        [collectionView registerNib:[UINib nibWithNibName:@"YYHomeThemePlayCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:homePlayCollectionID];
        

        collectionView.delegate = self;
        collectionView.dataSource = self;
        
    }
    return self;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.playModelsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYHomeThemePlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homePlayCollectionID forIndexPath:indexPath];
    cell.model = self.playModelsArray[indexPath.item];
    return cell;
}
#pragma mark 第一个单元格中的collectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
#warning TODO 首页主题游下面的小图点击跳转！
    
     YYThemePlayModel *model = self.playModelsArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(pushWithModel:)]) {
        [self.delegate performSelector:@selector(pushWithModel:) withObject:model];
    }
    
}

@end
