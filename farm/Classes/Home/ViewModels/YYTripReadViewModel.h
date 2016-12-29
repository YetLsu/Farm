//
//  YYTripReadViewModel.h
//  farm
//
//  Created by wyy on 2016/12/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYBaseViewModel.h"

@interface YYTripReadViewModel : YYBaseViewModel

@end

@interface YYTripReadModel : NSObject

@property (nonatomic, copy) NSString *leftImageName;

@property (nonatomic, copy) NSString *cellTitle;

- (instancetype)initWithLeftImageName:(NSString *)imageName andCellTitle:(NSString *)title;
@end
