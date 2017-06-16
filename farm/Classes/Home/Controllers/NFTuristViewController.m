//
//  NFTuristViewController.m
//  farm
//
//  Created by guest on 17/2/28.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFTuristViewController.h"

@interface NFTuristViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *visitorNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *uploadTimeLabel;

@end

@implementation NFTuristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData:self.spotid];
    _webView.scrollView.bounces = NO;
}
#pragma mark - navigation
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)setupNavigation{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"play_share.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
}

- (void)shareAction{}

- (void)requestData:(NSString *)spotid{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"spotid"] = self.spotid;
    __weak typeof (self) weakSelf = self;
    [NSObject GET:@"http://nc.guonongda.com:8808/app/travelnotes/getTravelNotesBySpotid.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        NSMutableDictionary *dataM = responseObject[@"data"];
        [weakSelf.postImageView sd_setImageWithURL:[NSURL URLWithString:dataM[@"innerImgurl"]] placeholderImage:nil options:SDWebImageRetryFailed];
        weakSelf.titleLabel.text = dataM[@"title"];
        weakSelf.visitorNameLabel.text = dataM[@"visitor_name"];
        [weakSelf.userImageView sd_setImageWithURL:[NSURL URLWithString:dataM[@"visitor_headimgurl"]] placeholderImage:nil options:SDWebImageRetryFailed];
        weakSelf.uploadTimeLabel.text = dataM[@"uploading_time"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dataM[@"contenturl"]]];
        [weakSelf.webView loadRequest:request];
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
