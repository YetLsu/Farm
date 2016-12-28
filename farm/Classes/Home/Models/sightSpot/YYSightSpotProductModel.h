//
//  YYSightSpotProductModel.h
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSightSpotProductModel : NSObject

@property (nonatomic, copy) NSString *productID;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *productOuterImgurl;

@property (nonatomic, strong) NSArray *imgListArray;
@property (nonatomic, copy) NSString *productInnerImgList;

@property (nonatomic, copy) NSString *productPrice;

/**
 *几斤装
 */
@property (nonatomic, copy) NSString *productPackaging;
/**
 * 剩余份数
 */
@property (nonatomic, copy) NSString *productStock;
/**
 * 运费
 */
@property (nonatomic, copy) NSString *productCarriage;
/**
 * 配送范围
 */
@property (nonatomic, copy) NSString *productDelivery;
/**
 *  产品介绍
 */
@property (nonatomic, copy) NSString *productIntro;
/**
 *  温馨提示
 */
@property (nonatomic, copy) NSString *productWarmPrompt;
@end
