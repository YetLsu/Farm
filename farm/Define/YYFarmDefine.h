//
//  YYFarmDefine.h
//  farm
//
//  Created by wyy on 2016/11/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#ifndef YYFarmDefine_h
#define YYFarmDefine_h


#define kWidthScreen [UIScreen mainScreen].bounds.size.width
#define kHeightScreen [UIScreen mainScreen].bounds.size.height
#define kNoNavHeight (kHeightScreen - 64)
#define kRGBAColor(r ,g ,b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kViewBGColor kRGBAColor(243, 247, 250, 1)
#define kBlack38Color kRGBAColor(38, 38, 38, 1)
#define kBlack56Color kRGBAColor(56, 56, 56, 1)

#define kGray105Color kRGBAColor(105, 105, 105, 1)
#define kGray188Color kRGBAColor(188, 188, 188, 1)
#define kGrayLine225Color kRGBAColor(225, 225, 225, 1)

#define kGreen34Color kRGBAColor(34, 187, 98, 1)

#define kNavColor kRGBAColor(153, 205, 50, 1)

#define kGray99TextColor kRGBAColor(153, 153, 153, 1)
#define kBlackTextColor kRGBAColor(56, 56, 56, 1)


#define kY12Margin (12)
#define kX12Margin (12)
//字体
#define kText14Font9Height [UIFont systemFontOfSize:9.0]
#define kText16Font10Height [UIFont systemFontOfSize:10.0]
#define kText18Font11Height [UIFont systemFontOfSize:11.0]
#define kText20Font12Height [UIFont systemFontOfSize:12.0]
#define kText22Font14Height [UIFont systemFontOfSize:14.0]
#define kText24Font15Height [UIFont systemFontOfSize:15.0]
#define kText26Font16Height [UIFont systemFontOfSize:16.0]
#define kText30Font19Height [UIFont systemFontOfSize:19.0]
#define kText40Font25Height [UIFont systemFontOfSize:25.0]
//高度
#define kHeightText14 (9.0)
#define kHeightText16 (10.0)
#define kHeightText18 (11.0)
#define kHeightText20 (12.0)
#define kHeightText22 (14.0)
#define kHeightText24 (15.0)
#define kHeightText26 (16.0)
#define kHeightText30 (19.0)
#define kHeightText40 (25.0)


#ifdef DEBUG

#define YYLog(...) NSLog(@"%s\n %@\n\n",__func__,[NSString stringWithFormat:__VA_ARGS__])
#else

#define YYLog(...)

#endif


#endif /* YYFarmDefine_h */
