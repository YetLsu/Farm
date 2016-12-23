//
//  YYSightSpotHeaderView.m
//  farm
//
//  Created by wyy on 2016/12/21.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotHeaderView.h"
#import "YYSightSpotModel.h"

@interface YYSightSpotHeaderView ()

@property (nonatomic, assign) CGFloat headerImageViewH;

@property (nonatomic, assign) CGFloat bottomViewH;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *addressLabel;

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UILabel *distanceLabel;

@property (nonatomic, weak) UILabel *expenseLabel;



@end

@implementation YYSightSpotHeaderView
- (instancetype)initWithHeight:(CGFloat)headerImageViewH andBottomViewH:(CGFloat)bottomViewH{
    if (self = [super initWithFrame:CGRectMake(0, 0, kWidthScreen, headerImageViewH + bottomViewH)]) {
        self.bottomViewH = bottomViewH;
        self.headerImageViewH = headerImageViewH;
        self.backgroundColor = [UIColor clearColor];
        [self addSubViews];
        
        [self setConstraintsOnSubViews];
        
        [self setViews];
        
    }
    return self;
}
- (void)addSubViews{
    UIImageView *headerImageView = [[UIImageView alloc] init];
    [self addSubview:headerImageView];
    self.headerImageView = headerImageView;
   
    UIButton *collectBtn = [[UIButton alloc] init];
    [self addSubview:collectBtn];
    self.collectBtn = collectBtn;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;

    UILabel *addressLabel = [[UILabel alloc] init];
    [self addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    [self addSubview:distanceLabel];
    self.distanceLabel = distanceLabel;
    
    UILabel *expenseLabel = [[UILabel alloc] init];
    [self addSubview:expenseLabel];
    self.expenseLabel = expenseLabel;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = kWidthScreen/3.0;
    layout.itemSize = CGSizeMake(itemW, self.bottomViewH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.scrollEnabled = NO;
    [self addSubview:collectionView];
    self.headerBottomCollectionView = collectionView;
    
    [self.headerBottomCollectionView registerClass:[YYSightSpotHeaderBottomCollectionViewCell class] forCellWithReuseIdentifier:sightSpotHeaderBottomCollectionViewCellID];
    self.headerBottomCollectionView.backgroundColor = [UIColor whiteColor];
    
}
- (void)setConstraintsOnSubViews{
    self.headerImageView.frame = CGRectMake(0, 0, kWidthScreen, self.headerImageViewH);
//    self.headerImageView.contentMode = UIViewContentModeCenter;
    
    CGFloat collectBtnW = 35;
    CGFloat collectBtnH = 35;
    CGFloat collectBtnY = kY12Margin * 2 + 64;
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-kX12Margin);
        make.size.mas_equalTo(CGSizeMake(collectBtnW, collectBtnH));
        make.top.mas_equalTo(self).mas_offset(collectBtnY);
    }];

    CGFloat titleLabelH = kHeightText40;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kX12Margin);
        make.top.mas_equalTo(self.collectBtn);
        make.right.mas_equalTo(self.collectBtn.mas_left).mas_offset(-kX12Margin);
        make.height.mas_equalTo(titleLabelH);
    }];
    
    CGFloat addressLabelH = kHeightText20;
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(addressLabelH);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressLabel.mas_right).mas_offset(10);
        make.top.bottom.mas_equalTo(self.addressLabel);
        make.width.mas_equalTo(1.5);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(10);
        make.top.bottom.mas_equalTo(self.addressLabel);
    }];
    
    CGFloat expenseLabelH = kHeightText30;
    [self.expenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.addressLabel.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(expenseLabelH);
    }];

    [self.headerBottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.headerImageView.mas_bottom);
        make.height.mas_equalTo(self.bottomViewH);
    }];
}

