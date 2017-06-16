//
//  YYDiscoverViewController.m
//  farm
//
//  Created by wyy on 2016/12/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverViewController.h"

#import "YYHomeDiscoverModel.h"
#import <WebKit/WebKit.h>

#import "YYDiscoverBottomView.h"
#import "NFCommnetViewController.h"

@interface YYDiscoverViewController ()

@property (nonatomic, strong) YYHomeDiscoverModel *model;
@property (nonatomic, strong) YYDiscoverBottomView *bottomView;
@property (nonatomic, strong) NFAccount *account;

//是否点赞
@property (nonatomic, assign) BOOL isPraise;

@end

@implementation YYDiscoverViewController
- (instancetype) initWithModel:(YYHomeDiscoverModel *)model{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"发现详情";
    self.view.backgroundColor = kViewBGColor;
    NFAccount *account = [NFAccountTool account];
    self.account = account;
    CGFloat bottomViewH = 46;
    YYDiscoverBottomView *bottomView = [[YYDiscoverBottomView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomViewH);
    }];
//    bottomView.commentNumStr = [NSString stringWithFormat:@"%d", 7];
//    bottomView.praiseNumStr = [NSString stringWithFormat:@"%d", 89];
    self.bottomView = bottomView;
    [bottomView setYYBtnClick:^(NSInteger tag) {
        if (tag == 0) {
            YYLog(@"评论");
            NFCommnetViewController *vc = [[NFCommnetViewController alloc] init];
            vc.discoverid = self.model.discoverID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (tag == 1) {
            YYLog(@"点赞");
        }
    }];
    
    
    //增加WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.contentUrl]]];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    parameters[@"username"] = _account.username;
    parameters[@"discoverid"] = [NSString stringWithFormat:@"%d",self.model.discoverID];
    
    
    [NSObject GET:@"http://nc.guonongda.com:8808/app/discover/getCommentAndPraise.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
//        NSLog(@"%@",responseObject);
        NSString *commentNum = [NSString stringWithFormat:@"%@",responseObject[@"commentnum"]];
        NSString *praiseNum = [NSString stringWithFormat:@"%@",responseObject[@"praisenum"]];
        _bottomView.commentNumStr = commentNum;
        _bottomView.praiseNumStr = praiseNum;
        if ([responseObject[@"praise"] intValue] == 900) {
            _isPraise = YES;
        }else{
            _isPraise = NO;
        }
    }];
    
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
