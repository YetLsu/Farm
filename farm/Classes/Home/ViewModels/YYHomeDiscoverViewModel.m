//
//  YYHomeDiscoverViewModel.m
//  farm
//
//  Created by wyy on 2016/12/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeDiscoverViewModel.h"
#import "YYHomeDiscoverModel.h"

@interface YYHomeDiscoverViewModel ()

@property (nonatomic, assign) CGFloat bgViewNoContentLabelH;
@end

@implementation YYHomeDiscoverViewModel
- (instancetype)init{
    if (self = [super init]) {
        CGFloat discoverImageViewLeftOffset = kX12Margin;
        CGFloat discoverImageViewW = kWidthScreen - discoverImageViewLeftOffset * 2;
        CGFloat scale = discoverImageViewW/(375.0 - 12 * 2);
        CGFloat discoverImageViewH = 205 * scale;
        
        CGFloat discoverTitleLabelTop = kY12Margin;
        CGFloat discoverTitleLabelH = kHeightText22;
        
        CGFloat discoverContentLabelTop = 10 - 2.5;
        CGFloat discoverContentLabelBootom = 10;
        
        CGFloat timeIconImageViewH = 10;
        
        self.bgViewNoContentLabelH = discoverImageViewH + discoverTitleLabelTop + discoverTitleLabelH + discoverContentLabelTop + discoverContentLabelBootom + timeIconImageViewH + kY12Margin;
    }
    return self;
}

/**
 获取发现的内容
 */
- (void)getModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *, NSError *))callback{
    [NSObject GET:@"http://nc.guonongda.com:8808/app/discover/getDiscoverList.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSArray *data = responseObject[@"data"];
        NSMutableArray *discoverArray = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYHomeDiscoverModel *model = [YYHomeDiscoverModel yy_modelWithDictionary:dic];
            [discoverArray addObject:model];
            
        }
        if (discoverArray.count < self.pageNumber) {
            NSError *error = [[NSError alloc] initWithDomain:@"123" code:kNoMoreTableViewDataCode userInfo:nil];
            callback(discoverArray, error);
        }
        else{
            callback(discoverArray, nil);
        }
        
    }];

}
- (NSUInteger)getNumberSection{
    return self.modelsArray.count;
}
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    return 1;
}
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section{
    return kY12Margin;
}
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YYHomeDiscoverModel *model = self.modelsArray[indexPath.section];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:model.content];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attr = @{
                           NSFontAttributeName : kText16Font10Height,
                           NSParagraphStyleAttributeName : paragraphStyle
                           };
    [attributedStr addAttributes:attr range:NSMakeRange(0, attributedStr.length)];
    
    CGFloat maxContentLabelW = kWidthScreen - kX12Margin * 4;
    CGFloat maxContentLabelH = 66;
    
    CGFloat contentLabelH = [model.content calculateHeightStringWithAttr:attr andMaxWidth:maxContentLabelW andMaxHeight:maxContentLabelH] + 0.1;
    YYLog(@"%f",contentLabelH);
    
    return self.bgViewNoContentLabelH + contentLabelH;
}
- (YYHomeDiscoverModel *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.modelsArray[indexPath.section];
}

@end
