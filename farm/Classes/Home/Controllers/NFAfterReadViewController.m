//
//  NFAfterReadViewController.m
//  farm
//
//  Created by guest on 17/2/27.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFAfterReadViewController.h"

#define kTrivalReadBeforeUrl @"http://nc.guonongda.com:8808/app/spot/getRequired.do"

@interface NFAfterReadViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation NFAfterReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.tag;
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self requestData];
    
}

- (void)requestData{
    NSString *url = @"http://nc.guonongda.com:8808/app/spot/getRequired.do";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"spotid"] = self.spotid;
    parameters[@"tag"] = self.tag;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    //修改超时时间
    manager.requestSerializer.timeoutInterval = 30;
    [[manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:responseObject[@"data"]]];
        [self.webView loadRequest:request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error : %@",error);
        }
            
    }] resume];
    
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
