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


@end

@implementation YYHomeDiscoverViewModel


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
    return 343;
}
@end
