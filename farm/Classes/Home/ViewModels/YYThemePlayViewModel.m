//
//  YYThemePlayViewModel.m
//  farm
//
//  Created by wyy on 2016/12/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYThemePlayViewModel.h"
#import "YYThemePlayModel.h"

@interface YYThemePlayViewModel ()

@end
@implementation YYThemePlayViewModel

- (void)getModelsArrayWithParameters:(NSDictionary *)parameters andCallBack:(void (^)(NSArray *, NSError *))callback{
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/themetag/getThemeTagListMore.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if ([responseObject isEqual:[NSNull null]]) {
            callback(nil, [[NSError alloc] init]);
            return;
        }
        NSArray *data = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            YYThemePlayModel *model = [YYThemePlayModel yy_modelWithDictionary:dic];
            [array addObject:model];
        }
        if (array.count < self.pageNumber) {
            NSError *error = [[NSError alloc] initWithDomain:@"123" code:kNoMoreTableViewDataCode userInfo:nil];
            callback(array, error);
        }
        else{
            callback(array, nil);
        }
        
    }];

}
- (NSUInteger)getNumberSection{
    return 1;
}
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    return self.modelsArray.count;
}
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 205+ kY12Margin;
}
- (YYThemePlayModel *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.modelsArray[indexPath.row];
}
@end
