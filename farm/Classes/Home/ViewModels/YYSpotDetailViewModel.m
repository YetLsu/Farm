//
//  YYSpotDetailViewModel.m
//  farm
//
//  Created by wyy on 2016/12/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSpotDetailViewModel.h"
#import "YYSightSpotHeaderView.h"
#import "YYSightSpotTableViewHeaderView.h"

@interface YYSpotDetailViewModel ()

@property (nonatomic, strong) NSArray *headerBottomModelsArray;

@property (nonatomic, strong) NSArray *tableViewHeaderTitleArray;

@end

@implementation YYSpotDetailViewModel
- (NSArray *)tableViewHeaderTitleArray{
    if (!_tableViewHeaderTitleArray) {
        _tableViewHeaderTitleArray = @[@"推荐理由", @"乡村简介", @"地图", @"农副产品", @"周边推荐"];
    }
    return _tableViewHeaderTitleArray;
}
- (NSArray *)headerBottomModelsArray{
    if (!_headerBottomModelsArray) {
        YYSightSpotHeaderBottomCollectionViewCellModel *model0 = [[YYSightSpotHeaderBottomCollectionViewCellModel alloc] init];
        model0.imageW = 20;
        model0.imageName = @"spot_goread";
        model0.title = @"出行必读";
        
        YYSightSpotHeaderBottomCollectionViewCellModel *model1 = [[YYSightSpotHeaderBottomCollectionViewCellModel alloc] init];
        model1.imageW = 13;
        model1.imageName = @"spot_howarrive";
        model1.title = @"如何到达";
        
        YYSightSpotHeaderBottomCollectionViewCellModel *model2 = [[YYSightSpotHeaderBottomCollectionViewCellModel alloc] init];
        model2.imageW = 12;
        model2.imageName = @"spot_travelNote";
        model2.title = @"游记";
        _headerBottomModelsArray = @[model0, model1, model2];
    }
    return _headerBottomModelsArray;
}
- (YYSightSpotHeaderBottomCollectionViewCellModel *)getHeaderBottomCollectionViewCellModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.headerBottomModelsArray[indexPath.item];
}

- (NSUInteger)getNumberSection{
    return 5;
}
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    if (section == 3) {
        return 2;
    }
    return 1;
}
//组头的View
- (YYSightSpotTableViewHeaderView *)getTableViewHeaderViewWithSection:(NSInteger)section{
    
    YYSightSpotTableViewHeaderView *headerView = [[YYSightSpotTableViewHeaderView alloc] initWithTitle:self.tableViewHeaderTitleArray[section] andHeaderViewH:(kY12Margin + 40)];
    
    return headerView;
}
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section{
    return kY12Margin + 40;
}
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
@end
