//
//  YYNavigationController.m
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYNavigationController.h"

@interface YYNavigationController ()

@end

@implementation YYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor whiteColor]];
    
    navBar.tintColor = [UIColor blackColor];
    navBar.barStyle = UIBarStyleDefault;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *image = [UIImage imageNamed:@"back_black"];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(previousBtnClick)];
        
    }
    
    [super pushViewController:viewController animated:animated];
}
/**
 *  返回按钮被点击
 */
- (void)previousBtnClick{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
