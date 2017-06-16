//
//  YYTravelNotesDetailNavView.m
//  farm
//
//  Created by wyy on 2016/12/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTravelNotesDetailNavView.h"

#import "YYHomeTravelNotesModel.h"

@interface YYTravelNotesDetailNavView ()

@property (nonatomic, strong) YYHomeTravelNotesModel *model;

@end

@implementation YYTravelNotesDetailNavView

- (instancetype)initWithModel:(YYHomeTravelNotesModel *)model andHeight:(CGFloat)height{
    if (self = [super initWithFrame:CGRectZero]) {
        self.model = model;
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, height)];
        [bgImageView sd_setImageWithURL:[NSURL URLWithString:self.model.travelInnerImgurl]];
        [self addSubview:bgImageView];
        
        
        CGFloat titleLabelW = kWidthScreen - kX12Margin * 2;
        CGFloat titleLabelY = 64 + 10;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kX12Margin, titleLabelY, titleLabelW, kHeightText22)];
        titleLabel.font = kText22Font14Height;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        titleLabel.text = self.model.travelTitle;
        
        CGFloat imageViewW = 35;
        CGFloat imageViewY = titleLabelY + kHeightText22 + kY12Margin;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kX12Margin, imageViewY, imageViewW, imageViewW)];
        [self addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.travelVisitorHeadImgurl]];
        imageView.layer.cornerRadius = imageViewW/2.0;
        imageView.layer.masksToBounds = YES;
        
        CGFloat nameLabelX = kX12Margin + imageViewW + 5;
        CGFloat nameLabelH = kHeightText16;
        CGFloat nameLabelW = kWidthScreen - nameLabelX - kX12Margin;
        CGFloat nameLabelY = imageViewY + 5;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
        [self addSubview:nameLabel];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = kText16Font10Height;
        nameLabel.text = self.model.travelVisitorName;
        
        CGFloat timeIconW = 10;
        CGFloat timeIconH = 10;
        CGFloat timeIconX = imageViewW + kX12Margin + 5;
        CGFloat timeIconY = nameLabelY + nameLabelH + 5;
        UIImageView *timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(timeIconX, timeIconY, timeIconW, timeIconH)];
        timeIcon.image = [UIImage imageNamed:@"travelNotes_time_icon_white"];
        [self addSubview:timeIcon];
        
        CGFloat timeLabelX = timeIconX + timeIconW + 5;
        CGFloat timeLabelY = timeIconY;
        CGFloat timeLabelH = timeIconH;
        CGFloat timeLabelW = kWidthScreen - timeLabelX - kX12Margin;
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
        [self addSubview:timeLabel];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = kText14Font9Height;
        timeLabel.textAlignment = NSTextAlignmentLeft;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy.MM.dd hh:mm";
        timeLabel.text = [formatter stringFromDate:model.travelUploadTime];

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