- (void)setViews{
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = kText40Font25Height;
    
    self.addressLabel.textColor = [UIColor whiteColor];
    self.addressLabel.font = kText20Font12Height;
    
    
    self.distanceLabel.textColor = [UIColor whiteColor];
    self.distanceLabel.font = kText20Font12Height;

    self.lineView.backgroundColor = [UIColor whiteColor];
    
    self.expenseLabel.textColor = kGreen34Color;
    self.expenseLabel.font = kText30Font19Height;
}
- (void)setModel:(YYSightSpotModel *)model{
    _model = model;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.spotInnerImgurl]];
    
    self.titleLabel.text = model.spotTitle;
    
    
    NSDictionary *attr = @{
                           NSFontAttributeName : kText20Font12Height,
                           };
    NSString *spotDistanceStr = [NSString distanceStrWithDistanceStr:model.spotDistance];
    
    CGFloat spotDistanceLabelW = [spotDistanceStr calculateWidthStringWithAttr:attr andMaxWidth:100 andMaxHeight:14] + 1;
    
    [self.distanceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spotDistanceLabelW);
    }];
    
    self.distanceLabel.text = spotDistanceStr;
    
    
    CGFloat spotAddressLabelMaxW = kWidthScreen - kX12Margin * 2 - 5 - 14 - 6 - 1 - 6 - spotDistanceLabelW;
    CGFloat spotAddressLabelW = [model.spotAddress calculateWidthStringWithAttr:attr andMaxWidth:spotAddressLabelMaxW andMaxHeight:14] + 1;
    [self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spotAddressLabelW);
    }];
    self.addressLabel.text = model.spotAddress;
    
    //设置人均消费
    NSString *expense = [NSString stringWithFormat:@"¥%.0f/人均", model.spotExpense];
    NSMutableAttributedString *expenseAttrString = [[NSMutableAttributedString alloc] initWithString:expense];
    
    NSRange leftRange = [expense rangeOfString:@"¥"];
    
    NSRange rightRange = [expense rangeOfString:@"/人均"];
    [expenseAttrString addAttribute:NSFontAttributeName value:kText20Font12Height range:leftRange];
    [expenseAttrString addAttribute:NSFontAttributeName value:kText20Font12Height range:rightRange];
    self.expenseLabel.attributedText = expenseAttrString;

}
@end


#pragma mark YYSightSpotHeaderBottomCollectionViewCell类

@interface YYSightSpotHeaderBottomCollectionViewCell ()

@property (nonatomic, weak) UIImageView *leftImageView;

@property (nonatomic, weak) UILabel *rightLabel;

@property (nonatomic, weak) UIView *centerView;
@end


@implementation YYSightSpotHeaderBottomCollectionViewCellModel



@end

@implementation YYSightSpotHeaderBottomCollectionViewCell
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *centerView = [[UIView alloc] init];
        [self.contentView addSubview:centerView];
        self.centerView = centerView;
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.mas_equalTo(self.contentView);
        }];
        
        
        UIImageView *leftImageView = [[UIImageView alloc] init];
        [self.centerView addSubview:leftImageView];
        self.leftImageView = leftImageView;
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.centerView);
        }];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        [self.centerView addSubview:rightLabel];
        self.rightLabel = rightLabel;
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.leftImageView);
            make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.centerView.mas_right);
        }];
        self.rightLabel.font = kText20Font12Height;
        self.rightLabel.textColor = kBlack56Color;
    }
    return self;
}

- (void)setModel:(YYSightSpotHeaderBottomCollectionViewCellModel *)model{
    _model = model;

    NSDictionary *attr = @{
                           NSFontAttributeName : kText20Font12Height,
                           };
    CGFloat titleLabelW = [model.title calculateWidthStringWithAttr:attr andMaxWidth:100 andMaxHeight:15] + 1;
    
    CGFloat centerViewW = titleLabelW + model.imageW + 5;
    [self.centerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(centerViewW);
    }];
    [self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(model.imageW);
    }];
    
    self.leftImageView.image = [UIImage imageNamed:model.imageName];
    
    self.rightLabel.text = model.title;

}
@end
