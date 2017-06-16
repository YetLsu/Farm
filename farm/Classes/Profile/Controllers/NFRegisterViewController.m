//
//  NFRegisterViewController.m
//  farm
//
//  Created by guest on 17/2/24.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFRegisterViewController.h"

#define kRegisterUrl @"http://nc.guonongda.com:8808/app/user/regist.do"

@interface NFRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@end

@implementation NFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.registerBtn.backgroundColor = kRGBAColor(46, 185, 102, 1);
    
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 30)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [rightView addSubview:line];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(1, 0, 79, 30);
//    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:button];
//    [self.phoneNumTf setRightView:rightView];
//    [self.phoneNumTf setRightViewMode:UITextFieldViewModeAlways];
    

}
- (IBAction)registerAction:(UIButton *)sender {
    if (![self checkPhoneNum]) {
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = self.phoneNumTf.text;
    parameters[@"password"] = self.passwordTf.text;
    [NFUtils postMutipleRequestWithBaseURL:kRegisterUrl parameters:parameters block:^(id responseObject) {

        long status = [responseObject[@"status"] longValue];
        switch (status) {
            case 0:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"注册成功"];
                [self presentViewController:controller animated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];

            }
                break;
            case 1:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"注册失败"];
                [self presentViewController:controller animated:YES completion:nil];
                
            }
                break;
            case -1:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"出现异常"];
                [self presentViewController:controller animated:YES completion:nil];
            }
                break;
            case 10000:
            {
                UIAlertController *controller = [NFUtils creatAlertWithMessage:@"用户已存在"];
                [self presentViewController:controller animated:YES completion:nil];
            }
                break;
            default:
                break;
        }

    }];
    
    
}
- (BOOL)checkPhoneNum{
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

//- (void)alertMessage:(NSString *)message{
//    UIAlertController *controller = [[UIAlertController alloc] init];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:nil];
//    [controller addAction:action];
//}



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
