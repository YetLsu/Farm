//
//  NFChangePwdViewController.m
//  farm
//
//  Created by guest on 17/2/27.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFChangePwdViewController.h"
#import "NFAccount.h"

#define kChangePwdUrl @"http://nc.guonongda.com:8808/app/user/modify.do"

@interface NFChangePwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;

@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


@end

@implementation NFChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.confirmBtn.backgroundColor = kRGBAColor(46, 185, 102, 1) ;   
}
- (IBAction)confirmPwd:(UIButton *)sender {
    if (![self checkPhoneNum]) {
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = self.phoneNumTf.text;
    parameters[@"password"] = self.passwordTf.text;
    [NFUtils postMutipleRequestWithBaseURL:kChangePwdUrl parameters:parameters block:^(id responseObject) {
        
        long status = [responseObject[@"status"] longValue];
        switch (status) {
            case 0:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"修改密码成功"];
                [self presentViewController:controller animated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
                break;
            case 1:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"修改密码失败"];
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
            case 10004:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"重置密码为空"];
                [self presentViewController:controller animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
        
    }];
}

- (BOOL)checkPhoneNum{
    NFAccount *account = [NFAccountTool account];
    
    if (![account.username isEqualToString:self.phoneNumTf.text]) {
        UIAlertController *controller = [NFUtils creatAlertWithMessage:@"请输入原手机号"];
        [self presentViewController:controller animated:YES completion:nil];
        return false;
    }
    if (![NFCheckPhone checkPhone:self.phoneNumTf.text]) {
        UIAlertController *controller = [NFUtils creatAlertWithMessage:@"错误的手机格式"];
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
