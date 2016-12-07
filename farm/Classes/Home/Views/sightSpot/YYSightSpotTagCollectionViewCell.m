//
//  YYSightSpotTagCollectionViewCell.m
//  farm
//
//  Created by wyy on 2016/12/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotTagCollectionViewCell.h"

@interface YYSightSpotTagCollectionViewCell ()


@end
@implementation YYSightSpotTagCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.tagLabel = label;
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.contentView);
        }];
        
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.tagLabel.layer.borderWidth = 1;
        self.tagLabel.layer.cornerRadius = 3;
        self.tagLabel.layer.masksToBounds = YES;
        
        self.tagLabel.textColor = [UIColor whiteColor];
        self.tagLabel.font = kText16Font10Height;
        
    }
    return self;
}

@end
