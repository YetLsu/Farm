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


@interface YYHomeMarkCollectionViewTableViewCell (){
    
}

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *marksModelArray;
@property (nonatomic, strong) YYHomeViewModel *viewModel;

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
        
        self.viewModel = [[YYHomeViewModel alloc] initCollectionViewModelWithMarkModelsArray:modelsArray];
        [self.viewModel setYYCollectionViewCellClickBlock:^{
            YYLog(@"mdzz");
        }];
        collectionView.delegate = self.viewModel;
        collectionView.dataSource = self.viewModel;

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

@end
