//
//  YYSpotDetailViewModel.h
//  farm
//
//  Created by wyy on 2016/12/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYBaseViewModel.h"

@class YYSightSpotHeaderBottomCollectionViewCellModel;
@interface YYSpotDetailViewModel : YYBaseViewModel
//获取tableViewHeaderView中的模型
- (YYSightSpotHeaderBottomCollectionViewCellModel *)getHeaderBottomCollectionViewCellModelWithIndexPath:(NSIndexPath *)indexPath;
@end
