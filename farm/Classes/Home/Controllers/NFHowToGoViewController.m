//
//  NFHowToGoViewController.m
//  farm
//
//  Created by guest on 17/2/28.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFHowToGoViewController.h"
#import "YYSightSpotModel.h"
@interface NFHowToGoViewController ()
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation NFHowToGoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"如何到达";
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    self.tag = @"乘车";
    [self setupContent];
    
    [self requestData:self.tag];
}
- (void)setupContent{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen, 44)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    CGFloat btnW = kWidthScreen/2.0;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, btnW, 44);
    [button1 setTitle:@"乘车" forState:UIControlStateNormal];
    [button1 setTitleColor:kRGBAColor(46, 185, 102, 1) forState:UIControlStateDisabled];
    button1.enabled = NO;
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(wayChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    _lastBtn = button1;
    [titleView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(btnW, 0, btnW, 44);
    [button2 setTitle:@"自驾" forState:UIControlStateNormal];
    [button2 setTitleColor:kRGBAColor(46, 185, 102, 1) forState:UIControlStateDisabled];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:self action:@selector(wayChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:button2];
    
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, btnW, 1)];
    _indicatorView.backgroundColor = kRGBAColor(46, 185, 102, 1);
    [titleView addSubview:_indicatorView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64 + 44, kWidthScreen, kHeightScreen - 64- 44)];
    _webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
    

}
- (void)wayChangeAction:(UIButton *)button{
    _lastBtn.enabled = !_lastBtn.enabled;
    _lastBtn = button;
    _lastBtn.enabled = NO;
    _tag = button.titleLabel.text;
    CGRect rect = _indicatorView.frame;
    rect.origin.x = _lastBtn.x;
    _indicatorView.frame = rect;
    
    [self requestData:_tag];
    
}

- (void)requestData:(NSString *)tag{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"tag"] = tag;
    parameters[@"spotid"] = self.model.spotID;
    
//    __weak typeof (self)weakself = self;
    [NSObject GET:@"http://nc.guonongda.com:8808/app/spot/getTrans.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        NSString *data = responseObject[@"data"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data]];
        [_webView loadRequest:request];
        if (error) {
            
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
