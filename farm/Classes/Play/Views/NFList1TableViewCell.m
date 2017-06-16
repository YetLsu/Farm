//
//  NFList1TableViewCell.m
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFList1TableViewCell.h"
#import "NFPlayListOneModel.h"
#import "YYSightSpotModel.h"

@interface NFList1TableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelOneDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelTwoDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelThreeDistance;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *placesLabelArray;
@property (nonatomic, strong) NSMutableArray *juliLabelArray;

@end


@implementation NFList1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imagesArray = [NSMutableArray array];
    _placesLabelArray = [NSMutableArray array];
    _juliLabelArray = [NSMutableArray array];
    
    [_imagesArray addObject:_imageViewOne];
    [_imagesArray addObject:_imageViewTwo];
    [_imagesArray addObject:_imageViewThree];
    
    [_placesLabelArray addObject:_labelOne];
    [_placesLabelArray addObject:_labelTwo];
    [_placesLabelArray addObject:_labelThree];
    
    [_juliLabelArray addObject:_labelOneDistance];
    [_juliLabelArray addObject:_labelTwoDistance];
    [_juliLabelArray addObject:_labelThreeDistance];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneAction)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwoAction)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThreeAction)];
    [_imageViewOne addGestureRecognizer:tap1];
    [_imageViewTwo addGestureRecognizer:tap2];
    [_imageViewThree addGestureRecognizer:tap3];
}

- (void)delegateAction:(YYSightSpotModel *)model{
    if ([self.delegate respondsToSelector:@selector(list1TableViewCell:andModel:)]) {
        [self.delegate performSelector:@selector(list1TableViewCell:andModel:) withObject:self withObject:model];
    }
}

- (void)tapOneAction{
//    NFPlayListOneModel *model = _data[0];
    YYSightSpotModel *model = _signtArray[0];
    [self delegateAction:model];
}


- (void)tapTwoAction{
//    NFPlayListOneModel *model = _data[1];
    YYSightSpotModel *model = _signtArray[1];
    [self delegateAction:model];
}

- (void)tapThreeAction{
//    NFPlayListOneModel *model = _data[2];
    YYSightSpotModel *model = _signtArray[2];
    [self delegateAction:model];
}
- (void)setSigntArray:(NSArray<YYSightSpotModel *> *)signtArray{
    if (_signtArray != signtArray) {
        _signtArray = signtArray;
    }
    for (int i = 0; i < 3; i++) {
//        NFPlayListOneModel *model = _data[i];
        YYSightSpotModel *model = _signtArray[i];
        [_imagesArray[i] sd_setImageWithURL:[NSURL URLWithString:model.spotOuterImgurl] placeholderImage:nil options:SDWebImageRetryFailed];
        UILabel *juliLabel = _juliLabelArray[i];
        juliLabel.text = [NSString stringWithFormat:@"%@m",model.spotDistance];
        UILabel *placeLabel = _placesLabelArray[i];
        placeLabel.text = model.spotTitle;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
