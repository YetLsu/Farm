//
//  YYProductTableViewHeaderView.m
//  farm
//
//  Created by wyy on 2016/12/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProductTableViewHeaderView.h"
#import <SDCycleScrollView.h>

#import "YYSightSpotProductModel.h"

@interface YYProductTableViewHeaderView ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) SDCycleScrollView *imagesView;
//@property (nonatomic, weak) UIView *imageView;

@property (nonatomic, assign) CGFloat topImageViewH;

@property (nonatomic, assign) CGFloat bottomViewNoDeliveryLabelH;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *priceLabel;
/**
 * 剩余份数
 */
@property (nonatomic, weak) UILabel *stockLabel;
@property (nonatomic, weak) UIView *lineView;

/**
 * 运费
 */
@property (nonatomic, weak) UILabel *carriageLabel;
/**
 * 可配送范围
 */
@property (nonatomic, weak) UILabel *deliveryLabel;

@property (nonatomic, strong) YYSightSpotProductModel *model;

@end

@implementation YYProductTableViewHeaderView

- (void)setModel:(YYSightSpotProductModel *)model andCallback:(void (^)(CGFloat))callback{
    self.model = model;
    
    self.imagesView.imageURLStringsGroup = self.model.imgListArray;
    
    self.nameLabel.text = self.model.productName;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", self.model.productPrice];
    
    self.stockLabel.text = [NSString stringWithFormat:@"剩余%@", self.model.productStock];
    
    self.carriageLabel.text = [NSString stringWithFormat:@"运费：%@", self.model.productCarriage];
    
    UIFont *deliveryFont = kText18Font11Height;
    NSMutableAttributedString *deliveryStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"配送：%@", self.model.productDelivery]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    NSDictionary *attr = @{
                           NSFontAttributeName : deliveryFont,
                           NSParagraphStyleAttributeName : paragraphStyle,
                           };
    [deliveryStr addAttributes:attr range:NSMakeRange(0, self.model.productDelivery.length)];
    
    self.deliveryLabel.attributedText = deliveryStr;
    
    CGFloat deliveryLabelH = [self.model.productDelivery calculateHeightStringWithAttr:attr andMaxWidth:(kWidthScreen - 2 * kX12Margin) andMaxHeight:CGFLOAT_MAX];
    [self.deliveryLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(deliveryLabelH);
    }];
    
    self.bgView.frame = CGRectMake(0, 0, kWidthScreen, self.topImageViewH + self.bottomViewNoDeliveryLabelH + deliveryLabelH);
    callback(self.topImageViewH + self.bottomViewNoDeliveryLabelH + deliveryLabelH);
}
- (instancetype)initWithTopImageViewH:(CGFloat)topImageViewH andFrame:(CGRect)viewFrame{
    if (self = [super initWithFrame:viewFrame]) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.topImageViewH = topImageViewH;
        
        [self addSubViews];
        
        [self setConstraints];
        
        [self setViews];
    }
    return self;
}
- (void)addSubViews{
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    SDCycleScrollView *imagesView = [[SDCycleScrollView alloc] init];
    [self addSubview:imagesView];
    self.imagesView = imagesView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    //剩余份数
    UILabel *stockLabel = [[UILabel alloc] init];
    [self addSubview:stockLabel];
    self.stockLabel = stockLabel;
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    //运费
    UILabel *carriageLabel = [[UILabel alloc] init];
    [self addSubview:carriageLabel];
    self.carriageLabel = carriageLabel;
    
    //可配送范围
    UILabel *deliveryLabel = [[UILabel alloc] init];
    [self addSubview:deliveryLabel];
    self.deliveryLabel = deliveryLabel;
}

- (void)setConstraints{
    self.imagesView.frame = CGRectMake(0, 0, kWidthScreen, self.topImageViewH);
    
    CGFloat nameLabelH = kHeightText22;
    CGFloat nameLabelY = 15 + self.imagesView.y + self.imagesView.height;
    CGFloat nameLabelW = kWidthScreen - kX12Margin * 2;
    self.nameLabel.frame = CGRectMake(kX12Margin, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat priceLabelH = kHeightText24;
    CGFloat priceLabelTop = 10;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(priceLabelH);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(priceLabelTop);
    }];
    
    CGFloat stockLabelH = kHeightText18;
    CGFloat stockLabelTop = 6;
    [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(stockLabelH);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(stockLabelTop);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.stockLabel.mas_bottom).mas_offset(kY12Margin - 0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    CGFloat carriageLabelH = kHeightText18;
    CGFloat carriageLabelTop = kY12Margin;
    [self.carriageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.height.mas_equalTo(carriageLabelH);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(carriageLabelTop);
    }];
    
    CGFloat deliveryLabelTop = 7;
    [self.deliveryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.carriageLabel);
        make.top.mas_equalTo(self.carriageLabel.mas_bottom).mas_offset(deliveryLabelTop);
    }];
    
    self.bottomViewNoDeliveryLabelH = 15 + nameLabelH + priceLabelTop + priceLabelH + stockLabelTop + stockLabelH + kY12Margin + carriageLabelTop + carriageLabelH + deliveryLabelTop + kY12Margin;
}

- (void)setViews{
    self.nameLabel.font = kText22Font14Height;
    self.nameLabel.textColor = kBlack56Color;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
//    self.nameLabel.backgroundColor = [UIColor grayColor];
    
    
    self.priceLabel.font = kText24Font15Height;
    self.priceLabel.textColor = kRGBAColor(248, 100, 0, 1);
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
//    self.priceLabel.backgroundColor = [UIColor purpleColor];
    
    self.stockLabel.font = kText18Font11Height;
    self.stockLabel.textColor = kGray188Color;
    self.stockLabel.textAlignment = NSTextAlignmentCenter;
//    self.stockLabel.backgroundColor = [UIColor blueColor];
    
    self.carriageLabel.font = kText18Font11Height;
    self.carriageLabel.textColor = kGray105Color;
//    self.carriageLabel.backgroundColor = [UIColor orangeColor];
    
    self.deliveryLabel.font = kText18Font11Height;
    self.deliveryLabel.textColor = kGray105Color;
    self.deliveryLabel.numberOfLines = 0;
//    self.deliveryLabel.backgroundColor = [UIColor greenColor];
    
    self.lineView.backgroundColor = kGrayLine225Color;
}

@end
