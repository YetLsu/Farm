//
//  NFList2TableViewCell.m
//  farm
//
//  Created by guest on 17/2/21.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFList2TableViewCell.h"
#import "NFPlayListTwoModel.h"

@interface NFList2TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *placeWenZiOne;
@property (weak, nonatomic) IBOutlet UILabel *placePinYinOne;
@property (weak, nonatomic) IBOutlet UILabel *placeWenZiTwo;
@property (weak, nonatomic) IBOutlet UILabel *placePinYinTwo;
@property (weak, nonatomic) IBOutlet UILabel *placeWenZiThree;
@property (weak, nonatomic) IBOutlet UILabel *placePinYinThree;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (nonatomic, strong) NSMutableArray *wenZiArrray;
@property (nonatomic, strong) NSMutableArray *pinyinArray;

@end

@implementation NFList2TableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewOne.backgroundColor = kRGBAColor(243, 247, 250, 1);
    self.viewTwo.backgroundColor = kRGBAColor(243, 247, 250, 1);
    self.viewThree.backgroundColor = kRGBAColor(243, 247, 250, 1);
    _wenZiArrray = [NSMutableArray array];
    [_wenZiArrray addObject:_placeWenZiOne];
    [_wenZiArrray addObject:_placeWenZiTwo];
    [_wenZiArrray addObject:_placeWenZiThree];
    _pinyinArray = [NSMutableArray array];
    [_pinyinArray addObject:_placePinYinOne];
    [_pinyinArray addObject:_placePinYinTwo];
    [_pinyinArray addObject:_placePinYinThree];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1)];
    [self.viewOne addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2)];
    [self.viewTwo addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction3)];
    [self.viewThree addGestureRecognizer:tap3];
}

- (void)tapAction:(NFPlayListTwoModel *)model{
    if ([self.delegate respondsToSelector:@selector(list2TableViewCell:andModel:)]) {
        [self.delegate performSelector:@selector(list2TableViewCell:andModel:) withObject:self withObject:model];
    }
}

- (void)tapAction1{
    NFPlayListTwoModel *model = _data[0];
    [self tapAction:model];
    
}
- (void)tapAction2{
    NFPlayListTwoModel *model = _data[1];
    [self tapAction:model];
}
- (void)tapAction3{
    NFPlayListTwoModel *model = _data[2];
    [self tapAction:model];
}

- (void)setData:(NSArray *)data{
    if (_data != data) {
        _data = data;
    }
    for (int i=0; i<3; i++) {
        NFPlayListTwoModel *model = data[i];
        UILabel *wzLabel = _wenZiArrray[i];
        wzLabel.text = model.cityname;
        UILabel *pyLabel = _pinyinArray[i];
        pyLabel.text = model.pinyin;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
