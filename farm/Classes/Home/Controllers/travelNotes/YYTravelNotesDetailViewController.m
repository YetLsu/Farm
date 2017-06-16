//
//  YYTravelNotesDetailViewController.m
//  farm
//
//  Created by wyy on 2016/12/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTravelNotesDetailViewController.h"

#import "YYHomeTravelNotesModel.h"

#import "YYTravelNotesDetailNavView.h"

#import <WebKit/WebKit.h>
#import "YYDiscoverBottomView.h"

@interface YYTravelNotesDetailViewController ()

@property (nonatomic, strong) YYHomeTravelNotesModel *model;

@end

@implementation YYTravelNotesDetailViewController

- (instancetype)initWithModel:(YYHomeTravelNotesModel *)model{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBGColor;
    
    CGFloat height = 175;
    YYTravelNotesDetailNavView *headerView = [[YYTravelNotesDetailNavView alloc] initWithModel:self.model andHeight:height];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
    
    //增加返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(36);
    }];
    [backBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat bottomViewH = 46;
    YYDiscoverBottomView *bottomView = [[YYDiscoverBottomView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomViewH);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.centerLineViewColor = kGreen34Color;
    bottomView.titleColor = kGreen34Color;
    bottomView.commentImage = [UIImage imageNamed:@"discover_comment_green"];
    bottomView.praiseImage = [UIImage imageNamed:@"discover_praise_green"];
    
    bottomView.commentNumStr = [NSString stringWithFormat:@"%d", self.model.commentNum];
    bottomView.praiseNumStr = [NSString stringWithFormat:@"%d", self.model.praiseNum];
    [bottomView setYYBtnClick:^(NSInteger tag) {
        if (tag == 0) {
#warning TODO 游记的评论
            YYLog(@"评论");
            
        }
        else if (tag == 1) {
            YYLog(@"点赞");
        }
    }];
    
    //增加WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.travelContenturl]]];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(height);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];

    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
