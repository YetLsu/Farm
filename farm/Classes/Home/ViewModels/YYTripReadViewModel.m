//
//  YYTripReadViewModel.m
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTripReadViewModel.h"


@interface YYTripReadViewModel ()

@property (nonatomic, strong) NSArray <YYTripReadModel *>* tripReadModelsArray;

@end

@implementation YYTripReadViewModel
- (instancetype)init{
    if (self = [super init]) {
        YYTripReadModel *model0 = [[YYTripReadModel alloc] initWithLeftImageName:@"back_black" andCellTitle:@"了解这里"];
        
        YYTripReadModel *model1 = [[YYTripReadModel alloc] initWithLeftImageName:@"back_black" andCellTitle:@"重要提示"];
        
        YYTripReadModel *model2 = [[YYTripReadModel alloc] initWithLeftImageName:@"back_black" andCellTitle:@"活动"];
        
        self.tripReadModelsArray = @[model0, model1, model2];
        
    }
    return self;
}
- (NSUInteger)getNumberSection{
    return 1;
}
- (NSUInteger)getNumberRowsOnSection:(NSUInteger)section{
    return 3;
}
- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)getTableViewHeightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)getTableViewHeightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (NSObject *)getTableViewModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.tripReadModelsArray[indexPath.row];
}
@end

@implementation YYTripReadModel

- (instancetype)initWithLeftImageName:(NSString *)imageName andCellTitle:(NSString *)title{
    if (self = [super init]) {
        self.leftImageName = imageName;
        self.cellTitle = title;
    }
    
    return self;
}

@end
