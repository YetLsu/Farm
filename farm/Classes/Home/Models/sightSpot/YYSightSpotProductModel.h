//
//  YYSightSpotProductModel.h
//  farm
//
//  Created by wyy on 2016/12/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSightSpotProductModel : NSObject
//id":1,"spotid":"8810c2051d7041e4bf0c3a9edcd2fbc6","pro_name":"安昌香肠","outerImgurl":"http://nc.guonongda.com:8808/pic/naturalproducts/xiangchang1.jpg","innerImgurllist":"http://nc.guonongda.com:8808/pic/naturalproducts/xiangchang1.jpg|http://nc.guonongda.com:8808/pic/naturalproducts/xiangchang2.jpg|http://nc.guonongda.com:8808/pic/naturalproducts/xiangchang3.jpg","price":"88/斤","packaging":"2斤装","pro_stock":"888份","carriage":"免运费","delivery":"全国（除内蒙古自治区、湖南省、西藏自治区、新疆维吾尔自治区）可配送","pro_intro":"","warm_prompt":""

@property (nonatomic, copy) NSString *productID;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *productOuterImgurl;

@property (nonatomic, copy) NSString *productPrice;

/**
 几斤装
 */
@property (nonatomic, copy) NSString *productPackaging;
@end
