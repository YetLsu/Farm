//
//  YYHomeMarkCollectionViewTableViewCell.m
//  farm
//
//  Created by wyy on 2016/11/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeMarkCollectionViewTableViewCell.h"
#import "YYHomeMarkCollectionViewCell.h"
#import "YYHomeCollectionViewCellModel.h"

#import "YYHomeViewModel.h"


@interface YYHomeMarkCollectionViewTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    
}

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *marksModelArray;

@end

@implementation YYHomeMarkCollectionViewTableViewCell

- (instancetype)initWithModelsArray:(NSArray *)modelsArray{
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        
        self.marksModelArray = modelsArray;
        
        CGFloat itemW = 53;
        CGFloat itemH = 74;
        CGFloat left = 35;
        CGFloat xMargin = 32;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(kY12Margin, left, kY12Margin, left);
        layout.minimumLineSpacing = xMargin;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.showsHorizontalScrollIndicator = NO;

        [self.contentView addSubview:collectionView];
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(itemH + 2 * kY12Margin);
        }];
        [collectionView registerNib:[UINib nibWithNibName:@"YYHomeMarkCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:homeMarkCollectionID];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;

    }
    return self;
}

#pragma mark collectionView的数据源方法
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.marksModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYHomeMarkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeMarkCollectionID forIndexPath:indexPath];
    cell.model = self.marksModelArray[indexPath.item];
    return cell;
}
#pragma mark collectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YYHomeCollectionViewCellModel *model = self.marksModelArray[indexPath.item];
//    YYLog(@"%@", model.markName);
    if (self.YYCollectionViewCellClickBlock) {
        self.YYCollectionViewCellClickBlock(model);
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
