//
//  YYDiscoverBottomView.m
//  farm
//
//  Created by wyy on 2016/12/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverBottomView.h"

@interface YYDiscoverBottomView ()

@property (nonatomic, weak) UILabel *commentNumLabel;

@property (nonatomic, weak) UILabel *praiseNumLabel;

@property (nonatomic, weak) UIView *commentBtnView;
@property (nonatomic, weak) UIView *praiseBtnView;

@end

@implementation YYDiscoverBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kGreen34Color;
        
        UIButton *commentBtn = [[UIButton alloc] init];
        [self addSubview:commentBtn];
        [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_centerX);
        }];
        [commentBtn bk_addEventHandler:^(id sender) {
            if (self.YYBtnClick) {
                self.YYBtnClick(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIView *commentBtnView = [self creatViewWithLeftImage:[UIImage imageNamed:@"discover_comment_white"] andRightTitle:nil andRightTitleLabelTag:0];
        [commentBtn addSubview:commentBtnView];
        self.commentBtnView = commentBtnView;
        CGFloat btnViewH = 20;
        [commentBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(commentBtn);
            make.height.mas_equalTo(btnViewH);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        lineView.backgroundColor = kGrayLine225Color;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(1);
            make.left.mas_equalTo(commentBtn.mas_right);
        }];
        
        UIButton *praiseBtn = [[UIButton alloc] init];
        [self addSubview:praiseBtn];
        [praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(self);
            make.left.mas_equalTo(lineView.mas_right);
        }];
        
        [praiseBtn bk_addEventHandler:^(id sender) {
            if (self.YYBtnClick) {
                self.YYBtnClick(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIView *praiseBtnView = [self creatViewWithLeftImage:[UIImage imageNamed:@"discover_praise_white"] andRightTitle:nil andRightTitleLabelTag:1];
        [praiseBtn addSubview:praiseBtnView];
        self.praiseBtnView = praiseBtnView;
        [praiseBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(praiseBtn);
            make.height.mas_equalTo(btnViewH);
        }];
    }
    return self;
}

- (UIView *)creatViewWithLeftImage:(UIImage *)leftImage andRightTitle:(NSString *)rightTitle andRightTitleLabelTag:(NSInteger )tag{
    UIView *btnView = [[UIView alloc] init];
    
    CGFloat leftImageViewW = 20;
    UIImageView *leftImageView = [[UIImageView alloc] init];
    [btnView addSubview:leftImageView];
    leftImageView.image = leftImage;
    
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(btnView);
        make.width.mas_equalTo(leftImageViewW);
    }];
    
    UILabel *rightTitleLabel = [[UILabel alloc] init];
    [btnView addSubview:rightTitleLabel];
    [rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(btnView);
        make.left.mas_equalTo(leftImageView.mas_right).mas_offset(5);
    }];
    if (tag == 0) {
        self.commentNumLabel = rightTitleLabel;
    }
    else{
        self.praiseNumLabel = rightTitleLabel;
    }
    rightTitleLabel.textColor = [UIColor whiteColor];
    rightTitleLabel.font = kText18Font11Height;
//    rightTitleLabel.backgroundColor = [UIColor blueColor];
    return btnView;
    
}

- (void)setPraiseNumStr:(NSString *)praiseNumStr{
    _praiseNumStr = praiseNumStr;
    if ([praiseNumStr isEqualToString:@"0"]) {
        return;
    }
    NSDictionary *attr = @{
                           NSFontAttributeName : kText18Font11Height,
                           };
    CGFloat praiseNumLabelW = [praiseNumStr calculateWidthStringWithAttr:attr andMaxWidth:CGFLOAT_MAX andMaxHeight:20];
//    YYLog(@"praiseNumLabelW:%f", praiseNumLabelW);
    CGFloat viewW = 25 + praiseNumLabelW + 0.1;
    [self.praiseBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(viewW);
    }];
    self.praiseNumLabel.text = praiseNumStr;
    
}

- (void)setCommentNumStr:(NSString *)commentNumStr{
    _commentNumStr = commentNumStr;
    if ([commentNumStr isEqualToString:@"0"]) {
        return;
    }
    NSDictionary *attr = @{
                           NSFontAttributeName : kText18Font11Height,
                           };
    CGFloat commentNumLabelW = [commentNumStr calculateWidthStringWithAttr:attr andMaxWidth:CGFLOAT_MAX andMaxHeight:20];
//    YYLog(@"commentNumW:%f", commentNumLabelW);
    CGFloat viewW = 25 + commentNumLabelW + 0.1;
    [self.commentBtnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(viewW);
    }];
    self.commentNumLabel.text = commentNumStr;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
