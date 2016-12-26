//
//  YYSightSpotNearbyTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/24.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotNearbyTableViewCell.h"
#import "YYSightSpotModel.h"

#define itemW (98)

@interface YYSightSpotNearbyTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation YYSightSpotNearbyTableViewCell
+ (instancetype)sightSpotNearbyTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSightSpotNearbyTableViewCell";
    YYSightSpotNearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYSightSpotNearbyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = kViewBGColor;
        //增加collectionView
        CGFloat itemH = 130;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(kY12Margin, kX12Margin, kY12Margin, kX12Margin);
        layout.minimumLineSpacing = kX12Margin;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(kX12Margin);
            make.right.mas_equalTo(self.contentView).mas_offset(-kX12Margin);
            make.top.bottom.mas_equalTo(self.contentView);
        }];
        
        [collectionView registerClass:[YYSightSpotNearbyTableViewCellCollectionViewCell class] forCellWithReuseIdentifier:sightSpotNearbyTableViewCellCollectionViewCellID];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark tableView的headerView中的collectionView的数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYSightSpotNearbyTableViewCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sightSpotNearbyTableViewCellCollectionViewCellID forIndexPath:indexPath];
    
    cell.model = self.modelsArray[indexPath.item];
    
    return cell;
}
@end

@interface YYSightSpotNearbyTableViewCellCollectionViewCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIImageView *topImageView;
//
//@property (nonatomic, weak) UIView *blackView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *addressLabel;

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UILabel *distanceLabel;

@end

@implementation YYSightSpotNearbyTableViewCellCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    
        [self addSubViews];
        
        [self addConstraints];
        
        [self setSubViews];
    }
    return self;
}
- (void)addSubViews{
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UIImageView *topImageView= [[UIImageView alloc] init];
    [self.bgView addSubview:topImageView];
    self.topImageView = topImageView;
    
//    UIView *blackView= [[UIView alloc] init];
//    [self.bgView addSubview:blackView];
//    self.blackView = blackView;
    
    UILabel *nameLabel= [[UILabel alloc] init];
    [self.bgView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *addressLabel= [[UILabel alloc] init];
    [self.bgView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UIView *lineView= [[UIView alloc] init];
    [self.bgView addSubview:lineView];
    self.lineView = lineView;
    
    UILabel *distanceLabel= [[UILabel alloc] init];
    [self.bgView addSubview:distanceLabel];
    self.distanceLabel = distanceLabel;
}
- (void)addConstraints{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    CGFloat addressLabelH = 17;
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(addressLabelH);
        make.bottom.mas_equalTo(self.bgView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressLabel.mas_right).mas_offset(4);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.addressLabel);
        make.height.mas_equalTo(7);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(4);
        make.top.bottom.mas_equalTo(self.addressLabel);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.addressLabel.mas_top);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.topImageView);
        make.height.mas_equalTo(15);
    }];
}

- (void)setSubViews{
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.borderColor = [kGrayLine225Color CGColor];
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.masksToBounds = YES;
    
    self.nameLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = kText16Font10Height;
    
    self.addressLabel.font = kText14Font9Height;
    self.addressLabel.textColor = kGray105Color;
    
    self.distanceLabel.font = kText14Font9Height;
    self.distanceLabel.textColor = kGray105Color;
    
    self.lineView.backgroundColor = kGray105Color;
    
}
- (void)setModel:(YYSightSpotModel *)model{
    _model = model;
    
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.spotOuterImgurl]];
    
    self.nameLabel.text = model.spotTitle;
    
    NSDictionary *attr = @{
                           NSFontAttributeName : kText14Font9Height,
                           };
    NSString *spotDistanceStr = [NSString distanceStrWithDistanceStr:model.spotDistance];
    
    CGFloat spotDistanceLabelW = [spotDistanceStr calculateWidthStringWithAttr:attr andMaxWidth:100 andMaxHeight:14] + 1;
    
    [self.distanceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spotDistanceLabelW);
    }];
    
    self.distanceLabel.text = spotDistanceStr;
    
    
    CGFloat spotAddressLabelMaxW = itemW - 2 * 2 - 4 - 1 - 4 - spotDistanceLabelW;
    CGFloat spotAddressLabelW = [model.spotAddress calculateWidthStringWithAttr:attr andMaxWidth:spotAddressLabelMaxW andMaxHeight:14] + 1;
    
    CGFloat spotAddressLabelLeft = (itemW -4-1-4-spotDistanceLabelW - spotAddressLabelW)/2.0;
    [self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spotAddressLabelW);
        make.left.mas_equalTo(self.bgView).mas_offset(spotAddressLabelLeft);
    }];
    self.addressLabel.text = model.spotAddress;
  
}
@end
