//
//  NFMeViewController.m
//  farm
//
//  Created by guest on 17/2/28.
//  Copyright © 2017年 NieFan. All rights reserved.
//

#import "NFMeViewController.h"
#import "NFLoginViewController.h"
#import "NFAccount.h"
#import "NFSafeAboutViewController.h"
#import "NFSystemSetViewController.h"
#import "NFOrderViewController.h"
#import "NFMyCollectionViewController.h"

@interface NFMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleOne;
@property (nonatomic, strong) NSArray *titleTwo;
@property (nonatomic, strong) NSArray *imageOne;
@property (nonatomic, strong) NSArray *imageTwo;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *usernameLabel;
@end

@implementation NFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(freshAccount:) name:userLoginNotificationName object:nil];
    
    
    [self setupData];
    
    [self setupTable];
    
    NFAccount *account = [NFAccountTool account];
    if (account.username == nil) {
        self.usernameLabel.text = @"未登录";
    }else{
        self.usernameLabel.text = account.username;
    }

}
- (void)freshAccount:(NSNotification *)center{
    NFAccount *account = center.object;
    if (account.username == nil) {
        self.usernameLabel.text = @"未登录";
    }else{
        self.usernameLabel.text = account.username;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)setupData{
    NSArray *titleOne = @[@"我的订单",@"我的收藏"];
    _titleOne = titleOne;
    NSArray *titleTwo = @[@"安全设置",@"系统设置"];
    _titleTwo = titleTwo;
    NSArray *imageOne = @[@"me_order.png",@"me_collection.png"];
    _imageOne = imageOne;
    NSArray *imageTwo = @[@"me_safe.png",@"me_setting.png"];
    _imageTwo = imageTwo;
}

- (void)setupTable{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kRGBAColor(243, 247, 250, 1);
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 240)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidthScreen - 80)*0.5, (headerView.height - 80)*0.5, 80, 80)];
    userImageView.userInteractionEnabled = YES;
    userImageView.backgroundColor = [UIColor redColor];
    userImageView.layer.cornerRadius = 40;
    userImageView.layer.masksToBounds = YES;
    userImageView.image = [UIImage imageNamed:@"me_test.png"];
    [headerView addSubview:userImageView];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userAction:)];
    [userImageView addGestureRecognizer:tapGR];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kWidthScreen - 200)*0.5, userImageView.y+userImageView.height + 5, 200, 20)];
    usernameLabel.font = [UIFont systemFontOfSize:15];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    //    usernameLabel.text = @"";
    [headerView addSubview:usernameLabel];
    self.usernameLabel = usernameLabel;
    self.tableView.tableHeaderView = headerView;
    
}

- (void)userAction:(UITapGestureRecognizer *)tap{
    NFAccount *account = [NFAccountTool account];
    if (account.username) {
        return;
    }
    NFLoginViewController *vc = [[NFLoginViewController alloc] initWithNibName:@"NFLoginViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NFAccount *account = [NFAccountTool account];
    if (account.username == nil ) {
        UIAlertController *controller = [NFUtils creatAlertWithMessage:@"用户未登录，请先登录！"];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"安全设置"]) {
        NFSafeAboutViewController *safeVc = [[NFSafeAboutViewController alloc] init];
        [self.navigationController pushViewController:safeVc animated:YES];
    }else if ([cell.textLabel.text isEqualToString:@"我的订单"]) {
        NFOrderViewController *orderVc = [[NFOrderViewController alloc] init];
        [self.navigationController pushViewController:orderVc animated:YES];
    }else if ([cell.textLabel.text isEqualToString:@"我的收藏"]) {
        NFMyCollectionViewController *myCollectionVc = [[NFMyCollectionViewController alloc] init];
        [self.navigationController pushViewController:myCollectionVc animated:YES];
    }else if ([cell.textLabel.text isEqualToString:@"系统设置"]) {
        NFSystemSetViewController *sysVc = [[NFSystemSetViewController alloc] init];
        [self.navigationController pushViewController:sysVc animated:YES];
    }
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    }else
        return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _titleOne[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_imageOne[indexPath.row]];
    }else if (indexPath.section == 1){
        cell.textLabel.text = _titleTwo[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_imageTwo[indexPath.row]];
    }else{
        cell.textLabel.text = @"分享App";
        cell.imageView.image = [UIImage imageNamed:@"me_share.png"];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewH = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 15)];
    viewH.backgroundColor = kRGBAColor(243, 247, 250, 1);
    return viewH;
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
