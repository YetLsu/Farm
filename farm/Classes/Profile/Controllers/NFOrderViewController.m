//
//  NFOrderViewController.m
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFOrderViewController.h"

@interface NFOrderViewController ()

@end

@implementation NFOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_notopen.png"]];
    imageView.center = self.view.center;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.y + imageView.height + 20, kWidthScreen, 20)];
    label.text = @"暂未开放此功能";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [self.view addSubview:imageView];
    
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
