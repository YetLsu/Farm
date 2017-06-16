//
//  YYTabBarController.m
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTabBarController.h"
#import "YYHomeTableViewController.h"
#import "YYPlayViewController.h"
#import "YYProfileViewController.h"
#import "YYNavigationController.h"
#import "NFMeViewController.h"

@interface YYTabBarController ()

@end

@implementation YYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    YYHomeTableViewController *home = [[YYHomeTableViewController alloc] init];
    [UIImage imageNamed:@"tabbar_home_nor"];
    [self addChildControllerWithChildController:home image:[UIImage imageNamed:@"tabbar_home_nor"] selectImage:[UIImage imageNamed:@"tabbar_home_sel"] title:@"首页"];
   
    YYPlayViewController *discover = [[YYPlayViewController alloc] init];
    [self addChildControllerWithChildController:discover image:[UIImage imageNamed:@"tabbar_play_nor"] selectImage:[UIImage imageNamed:@"tabbar_play_sel"] title:@"发现"];
    
//    YYProfileViewController *profile = [[YYProfileViewController alloc] init];
    
    NFMeViewController *me = [[NFMeViewController alloc] init];
    [self addChildControllerWithChildController:me image:[UIImage imageNamed:@"tabbar_profile_nor"] selectImage:[UIImage imageNamed:@"tabbar_profile_sel"] title:@"我的"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
    
}

- (void)addChildControllerWithChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selImage title:(NSString *)title{
//    YYLog(@"%@",title);
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.title = title;
    
    NSMutableDictionary *attrHigh = [NSMutableDictionary dictionary];
    attrHigh[NSForegroundColorAttributeName] = kRGBAColor(34, 187, 98, 1);
    [vc.tabBarItem setTitleTextAttributes:attrHigh forState:UIControlStateSelected];
    
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSForegroundColorAttributeName] = kRGBAColor(188, 188, 188, 1);
    
    [vc.tabBarItem setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
    
    
    YYNavigationController *nav = [[YYNavigationController alloc] initWithRootViewController:vc];
    
    
    [self addChildViewController:nav];
    
}


@end
