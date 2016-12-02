//
//  YYHomeTravelNotesTableViewCell.m
//  farm
//
//  Created by wyy on 2016/12/2.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTravelNotesTableViewCell.h"

#import "YYHomeTravelNotesModel.h"

@interface YYHomeTravelNotesTableViewCell ()
//外图
@property (nonatomic, weak) UIImageView *travelOuterImageView;
//标签
@property (nonatomic, weak) UILabel *travelTagLabel;
//游记标题
@property (nonatomic, weak) UILabel *travelTitleLabel;
//时间图标
@property (nonatomic, weak) UIImageView *travelTimeImageView;
//上传时间
@property (nonatomic, weak) UILabel *travelTimeLabel;
//观看人数图标
@property (nonatomic, weak) UIImageView *travelVisitNumImageView;
//访问量
@property (nonatomic, weak) UILabel *travelVisitNumLabel;

@end
@implementation YYHomeTravelNotesTableViewCell
+ (instancetype)homeTravelNotesTabelViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYHomeTravelNotesTableViewCell";
    
    YYHomeTravelNotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYHomeTravelNotesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //增加views
        [self addSubViews];
        //增加约束
        [self addConstraintsOnSubViews];
        
        [self setSubViews];
    }
    return self;
}
- (void)addSubViews{
    //外图
    UIImageView *travelOuterImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:travelOuterImageView];
    self.travelOuterImageView = travelOuterImageView;
    //标签
    UILabel *travelTagLabel = [[UILabel alloc] init];
    [self.contentView addSubview:travelTagLabel];
    self.travelTagLabel = travelTagLabel;
    //游记标题
    UILabel *travelTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:travelTitleLabel];
    self.travelTitleLabel = travelTitleLabel;
    //时间图标
    UIImageView *travelTimeImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:travelTimeImageView];
    self.travelTimeImageView = travelTimeImageView;
    //上传时间
    UILabel *travelTimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:travelTimeLabel];
    self.travelTimeLabel = travelTimeLabel;
    //观看人数图标
    UIImageView *travelVisitNumImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:travelVisitNumImageView];
    self.travelVisitNumImageView = travelVisitNumImageView;
    //访问量
    UILabel *travelVisitNumLabel = [[UILabel alloc] init];
    [self.contentView addSubview:travelVisitNumLabel];
    self.travelVisitNumLabel = travelVisitNumLabel;

}
//增加约束
- (void)addConstraintsOnSubViews{
    
    CGFloat travelOuterImageViewH = 200;
    [self.travelOuterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(kX12Margin);
        make.right.mas_equalTo(self.contentView).mas_offset(-kX12Margin);
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(travelOuterImageViewH);
    }];
    
    CGFloat travelTagLabelW = 55;
    CGFloat travelTagLabelH = 20;
    [self.travelTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.travelOuterImageView);
        make.size.mas_equalTo(CGSizeMake(travelTagLabelW, travelTagLabelH));
    }];
    
    CGFloat travelTitleLabelH = 12;
    [self.travelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.travelOuterImageView.mas_bottom).mas_offset(kY12Margin);
        make.left.right.mas_equalTo(self.travelOuterImageView);
        make.height.mas_equalTo(travelTitleLabelH);
    }];
    
    CGFloat timeImageViewW = 10;
    CGFloat timeImageViewH = 10;
    CGFloat timeImageViewTop = 10;
    [self.travelTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(timeImageViewW, timeImageViewH));
        make.left.mas_equalTo(self.travelOuterImageView);
        make.top.mas_equalTo(self.travelTitleLabel.mas_bottom).mas_offset(timeImageViewTop);
    }];
    
    CGFloat travelTimeLabelW = 80;
    [self.travelTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.travelTimeImageView.mas_right).mas_offset(4);
        make.top.bottom.mas_equalTo(self.travelTimeImageView);
        make.width.mas_equalTo(travelTimeLabelW);
    }];
    
    CGFloat visitNumImageViewW = 15.5;
    CGFloat visitNumImageViewH = timeImageViewH;
    [self.travelVisitNumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(visitNumImageViewW, visitNumImageViewH));
        make.top.mas_equalTo(self.travelTimeImageView);
        make.left.mas_equalTo(self.travelTimeLabel.mas_right).mas_offset(kX12Margin);
    }];
    
    [self.travelVisitNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.travelVisitNumImageView.mas_right).mas_offset(4);
        make.top.bottom.mas_equalTo(self.travelVisitNumImageView);
        make.right.mas_equalTo(self.travelOuterImageView);
    }];
    
}
- (void)setSubViews{
    self.travelTagLabel.font = kText16Font10Height;
    self.travelTagLabel.textAlignment = NSTextAlignmentCenter;
    self.travelTagLabel.textColor = [UIColor whiteColor];
    
    self.travelTitleLabel.font = kText20Font12Height;
    self.travelTitleLabel.textColor = kBlack56Color;
    
    self.travelTimeLabel.textColor = kGray188Color;
    self.travelTimeLabel.font = kText14Font9Height;
    
    self.travelVisitNumLabel.textColor = kGray188Color;
    self.travelVisitNumLabel.font = kText14Font9Height;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(YYHomeTravelNotesModel *)model{
    _model = model;
    if (model) {
        self.travelTagLabel.backgroundColor = kRGBAColor(248, 100, 0, 1);
        self.travelTimeImageView.image = [UIImage imageNamed:@"home_time_icon"];
        self.travelVisitNumImageView.image = [UIImage imageNamed:@"home_visitNum_icon"];
        
        self.travelVisitNumLabel.text = [NSString stringWithFormat:@"%d", model.travelVisitNum];
    }
    self.travelOuterImageView.image = [UIImage imageNamed:model.travelOuterImgurl];
    self.travelTitleLabel.text = model.travelTitle;
    self.travelTagLabel.text = model.travelTag;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    self.travelTimeLabel.text = [formatter stringFromDate:model.travelUploadTime];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
