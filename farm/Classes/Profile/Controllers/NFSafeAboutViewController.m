//
//  NFSafeAboutViewController.m
//  farm
//
//  Created by guest on 17/2/25.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFSafeAboutViewController.h"
#import "NFChangePwdViewController.h"
#import "NFAccount.h"
@interface NFSafeAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NFSafeAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen, 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    [self.view addSubview:_tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kWidthScreen - 160)*0.5, kHeightScreen - 30 - 240, 160, 30);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];
    
    
}

- (void)logout{
    [NFAccountTool removeAccount];
    NFAccount *account = [[NFAccount alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:userLoginNotificationName object:account];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = @"修改密码";
    cell.imageView.image = [UIImage imageNamed:@"me_change_paw.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NFChangePwdViewController *changePwdVc = [[NFChangePwdViewController alloc] initWithNibName:@"NFChangePwdViewController" bundle:nil];
    [self.navigationController pushViewController:changePwdVc animated:YES];
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
