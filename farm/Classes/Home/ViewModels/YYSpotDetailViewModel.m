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

#import "YYSightSpotModel.h"

#import "YYSightSpotProductModel.h"

@interface YYSpotDetailViewModel ()

@property (nonatomic, strong) YYSightSpotModel *model;

@property (nonatomic, strong) NSArray *headerBottomModelsArray;

@property (nonatomic, strong) NSArray *tableViewHeaderTitleArray;

@property (nonatomic, assign) CGFloat webViewH;

@property (nonatomic, strong) NSMutableArray <YYSightSpotProductModel *> *productModelsArray;

@end

@implementation YYSpotDetailViewModel

- (instancetype)initWithModel:(YYSightSpotModel *)model{
    if (self = [super init]) {
        self.model = model;
        
        self.productModelsArray = [NSMutableArray array];
    }
    return self;
}
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
//获取农副产品列表
- (void)getProductModelsArrayWithSpotID:(NSString *)spotID andCallBack:(void (^)(NSArray *modelsArray,NSError *error)) callback{
    YYLog(@"%@", spotID);
    NSDictionary *parameters = @{
                                 @"spotid" : spotID,
                                 };
    [NSObject GET:@"http://nc.guonongda.com:8808/app/naturalproduct/getNPList.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        if (error) {
            callback(nil, error);
            return;
        }
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            YYSightSpotProductModel *model = [YYSightSpotProductModel yy_modelWithDictionary:dic];
            [self.productModelsArray addObject:model];
            
        }
        callback(self.productModelsArray, error);
    }];
}
//获取农副产品的模型
- (YYSightSpotProductModel *)getProductModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.productModelsArray[indexPath.row];
}
- (YYSightSpotHeaderBottomCollectionViewCellModel *)getHeaderBottomCollectionViewCellModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.headerBottomModelsArray[indexPath.item];
}

- (NSUInteger)getNumberSection{
    return 5;
}
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    if (section == 3) {
        return self.productModelsArray.count;
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
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellH = 44;
    if (indexPath.section == 0) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 6;
        NSDictionary *attr = @{
                               NSFontAttributeName: kText18Font11Height,
                               NSParagraphStyleAttributeName : paragraphStyle,
                               };
        CGFloat maxW = kWidthScreen - kX12Margin * 4;
        cellH = kY12Margin + kY12Margin + [self.model.spotRecommendResult calculateHeightStringWithAttr:attr andMaxWidth:maxW andMaxHeight:CGFLOAT_MAX] + 1;
    }
    else if (indexPath.section == 1){
        return self.webViewH;
    }
    else if (indexPath.section == 3){
        cellH = 80 + kY12Margin * 2;
    }
    return cellH;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webViewH = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    if (self.YYWebViewFinshedBlock) {
        self.YYWebViewFinshedBlock(self.webViewH);
    }
}
@end
