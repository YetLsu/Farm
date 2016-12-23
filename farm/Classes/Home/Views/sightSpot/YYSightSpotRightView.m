//
//  YYSightSpotRightView.m
//  farm
//
//  Created by wyy on 2016/12/22.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSightSpotRightView.h"

@interface YYSightSpotRightView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) CGFloat cellH;

@end

@implementation YYSightSpotRightView
- (instancetype)initWithTitleArray:(NSArray *)titleArray andViewW:(CGFloat)viewW{
    if (self = [super initWithFrame:CGRectZero]) {
        self.titleArray = titleArray;
        self.backgroundColor = [UIColor whiteColor];
        //增加左边的View
        UIView *leftView = [[UIView alloc] init];
        [self addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(kX12Margin);
        }];
        leftView.backgroundColor = kViewBGColor;
        
        //增加顶部的View
        CGFloat topImageViewH = 70;
        UIImageView *topImageView = [[UIImageView alloc] init];
        [self addSubview:topImageView];
        topImageView.image = [UIImage imageNamed:@"spot_rightView_top_icon"];
        [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(20);
            make.height.mas_equalTo(topImageViewH);
            make.left.mas_equalTo(leftView.mas_right);
            make.right.mas_equalTo(self);
        }];
        topImageView.contentMode = UIViewContentModeCenter;
        topImageView.backgroundColor = [UIColor whiteColor];
        
        //增加tableView
        self.cellH = kY12Margin * 4 + kHeightText22;
        CGFloat tableViewH = self.cellH * titleArray.count;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.left.mas_equalTo(topImageView);
            make.top.mas_equalTo(topImageView.mas_bottom);
            make.height.mas_equalTo(tableViewH);
        }];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = kGreen34Color;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        
        //增加底部的view
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(tableView);
            make.bottom.mas_equalTo(self);
            make.top.mas_equalTo(tableView.mas_bottom);
        }];
        bottomView.backgroundColor = kGreen34Color;
        //在底部的View中增加竖线
        UIView *lineView = [[UIView alloc] init];
        [bottomView addSubview:lineView];
        lineView.backgroundColor = [UIColor whiteColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tableView).mas_offset(12);
            make.top.bottom.mas_equalTo(bottomView);
            make.width.mas_equalTo(1);
        }];
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYSightSpotRightTableViewCell *cell = [YYSightSpotRightTableViewCell sightSpotRightTableViewCellWithTableView:tableView];
    cell.nameLabel.text = self.titleArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation YYSightSpotRightTableViewCell

+ (instancetype)sightSpotRightTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSightSpotRightTableViewCell";
    YYSightSpotRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYSightSpotRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kGreen34Color;
        //增加竖线中间的圆
        UIView *circleView = [[UIView alloc] init];
        [self.contentView addSubview:circleView];
        circleView.backgroundColor = [UIColor whiteColor];
        [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(5, 5));
            make.left.mas_equalTo(self.contentView).mas_offset(10);
        }];
        circleView.layer.cornerRadius = 2.5;
        circleView.layer.masksToBounds = YES;
        
        //增加竖线
        CGFloat lineOffset = (kHeightText22 - 5)/2.0;
        UIView *topLineView = [[UIView alloc] init];
        [self.contentView addSubview:topLineView];
        topLineView.backgroundColor = [UIColor whiteColor];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(circleView.mas_top).mas_offset(-lineOffset);
            make.width.mas_equalTo(1);
            make.left.mas_equalTo(circleView.mas_left).mas_offset(2);
        }];
        
        UIView *bottomLineView = [[UIView alloc] init];
        [self.contentView addSubview:bottomLineView];
        bottomLineView.backgroundColor = [UIColor whiteColor];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(circleView.mas_bottom).mas_offset(lineOffset);
            make.width.mas_equalTo(1);
            make.left.mas_equalTo(topLineView);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.nameLabel = label;
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(circleView.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView).mas_offset(-5);
            make.centerY.mas_equalTo(circleView);
            make.height.mas_equalTo(kHeightText22);
        }];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = kText22Font14Height;
    }
    
    return self;
}

@end
