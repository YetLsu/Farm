//
//  NFLoginViewController.m
//  farm
//
//  Created by guest on 17/2/24.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFLoginViewController.h"
#import "NFRegisterViewController.h"
#import "NFAccount.h"
#define kLoginUrl @"http://nc.guonongda.com:8808/app/user/login.do"
@interface NFLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@end

@implementation NFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.registerBtn setTitleColor:kRGBAColor(46, 185, 102, 1) forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = kRGBAColor(46, 185, 102, 1);
}
- (IBAction)loginAction:(UIButton *)sender {
    if (![self checkLogin]) {
        [NFUtils creatAlertWithMessage:@"请输入正确的手机号"];
        return;
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = self.phoneNumTf.text;
    parameters[@"password"] = self.passwordTf.text;
    [NFUtils postDataWithBaseURL:kLoginUrl parameters:parameters block:^(id responseObject) {
        long status = [responseObject[@"status"] longValue];
        switch (status) {
            case 0:
            {
//                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"注册成功"];
//                [self presentViewController:controller animated:YES completion:nil];
//                [self.navigationController popViewControllerAnimated:YES];
                NSDictionary *datadict = responseObject[@"data"];
                NFAccount *account = [NFAccount yy_modelWithDictionary:datadict];
                [NFAccountTool saveAccount:account];
                [[NSNotificationCenter defaultCenter] postNotificationName: userLoginNotificationName object:account];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
                break;
            case 1:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"登录失败"];
                [self presentViewController:controller animated:YES completion:nil];
                
            }
                break;
            case -1:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"出现异常"];
                [self presentViewController:controller animated:YES completion:nil];
            }
                break;
            case 10003:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"用户不存在"];
                [self presentViewController:controller animated:YES completion:nil];
            }
                break;
            default:
                break;
        }

        
        
        
//        if ([status isEqualToString:@"0"]) {
//            UIAlertController *controller = [NFUtils creatAlertWithMessage:@"注册成功"];
//            [self presentViewController:controller animated:YES completion:nil];
//            NSDictionary *datadict = responseObject[@"data"];
//            NFAccount *account = [NFAccount yy_modelWithDictionary:datadict];
//            [NFAccountTool saveAccount:account];
//            [[NSNotificationCenter defaultCenter] postNotificationName: userLoginNotificationName object:account];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else if ([status isEqualToString:@"1"]) {
//            UIAlertController *controller = [NFUtils creatAlertWithMessage:@"登录失败"];
//            [self presentViewController:controller animated:YES completion:nil];
//        }else if ([status isEqualToString:@"10003"]) {
//            UIAlertController *controller = [NFUtils creatAlertWithMessage:@"用户不存在，请注册"];
//            [self presentViewController:controller animated:YES completion:nil];
//        }else if ([status isEqualToString:@"-1"]) {
//            UIAlertController *controller = [NFUtils creatAlertWithMessage:@"登录异常"];
//            [self presentViewController:controller animated:YES completion:nil];
//        }
    }];
    
}
- (BOOL)checkLogin{
    if (![NFCheckPhone checkPhone:self.phoneNumTf.text]) {
        UIAlertController *controller = [NFUtils creatAlertWithMessage:@"错误的手机号"];
        [self presentViewController:controller animated:YES completion:nil];
        return false;
    }
    if(!(self.passwordTf.text.length <= 16 && self.passwordTf.text.length != 0 && self.passwordTf.text.length >= 6) ){
        UIAlertController *controller = [NFUtils creatAlertWithMessage:@"密码长度必须在6到16之间"];
        [self presentViewController:controller animated:YES completion:nil];
        return false;
    }
    return true;
}


- (IBAction)registerAction:(UIButton *)sender {
    
     NFRegisterViewController *vc =[[NFRegisterViewController alloc] initWithNibName:@"NFRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
